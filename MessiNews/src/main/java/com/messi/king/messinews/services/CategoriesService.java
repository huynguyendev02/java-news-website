package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.models.ParentCategories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.List;

public class CategoriesService {
    public static List<Categories> findAll() {
        final String query = "select * from categories";
        try (Connection con = DbUtils.getConnection()) {
            List<Categories> cate = con.createQuery(query)
                    .executeAndFetch(Categories.class);
            return cate;
        }
    }
    public static void addCate(String nameCate, int pcateId) {
        String insertSql = "INSERT INTO categories (nameCate, parent_cate_id) VALUES (:nameCate, :parent_cate_id)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("nameCate", nameCate)
                    .addParameter("pcateId", pcateId)
                    .executeUpdate();
        }
    }
    public static void addPCate(String namePCate) {
        String insertSql = "INSERT INTO categories (namePCate) VALUES (:namePCate)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("namePCate", namePCate)
                    .executeUpdate();
        }
    }
    public static List<Categories> findAllByParentId(int pcatId) {
        final String query = "select * from categories where parent_cate_id= :pcatId";
        try (Connection con = DbUtils.getConnection()) {
            List<Categories> cate = con.createQuery(query)
                    .addParameter("pcatId", pcatId)
                    .executeAndFetch(Categories.class);
            return cate;
        }
    }
    public static List<ParentCategories> findAllParent() {
        final String query = "select * from parent_categories";
        try (Connection con = DbUtils.getConnection()) {
            List<ParentCategories> pcate = con.createQuery(query)
                    .executeAndFetch(ParentCategories.class);
            return pcate;
        }
    }
    public static Categories findById(int id) {
        final String query = "select * from categories where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Categories cate = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Categories.class);
            return cate;
        }
    }
    public static void updatePCate(int pcateId, String name_parent_cate) {
        final String query = "update parent_categories set name_parent_cate= :name_parent_cate where id = :pcateId";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", pcateId)
                    .addParameter("name_parent_cate", name_parent_cate)
                    .executeUpdate();
        }
    }
    public static ParentCategories findPCatById(int id) {
        final String query = "select * from parent_categories where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            ParentCategories cate = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(ParentCategories.class);
            return cate;
        }
    }

    public static void updateCate(int idCate, String nameCate, int idPCate) {
        final String query = "update categories set name_category= :nameCate, parent_cate_id= :idPCate where id = :idCate";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", idCate)
                    .addParameter("nameCate", nameCate)
                    .addParameter("idPCate", idPCate)
                    .executeUpdate();
        }
    }
    public static void deleteCate(int idCate) {
        final String query = "delete from categories where id = :idCate";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", idCate)
                    .executeUpdate();
        }
    }

    public static void deletePCate(int idPCate) {
        final String query = "delete from parent_categories where id = :idPCate";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", idPCate)
                    .executeUpdate();
        }
    }

    public static List<Categories> findAllByEditorId(int id) {
        final String query = "SELECT categories.id, name_category, parent_cate_id from editor_manage_categories JOIN categories ON editor_manage_categories.category_id = categories.id WHERE editor_id = :editor_id";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("editor_id", id)
                    .executeAndFetch(Categories.class);
        }
    }
}
