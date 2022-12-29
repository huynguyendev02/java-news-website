package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.ParentCategories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.List;

public class EditorService {
    public static List<Articles> findByEditor(int editor_id) {
        final String query = "SELECT * from articles JOIN (SELECT category_id from editor_manage_categories WHERE editor_id =:editor_id) as hehe on hehe.category_id = categories_id AND status=-1";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("editor_id",editor_id)
                    .executeAndFetch(Articles.class);
        }
    }
    public static List<Articles> findAll() {
        final String query = "SELECT * from articles";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Articles.class);
        }
    }
    public static void acceptArticle(int id, LocalDateTime publish_time,int premium, List<Integer> tagIds) {
        final String query = "update articles set publish_time = :publish_time, status=1, premium= :premium where id = :id";
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
