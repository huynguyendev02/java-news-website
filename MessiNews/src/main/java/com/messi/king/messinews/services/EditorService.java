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
    public static void acceptArticle(int id, LocalDateTime publish_time, int premium, int[] tagIds) {
        final String query = "update articles set publish_date = :publish_time, status=1, premium= :premium where id = :id";
        final String insertTag = "INSERT INTO article_has_tag (tag_id, article_id) VALUES (:tag_id, :article_id)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("premium", premium)
                    .addParameter("publish_time", publish_time)
                    .executeUpdate();
            for (int tagId: tagIds) {
                con.createQuery(insertTag)
                        .addParameter("article_id", id)
                        .addParameter("tag_id", tagId)
                        .executeUpdate();
            }
        }

    }
    public static void declineArticle(int id,String reason) {
        final String query = "update articles set reason = :reason, status=0 where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("reason", reason)
                    .executeUpdate();
        }
    }
}
