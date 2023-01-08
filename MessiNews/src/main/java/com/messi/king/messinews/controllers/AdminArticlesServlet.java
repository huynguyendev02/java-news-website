package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.*;
import com.messi.king.messinews.utils.PdfUtils;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "AdminArticlesServlet", value = "/Admin/Articles/*")
public class AdminArticlesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();

        switch (url) {
            case "/Upload":
                List<Tags> tagsList = TagsService.findAll();
                request.setAttribute("tags", tagsList);
                ServletUtils.forward("/views/vwWriter/Upload.jsp",request,response);
                break;
            case "/ListDraft":
                List<Articles> artsDraft = EditorService.findAllDraft();
                request.setAttribute("articlesList", artsDraft);
                ServletUtils.forward("/views/vwAdmin/ArticleDraftAdminList.jsp", request, response);
                break;
            case "/ListComplete":
                List<Articles> artsComplete = EditorService.findAllComplete();
                request.setAttribute("articlesList", artsComplete);
                ServletUtils.forward("/views/vwAdmin/ArticleCompleteAdminList.jsp", request, response);
                break;
            case "/Accept":
                getAccept(request,response);
                break;
            case "/Deny":
                getDeny(request,response);
                break;
            case "/ViewArticle":
                getViewArticle(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    private void getAccept(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<Tags> tagsList = TagsService.findAll();
        Articles article = ArticlesService.findById(id);
        List<Categories> catList = CategoriesService.findAll();

        request.setAttribute("Categories", catList);
        request.setAttribute("article", article);
        request.setAttribute("tags", tagsList);
        ServletUtils.forward("/views/vwEditor/Accept.jsp", request, response);
    }

    private void getDeny(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Articles article = ArticlesService.findById(id);
        request.setAttribute("article", article);
        ServletUtils.forward("/views/vwEditor/Deny.jsp", request, response);
    }
    private void getViewArticle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Articles article = ArticlesService.findById(id);
        List<Tags> tags = TagsService.findTagByArticle(id);

        request.setAttribute("article", article);
        request.setAttribute("tags", tags);
        ServletUtils.forward("/views/vwEditor/ViewArticle.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        switch (url) {
            case "/Accept":
                int id=0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    ServletUtils.redirect("/views/204.jsp", request, response);
                }
                request.getParameter("premium");
                request.getParameter("publish_time");
                request.getSession().getAttribute("listTagId");
//                EditorService.acceptArticle();

                Articles art = ArticlesService.findById(id);
                PdfUtils.createPdfFile(art, request,response);


                ServletUtils.redirect("/Editor/List", request,response);
                break;
            case "/Deny":
                request.getAttribute("id");
                request.getParameter("reason");

//                EditorService.declineArticle(id,reason);
                ServletUtils.redirect("/Editor/List", request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }
}
