package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.EditorManageCategories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class EditorService {
    public static List<Articles> findByEditor(int editor_id) {
        final String listCate = "SELECT * from editor_manage_categories WHERE editor_id = :editor_id";
        final String getArticle = "SELECT * from articles WHERE  categories_id= :category_id AND status=-1";
        List<Articles> arts  = new ArrayList<>();
        try (Connection con = DbUtils.getConnection()) {
            List<EditorManageCategories> editManager =  con.createQuery(listCate)
                    .addParameter("editor_id",editor_id)
                    .executeAndFetch(EditorManageCategories.class);
            for(EditorManageCategories cate: editManager) {
                arts.addAll(con.createQuery(getArticle)
                        .addParameter("category_id", cate.getCategory_id())
                        .executeAndFetch(Articles.class));
            }
            return arts;
        }
    }
    public static List<Articles> findAll() {
        final String query = "SELECT * from articles";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Articles.class);
        }
    }
    public static List<Articles> findAllDraft() {
        final String query = "SELECT * from articles where status=-1";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Articles.class);
        }
    }
    public static List<Articles> findAllComplete() {
        final String query = "SELECT * from articles where status!=-1";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Articles.class);
        }
    }
    public static void acceptArticle(int id, LocalDateTime publish_time, int premium, int idCat, int[] tagIds, int editorId) {
        final String query = "update articles set publish_date = :publish_time,categories_id= :categories_id , status=1, premium= :premium, editor_id= :editor_id where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("premium", premium)
                    .addParameter("categories_id", idCat)
                    .addParameter("publish_time", publish_time)
                    .addParameter("editor_id",editorId)
                    .executeUpdate();
        }
        TagsService.editTagsByArticle(id, tagIds);
    }
    public static void declineArticle(int id,String reason, int editorId) {
        final String query = "update articles set reason = :reason, status=0, editor_id= :editor_id where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("reason", reason)
                    .addParameter("editor_id", editorId)
                    .executeUpdate();
        }
    }
}
