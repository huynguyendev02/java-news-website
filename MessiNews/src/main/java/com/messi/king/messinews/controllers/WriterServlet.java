package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.ArticlesService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "WriterServlet", value = "/Writer/*")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 *1024,
        maxFileSize = 50*1024*1024,
        maxRequestSize = 50*1024*1024
)
public class WriterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        switch (url) {
            case "/List":
//                Users user = (Users) session.getAttribute("authUser");
//                List<Articles> articlesList = ArticlesService.findByWriterId(user.getId());
//                request.setAttribute("articlesList", articlesList);

                List<Articles> articlesList = ArticlesService.top10AllCate();
                request.setAttribute("articlesList", articlesList);
                ServletUtils.forward("/views/vwWriter/List.jsp",request,response);
                break;
            case "/Upload":
                ServletUtils.forward("/views/vwWriter/Upload.jsp",request,response);
                break;
            case "/Edit":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Articles art = ArticlesService.findById(id);
                request.setAttribute("art", art);
                ServletUtils.forward("/views/vwWriter/Edit.jsp",request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        switch (url) {
            case "/Upload":
                upload(request,response);
                break;
            case "/Edit":
                edit(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) {

    }

    private void upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String abstractContent = request.getParameter("abstract");
        String content = request.getParameter("content");

        System.out.println(title);
        System.out.println(abstractContent);
        System.out.println(content);
        int cateId = 0;
        int premium =0;
        try {
            cateId = Integer.parseInt(request.getParameter("cateId"));
            premium = Integer.parseInt(request.getParameter("premium"));
        } catch (NumberFormatException e) {
        }

        int artId = ArticlesService.add(new Articles(0,title,null,0,abstractContent,content,cateId,premium,((Users)request.getSession().getAttribute("authUser")).getId(),-1, null));

        String targetDir = this.getServletContext().getRealPath("photos/articles/"+artId);
        File dir = new File(targetDir);
        if (!dir.exists()) {
            dir.mkdir();
        }
        String destination = "";
        for (Part part: request.getParts()) {
            if (part.getName().equals("imgMain")) {
                destination = targetDir + "/" + "a.png";
                part.write(destination);
            }
            if (part.getName().equals("backgroundMain")) {
                destination = targetDir + "/" + "b.png";
                part.write(destination);
            }
        }
    }
}
