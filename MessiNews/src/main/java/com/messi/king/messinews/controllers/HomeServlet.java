package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.services.ArticlesService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/Home/*")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        if (url == null || url.equals("/")) {
            url = "/";
        }
        switch (url) {
            case "/":
                ServletUtils.forward("/views/vwGeneral/General.jsp",request,response);
                break;
            case "/Details":
                int id=0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                System.out.print(id);
                Articles art = ArticlesService.findById(id);
                if (art!=null) {
                    request.setAttribute("article",art);
                    ServletUtils.forward("/views/vwGeneral/Details.jsp",request,response);
                } else {
                    ServletUtils.redirect("/views/204.jsp", request, response);
                }
                break;
            case "/ByParentCat":
                getArticlesAndForward(1, request, response);
                break;
            case "/ByCat":
                getArticlesAndForward(2, request, response);
                break;
            case "/ByTag":
                getArticlesAndForward(3, request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    private void getArticlesAndForward(int service, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        List<Articles> arts = null;
        switch (service){
            case 1:
                arts = ArticlesService.findByPCatId(id);
                break;
            case 2:
                arts = ArticlesService.findByCatId(id);
                break;
            case 3:
                arts = ArticlesService.findByTagId(id);
                break;
        }
        request.setAttribute("articles",arts);
        ServletUtils.forward("/views/vwGeneral/Topic.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
