package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.*;
import com.messi.king.messinews.services.*;
import com.messi.king.messinews.utils.PdfUtils;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
            case "/ListDraft":
                List<Articles> arts = EditorService.findByEditor(user.getId());
                request.setAttribute("articlesList", arts);
                ServletUtils.forward("/views/vwEditor/ListDraft.jsp", request, response);
                break;
            case "/ListComplete":
                List<Articles> listFull = EditorService.findByEditor(user.getId());
                request.setAttribute("articlesList", listFull);
                ServletUtils.forward("/views/vwEditor/ListComplete.jsp", request, response);
                break;

            case "/Accept":
                int id = Integer.parseInt(request.getParameter("id"));
                List<Tags> tags = TagsService.findAll();
                Articles article = ArticlesService.findById(id);

//                Truyền list CCat mà Editor được quyền
                List<Categories> CatList = new ArrayList<>();
                CatList.add(new Categories(100, "Oh yeah" ,1));
                CatList.add(new Categories(102, "Oh yeah2" ,1));
                CatList.add(new Categories(103, "Oh yeah3" ,1));
                CatList.add(new Categories(104, "Oh yeah4" ,5));
                CatList.add(new Categories(105, "Oh yeah5" ,5));
                CatList.add(new Categories(106, "Oh yeah6" ,5));
                CatList.add(new Categories(107, "Oh yeah7" ,6));

                request.setAttribute("Categories", CatList);
                request.setAttribute("article", article);
                request.setAttribute("tags", tags);
                ServletUtils.forward("/views/vwEditor/Accept.jsp", request, response);
                break;
            case "/Deny":
                int id2 = Integer.parseInt(request.getParameter("id"));
                Articles article2 = ArticlesService.findById(id2);
                request.setAttribute("article", article2);
                ServletUtils.forward("/views/vwEditor/Deny.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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
                ServletUtils.forward("/views/404.jsp", request, response);
        }
    }

    private static void denyArticle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }
        String reason = request.getParameter("reason").trim();
        EditorService.declineArticle(id, reason);
        ServletUtils.redirect("/Editor/ListDraft", request, response);

    }

    private static void acceptArticle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = 0, premium = 0, idCat=0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
            idCat = Integer.parseInt(request.getParameter("idCat"));
            premium = Integer.parseInt(request.getParameter("premium"));
        } catch (NumberFormatException e) {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }


        String publish_timeStr = request.getParameter("publish_time") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime publish_time = LocalDateTime.parse(publish_timeStr, df);


        String[] tagsIdStr = request.getParameter("listTagId")
                .split(",");
        int[] tagsId = Arrays
                .stream(tagsIdStr)
                .mapToInt(Integer::parseInt)
                .toArray();

        EditorService.acceptArticle(id, publish_time, premium,idCat, tagsId);

        Articles art = ArticlesService.findById(id);
        PdfUtils.createPdfFile(art, request, response);

        ServletUtils.redirect("/Editor/ListComplete", request, response);
    }
}
