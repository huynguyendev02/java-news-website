package com.messi.king.messinews.filters;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.GithubUtils;
import com.messi.king.messinews.utils.GoogleUtils;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AccountFilter")
public class AccountFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("authUser");
        String path = request.getPathInfo();
        System.out.println(path);
        switch (path) {
            case "/Profile":
                if ((boolean)session.getAttribute("auth")==false) {
                    ServletUtils.redirect("/Account/Login", request, (HttpServletResponse) res);
                    return;
                }
                break;
            case "/Password":
                if ((boolean)session.getAttribute("auth")==false) {
                    ServletUtils.redirect("/Account/Login", request, (HttpServletResponse) res);
                    return;
                }
                break;
            case "/Login":
                request.setAttribute("googleLogin", GoogleUtils.getAuthURL());
                request.setAttribute("githubLogin", GithubUtils.getAuthURL());

                if ((boolean)session.getAttribute("auth")==true) {
                    ServletUtils.redirect("/Account/Profile", request, (HttpServletResponse) res);
                    return;
                }
                break;
            case "/GLogin":
                if (req.getParameter("code")==null){
                    ServletUtils.redirect("/Account/Login", request, (HttpServletResponse) res);
                    return;
                }
                break;
            case "/GitLogin":
                if (req.getParameter("code")==null){
                    ServletUtils.redirect("/Account/Login", request, (HttpServletResponse) res);
                    return;

                }
                break;
        }
        chain.doFilter(req, res);
    }
}
