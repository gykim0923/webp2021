package kr.ac.kyonggi.swaig.common.filter;

import com.google.gson.Gson;
import kr.ac.kyonggi.swaig.handler.dao.settings.HomeDAO;
import kr.ac.kyonggi.swaig.handler.dao.user.UserDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class SFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)   throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(true);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("P3P","CP='CAO PSA CONI OTR OUR DEM ONL'");


        if(session.getAttribute("type") == null) {
            Gson gson = new Gson();
            session.setAttribute("type", gson.toJson(UserDAO.getInstance().getType("기타")));
//            session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
//            session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
//            response.sendRedirect("Index");
//            return;
        }

        chain.doFilter(request, response);


    }

    @Override
    public void destroy() { }
}
