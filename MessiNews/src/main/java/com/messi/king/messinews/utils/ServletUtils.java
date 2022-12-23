package com.messi.king.messinews.utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletUtils {
    public static void forward(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }

    public static void redirect(String url, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String contextPath = request.getContextPath();
        int idx = url.indexOf(contextPath);
        if (idx < 0) {
            response.sendRedirect(contextPath + url);
        } else {
            response.sendRedirect(url);
        }
    }
}
