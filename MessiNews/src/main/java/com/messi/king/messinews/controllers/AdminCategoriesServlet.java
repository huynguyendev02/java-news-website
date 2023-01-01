package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.models.ParentCategories;
import com.messi.king.messinews.services.CategoriesService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AdminCategoriesServlet", value = "/Admin/Categories/*")
public class AdminCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String url = request.getPathInfo();
        switch (url) {
            case "/ListCate":
                ServletUtils.forward("/views/vwAdmin/CateAdminList.jsp",request,response);
                break;
            case "/AddCate":
                ServletUtils.forward("/views/vwAdmin/CateAdminAdd.jsp",request,response);
                break;
            case "/AddPCate":
                ServletUtils.forward("/views/vwAdmin/PCateAdminAdd.jsp",request,response);
                break;
            case "/ListPCate":
                ServletUtils.forward("/views/vwAdmin/PCateAdminList.jsp",request,response);
                break;
            case "/EditPCate":
                int idPCate = 0;
                try {
                    idPCate = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                ParentCategories pcate = CategoriesService.findPCatById(idPCate);
                if (pcate!=null) {
                    request.setAttribute("pcate", pcate);
                    ServletUtils.forward("/views/vwAdmin/PCateAdminEdit.jsp",request,response);
                } else {
                    ServletUtils.forward("/views/204.jsp",request,response);
                }
                break;
            case "/EditCate":
                int idCate = 0;
                try {
                    idCate = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Categories cate = CategoriesService.findById(idCate);
                if (cate!=null) {
                    request.setAttribute("cate", cate);
                    ServletUtils.forward("/views/vwAdmin/CateAdminEdit.jsp",request,response);

                } else {
                    ServletUtils.forward("/views/204.jsp",request,response);
                }
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        switch (url) {
            case "/AddCate":
                addCategory(request,response);
                break;
            case "/AddPCate":
                addPCategory(request,response);
                break;
            case "/EditPCate":
                editPCate(request,response);
                break;
            case "/EditCate":
                editCate(request,response);
                break;
            case "/DeleteCate":
                deleteCate(request,response);
                break;
            case "/DeletePCate":
                deletePCate(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    private void deletePCate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idPCate = Integer.parseInt(request.getParameter("idPCate"));
        CategoriesService.deletePCate(idPCate);
        ServletUtils.redirect("/Admin/Categories/ListPCate", request, response);
    }

    private void deleteCate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idCate = Integer.parseInt(request.getParameter("idCate"));
        CategoriesService.deleteCate(idCate);
        ServletUtils.redirect("/Admin/Categories/ListCate", request, response);
    }

    private void editCate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idCate = 0, idPCate = 0;
        try {
            idCate = Integer.parseInt(request.getParameter("idCate"));
            idPCate = Integer.parseInt(request.getParameter("idPCate"));

        } catch (NumberFormatException e) {
        }
        String nameCate = request.getParameter("nameCate");

        CategoriesService.updateCate(idCate, nameCate, idPCate);
        ServletUtils.redirect("/Admin/Categories/ListCate", request, response);
    }

    private void editPCate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idPCate = 0;
        try {
            idPCate = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        String namePCate = request.getParameter("namePCate");
        CategoriesService.updatePCate(idPCate, namePCate);
        ServletUtils.redirect("/Admin/Categories/ListPCate", request, response);
    }

    private void addPCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String namePCate = request.getParameter("namePCate");
        CategoriesService.addPCate(namePCate);
        ServletUtils.redirect("/Admin/Categories/ListPCate", request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nameCate = request.getParameter("nameCate");
        int pcateId =  Integer.parseInt(request.getParameter("pcateId"));
        CategoriesService.addCate(nameCate, pcateId);
        ServletUtils.redirect("/Admin/Categories/ListCate", request, response);
    }
}
