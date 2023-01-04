package com.messi.king.messinews.filters;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "PermissionFilter")
public class PermissionFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("authUser");
        String path = "/"+request.getServletPath().split("/")[1];

        switch (path) {
            case "/Admin":
                if (user.getRole()!=4) {
                    ServletUtils.forward("/views/403.jsp", request, (HttpServletResponse) res);
                }
                break;
            case "/Editor":
                if (user.getRole()!=3 && user.getRole()!=4) {
                    ServletUtils.forward("/views/403.jsp", request, (HttpServletResponse) res);
                }
                break;
            case "/Writer":
                if (user.getRole()!=2 && user.getRole()!=4) {
                    ServletUtils.forward("/views/403.jsp", request, (HttpServletResponse) res);
                }
                break;
        }

        chain.doFilter(req, res);
    }
}
