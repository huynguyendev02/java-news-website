package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.ArticlesService;
import com.messi.king.messinews.services.EditorService;
import com.messi.king.messinews.services.TagsService;
import com.messi.king.messinews.utils.PdfUtils;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "EditorServlet", value = "/Editor/*")
public class EditorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("authUser");

        switch (url) {
            case "/List":
                List <Articles> arts = EditorService.findByEditor(user.getId());
                request.setAttribute("articlesList",arts);
                ServletUtils.forward("/views/vwEditor/List.jsp",request,response);
                break;
            case "/Accept":
                int id = Integer.parseInt(request.getParameter("id"));
                List<Tags> tags = TagsService.findAll();
                Articles article = ArticlesService.findById(id);
                request.setAttribute("article", article);
                request.setAttribute("tags",tags);
                ServletUtils.forward("/views/vwEditor/Accept.jsp",request,response);
                break;
            case "/Deny":
                int id2 = Integer.parseInt(request.getParameter("id"));
                Articles article2 = ArticlesService.findById(id2);
                request.setAttribute("article", article2);
                ServletUtils.forward("/views/vwEditor/Deny.jsp",request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        switch (url) {
            case "/Accept":
                acceptArticle(request, response);
                break;
            case "/Deny":
                denyArticle(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    private static void denyArticle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id=0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }
        String reason = request.getParameter("reason");
        EditorService.declineArticle(id,reason);
        ServletUtils.redirect("/Editor/List", request, response);
    }

    private static void acceptArticle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id=0, premium=0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            premium = Integer.parseInt(  request.getParameter("premium"));
        } catch (NumberFormatException e) {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }


        String publish_timeStr =  request.getParameter("publish_time") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime publish_time = LocalDateTime.parse(publish_timeStr, df);


        String[] tagsIdStr =  request.getParameter("listTagId")
                .split(",");
        int[] tagsId = Arrays
                    .stream(tagsIdStr)
                    .mapToInt(Integer::parseInt)
                    .toArray();
        EditorService.acceptArticle(id, publish_time, premium, tagsId);

        Articles art = ArticlesService.findById(id);
        PdfUtils.createPdfFile(art, request, response);


        ServletUtils.redirect("/Editor/List", request, response);
    }
}
