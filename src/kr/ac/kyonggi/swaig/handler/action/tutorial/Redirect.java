package kr.ac.kyonggi.swaig.handler.action.tutorial;

import java.io.BufferedReader;
        import java.io.BufferedWriter;
        import java.io.IOException;
        import java.io.InputStream;
        import java.io.InputStreamReader;
        import java.io.OutputStream;
        import java.io.OutputStreamWriter;
        import java.net.URL;
        import javax.servlet.ServletException;
        import javax.servlet.annotation.WebServlet;
        import javax.servlet.http.HttpServlet;
        import javax.servlet.http.HttpServletRequest;
        import javax.servlet.http.HttpServletResponse;
        import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.handler.dto.tutorial.Token;

import javax.net.ssl.HttpsURLConnection;

@WebServlet("/redirect")
public class Redirect extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public Redirect() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String query = "code=" + code;
        query += "&client_id=" + "961716324050-r6i9dib682nsqjotloum1igkvf1jm0og.apps.googleusercontent.com";
        query += "&client_secret=" + "7cHR5EiOZhJp_N3RDEDYr-Bh";
        query += "&redirect_uri=" + "http://localhost:8080/redirect";
        query += "&grant_type=authorization_code";
        System.out.println(query);
        String tokenJson = getHttpConnection("https://accounts.google.com/o/oauth2/token", query);
        System.out.println(tokenJson.toString());
        Gson gson = new Gson();
        Token token = gson.fromJson(tokenJson, Token.class);

        String ret = getHttpConnection("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token.getAccess_token());
        System.out.println(ret);
    }

    private String getHttpConnection(String uri) throws ServletException, IOException {
        URL url = new URL(uri);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        int responseCode = conn.getResponseCode();
        System.out.println("a : "+responseCode);

        String line;
        StringBuffer buffer = new StringBuffer();
        try (InputStream stream = conn.getInputStream()) {
            try (BufferedReader rd = new BufferedReader(new InputStreamReader(stream))) {
                while ((line = rd.readLine()) != null) {
                    buffer.append(line);
                    buffer.append('\r');
                }
            }
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return buffer.toString();
    }

    private String getHttpConnection(String uri, String param) throws ServletException, IOException {
        URL url = new URL(uri);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        try (OutputStream stream = conn.getOutputStream()) {
            try (BufferedWriter wd = new BufferedWriter(new OutputStreamWriter(stream))) {
                wd.write(param);
            }
        }
        int responseCode = conn.getResponseCode();
        System.out.println("b : "+responseCode);

        String line;
        StringBuffer buffer = new StringBuffer();
        try (InputStream stream = conn.getInputStream()) {
            try (BufferedReader rd = new BufferedReader(new InputStreamReader(stream))) {
                while ((line = rd.readLine()) != null) {
                    buffer.append(line);
                    buffer.append('\r');
                }
            }
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return buffer.toString();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
