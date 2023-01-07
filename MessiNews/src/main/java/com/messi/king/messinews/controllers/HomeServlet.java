package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.*;
import com.messi.king.messinews.services.*;
import com.messi.king.messinews.utils.PdfUtils;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
                homePage(request, response);
                break;
            case "/Details":
                details(request, response);
                break;
            case "/ByPCat":
                getArticlesAndForward(1, request, response);
                break;
            case "/ByCat":
                getArticlesAndForward(2, request, response);
                break;
            case "/ByTag":
                getArticlesAndForward(3, request, response);
                break;
            case "/Download":
                download(request, response);
                break;

            case "/Search":

                search(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }

    }

    private static void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("authUser");

        String key = request.getParameter("key");
        String url = request.getPathInfo() + "?key=" + key;
        request.setAttribute("url", url);
        List<Articles> allArticle = ArticlesService.searchArticles(key);
        List<Articles> byTitle = ArticlesService.searchArticlesByTitle(key);
        List<Articles> byAbstract = ArticlesService.searchArticlesByAbs(key);
        List<Articles> byContent = ArticlesService.searchAriclesByContent(key);

        if ((boolean) request.getSession().getAttribute("auth")) {
            if (user.getRole() == 1)
                java.util.Collections.sort(allArticle, new Articles());
            java.util.Collections.sort(byTitle, new Articles());
            java.util.Collections.sort(byAbstract, new Articles());
            java.util.Collections.sort(byContent, new Articles());
        }

//      Type là loại tìm kiếm được gửi về:   1: Tìm hết; 2: Tìm theo title; 3: Tìm theo abs; 4; tìm theo nội dung
//      Page gửi về
        int type = 1, page = 1;
        try {
            type = Integer.parseInt(request.getParameter("type"));
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }
        request.setAttribute("type", type);

        switch (type){
            case 1:
//        Truyền vào trang hiện tại và trang tối đa của danh sách all
                request.setAttribute("currentPage", 1);
                request.setAttribute("maxPage", 10);
                break;
            case 2:
//        Truyền vào trang hiện tại và trang tối đa của danh sách title
                request.setAttribute("currentPage", 2);
                request.setAttribute("maxPage", 20);
                break;
            case 3:
//        Truyền vào trang hiện tại và trang tối đa của danh sách abs
                request.setAttribute("currentPage", 3);
                request.setAttribute("maxPage", 30);
                break;
            case 4:
//        Truyền vào trang hiện tại và trang tối đa của danh sách nội dung
                request.setAttribute("currentPage", 4);
                request.setAttribute("maxPage", 40);
                break;
        }

        request.setAttribute("allArticle", allArticle);
        request.setAttribute("byTitle", byTitle);
        request.setAttribute("byAbstract", byAbstract);
        request.setAttribute("byContent", byContent);

        ServletUtils.forward("/views/vwGeneral/Search.jsp", request, response);
    }

    private static void details(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }

        Articles art = ArticlesService.findById(id);
        if (art != null) {
            if (art.getPremium() == 1) {
                Users user = (Users) request.getSession().getAttribute("authUser");
                if ((boolean) request.getSession().getAttribute("auth") == true) {
                    if (user.getRole() == 1) {
                        int checkTime = user.getIssue_at().plusMinutes(user.getExpiration()).compareTo(LocalDateTime.now());
                        if (checkTime < 0) {
                            ServletUtils.forward("/views/403.jsp", request, response);
                            return;
                        }
                    }
                } else {
                    ServletUtils.forward("/views/403.jsp", request, response);
                    return;
                }
            }
            ArticlesService.viewArticle(id);

            request.setAttribute("article", art);
            request.setAttribute("related", ArticlesService.newsRelated(id));
            request.setAttribute("comments", CommentService.findByArtId(id));

            request.setAttribute("tags", TagsService.findTagByArticle(id));

            ServletUtils.forward("/views/vwGeneral/Details.jsp", request, response);
        } else {
            ServletUtils.forward("/views/204.jsp", request, response);
        }
    }

    private static void homePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("authUser");
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }

        List<Articles> top10AllCate = ArticlesService.top10AllCate();
        List<Articles> top5AllCateInWeek = ArticlesService.top5AllCateInWeek();
        List<Articles> latestNewsAllCate = ArticlesService.latestNewsAllCate();
        if ((boolean) request.getSession().getAttribute("auth")) {
            if (user.getRole() == 1)
                java.util.Collections.sort(latestNewsAllCate, new Articles());
        }
        List<Articles> newest10PerCate = ArticlesService.newest10PerCate();

        request.setAttribute("top10AllCate", top10AllCate);
        request.setAttribute("top5AllCateInWeek", top5AllCateInWeek);

        int startIndex = (page - 1) * 10;
        int endIndex = Math.min((page * 10), latestNewsAllCate.size());

        request.setAttribute("latestNewsAllCate", latestNewsAllCate.subList(startIndex, endIndex));
        request.setAttribute("newest10PerCate", newest10PerCate.subList(0, 10));
//                Số trang tối đa
        int maxPage = (int) Math.ceil((double) latestNewsAllCate.size() / 10);

        request.setAttribute("currentPage", page);
        request.setAttribute("maxPage", maxPage);
        ServletUtils.forward("/views/vwGeneral/General.jsp", request, response);
    }

    private void download(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Users user = (Users) request.getSession().getAttribute("authUser");
        if ((boolean) request.getSession().getAttribute("auth") == true) {
            if (user.getRole() == 1) {
                int checkTime = user.getIssue_at().plusMinutes(user.getExpiration()).compareTo(LocalDateTime.now());
                if (checkTime < 0) {
                    ServletUtils.forward("/views/403.jsp", request, response);
                    return;
                }
            }
        } else {
            ServletUtils.forward("/views/403.jsp", request, response);
            return;
        }

        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=" + id + ".pdf");

        File filePDF = new File(request.getServletContext().getRealPath("/pdfs/articles/" + id + ".pdf"));

        OutputStream out = response.getOutputStream();
        FileInputStream in = new FileInputStream(filePDF);
        byte[] buffer = new byte[4096];
        int length;
        while ((length = in.read(buffer)) > 0) {
            out.write(buffer, 0, length);
        }
        in.close();
        out.flush();
    }

    private void getArticlesAndForward(int service, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Users user = (Users) request.getSession().getAttribute("authUser");
        List<Articles> arts = new ArrayList<>();
        String title = "";
        List<Categories> cate = new ArrayList<>();
        switch (service) {
            case 1:
                ParentCategories pcate = CategoriesService.findPCatById(id);
                if (pcate != null) {
                    title = pcate.getName_parent_cate();
                    cate = CategoriesService.findAllByParentId(id);
                    arts = ArticlesService.findByPCatId(id);
                } else
                    ServletUtils.forward("/views/204.jsp", request, response);

                break;
            case 2:
                Categories newCate = CategoriesService.findById(id);
                title = newCate.getName_category();
                cate = CategoriesService.findAllByParentId(newCate.getParent_cate_id());
                arts = ArticlesService.findByCatId(id);
                break;
            case 3:
                title = TagsService.findById(id).getName_tags();
                arts = ArticlesService.findByTagId(id);
                break;
        }

        if ((boolean) request.getSession().getAttribute("auth")) {
            if (user.getRole() == 1)
                java.util.Collections.sort(arts, new Articles());
        }
        String url = request.getPathInfo() + "?id=" + Integer.toString(id);
        request.setAttribute("url", url);
        request.setAttribute("titleTopic", title);
        request.setAttribute("cateRelated", cate);
        request.setAttribute("articles", arts);

//      Page gửi về
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
        }

//        Chỗ cần thêm dữ liệu đây
        request.setAttribute("currentPage", 1);
        request.setAttribute("maxPage", 10);

        ServletUtils.forward("/views/vwGeneral/Topic.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        switch (url) {
            case "/Details/Comment/Add":
                addComment(request, response);
                break;
            case "/Details/Comment/Edit":
                editComment(request, response);
                break;
            case "/Details/Comment/Delete":
                deleteComment(request, response);
                break;
            default:
                ServletUtils.forward("/views/204.jsp", request, response);
                break;
        }
    }

    private static void editComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int commentId = 0;
        try {
            commentId = Integer.parseInt(request.getParameter("commentId"));
        } catch (NumberFormatException e) {
        }
        Comments comment = CommentService.findById(commentId);
        if (comment != null) {
            String content = request.getParameter("comment");
            CommentService.updateComment(commentId, content);

            ServletUtils.redirect(request.getServletPath(), request, response);

        } else {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }
    }

    private static void deleteComment(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int commentId = 0;
        try {
            commentId = Integer.parseInt(request.getParameter("commentId"));
        } catch (NumberFormatException e) {
        }
        Comments comment = CommentService.findById(commentId);
        if (comment != null) {

            CommentService.delete(commentId);
            ServletUtils.redirect(request.getServletPath(), request, response);

        } else {
            ServletUtils.redirect("/views/204.jsp", request, response);
        }
    }

    private static void addComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int artId = 0;
        try {
            artId = Integer.parseInt(request.getParameter("artId"));
        } catch (NumberFormatException e) {

        }

        Articles art = ArticlesService.findById(artId);
        if (art != null) {
            String comment = request.getParameter("commentAdd");
            Users user = (Users) request.getSession().getAttribute("authUser");
            CommentService.add(user.getId(), artId, comment);

            ServletUtils.redirect(request.getServletPath(), request, response);
        }
    }
}
