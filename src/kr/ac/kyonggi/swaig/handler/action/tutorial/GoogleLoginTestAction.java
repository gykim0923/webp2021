//package kr.ac.kyonggi.swaig.handler.action.tutorial;
//
//import kr.ac.kyonggi.swaig.common.controller.Action;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.BufferedReader;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//
//public class GoogleLoginTestAction implements Action {
//
//    @Override
//    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        BufferedReader in  = null;
//        InputStream is = null;
//        InputStreamReader isr = null;
//        JSONParser jsonParser = new JSONParser();
//
////        String param = request.getParameter("idtoken");
////        System.out.println(param);
//        String userId = null;
//
//        try {
////            String idToken = param.split("=")[1];
//            String idToken = request.getParameter("idtoken");
//            String url = "https://oauth2.googleapis.com/tokeninfo";
//            url += "?id_token="+idToken;
//
//            URL gUrl = new URL(url);
//            HttpURLConnection conn = (HttpURLConnection) gUrl.openConnection();
//
//            is = conn.getInputStream();
//            isr = new InputStreamReader(is, "UTF-8");
//            in = new BufferedReader(isr);
//
//
//            JSONObject jsonObj = (JSONObject)jsonParser.parse(in);
//
//            userId = jsonObj.get("sub").toString();
//            String name = jsonObj.get("name").toString();
//            String email = jsonObj.get("email").toString();
//            String imageUrl = jsonObj.get("picture").toString();
//
//            System.out.println(userId);
//            System.out.println(name);
//            System.out.println(email);
//            System.out.println(imageUrl);
//
//        }catch(Exception e) {
//            System.out.println(e);
//        }
//
//        return userId;
//    }
//}
