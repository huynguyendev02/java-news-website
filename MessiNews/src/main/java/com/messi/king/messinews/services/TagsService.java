package com.messi.king.messinews.services;

import com.messi.king.messinews.models.ArticleHasTag;
import com.messi.king.messinews.models.ParentCategories;
import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TagsService {
    public static Tags findById(int id) {
        final String query = "select * from tags where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Tags cate = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Tags.class);
            return cate;
        }
    }
    public static List<Tags> findAll() {
        final String query = "select * from tags";
        try (Connection con = DbUtils.getConnection()) {
            List<Tags> tags = con.createQuery(query)
                    .executeAndFetch(Tags.class);
            return tags;
        }
    }
    public static List<Tags> findTagByArticle(int artId) {
        final String query = "select * from article_has_tag where article_id= :artId";
        try (Connection con = DbUtils.getConnection()) {
            List<Tags> tags = new ArrayList<>();
            List<ArticleHasTag> artTags = con.createQuery(query)
                    .addParameter("artId", artId)
                    .executeAndFetch(ArticleHasTag.class);
            for(ArticleHasTag artTag: artTags) {
                tags.add(TagsService.findById(artTag.getTag_id()));
            }
            return tags;
        }
    }

    public static void add(String nameTag) {
        String insertSql = "INSERT INTO tags (name_tags) VALUES (:name_tags)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("name_tags", nameTag)
                    .executeUpdate();
        }
    }

    public static void addTagsByArticle(int artId, int[] tagsId) {
        String insertSql = "INSERT INTO article_has_tag (tag_id, article_id) VALUES (:tag_id, :article_id)";
        try (Connection con = DbUtils.getConnection()) {
            for(int tagId: tagsId) {
                con.createQuery(insertSql)
                        .addParameter("tag_id", tagId)
                        .addParameter("article_id", artId)
                        .executeUpdate();
            }

        }
    }

    public static void editTagsByArticle(int artId, int[] tagsId) {
        String deleteSql = "delete from article_has_tag where article_id = :article_id";
        String insertSql = "INSERT INTO article_has_tag (tag_id, article_id) VALUES (:tag_id, :article_id)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(deleteSql)
                    .addParameter("article_id", artId)
                    .executeUpdate();
            for(int tagId: tagsId) {
                con.createQuery(insertSql)
                        .addParameter("tag_id", tagId)
                        .addParameter("article_id", artId)
                        .executeUpdate();
            }

        }
    }

    public static void delete(Tags tag) {
        final String query = "delete from tags where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", tag.getId())
                    .executeUpdate();
        }
    }


    public static void edit(String nameTag, Tags tag) {
        final String query = "update tags set name_tags = :name_tags where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", tag.getId())
                    .addParameter("name_tags", nameTag)
                    .executeUpdate();
        }
    }
}
