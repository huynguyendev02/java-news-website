package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.util.ArrayList;
import java.util.List;

public class ArticlesService {
    public static List<Articles> top10AllCate() {
        final String query = "select * from articles ORDER BY views DESC LIMIT 10";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static List<Articles> top5AllCateInWeek() {
        final String query = "select * from articles WHERE DATEDIFF(NOW(),publish_date)<=7 ORDER BY views DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static List<Articles> newest10PerCate() {
        final String query = "SELECT  id, title, publish_date, views, abstract_content, content, categories_id, premium, writer_id, status FROM (SELECT id, title, MAX(publish_date) as publish_date, views, abstract_content, content, categories_id, premium, writer_id, status from articles GROUP BY categories_id) as bangone JOIN (select categories_id as idCate ,SUM(views) as tongView from articles GROUP BY categories_id LIMIT 10) AS sumnhe ON bangone.categories_id=sumnhe.idCate ORDER BY views DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static List<Articles> latestNewsAllCate() {
        final String query = "select * from articles ORDER BY publish_date DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static Articles findById(int id) {
        final String query = "select * from articles where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Articles art = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Articles.class);
            return art;
        }
    }
    public static List<Articles> findByWriterId(int writerId) {
        final String query = "select * from articles where writer_id = :writerId";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .addParameter("writer_id", writerId)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static List<Articles> findByTagId(int tag_id) {
        final String tagQuery = "select article_id from article_has_tag where tag_id= :tag_id";
        final String artsQuery = "select * from article where id= :id";
        try (Connection con = DbUtils.getConnection()) {
            List<Integer> artsId = con.createQuery(tagQuery)
                    .addParameter("tag_id", tag_id)
                    .executeAndFetch(Integer.class);
            List<Articles> arts = new ArrayList<>();;
            for (int id: artsId) {
                Articles art = con.createQuery(artsQuery).addParameter("id",id).executeAndFetchFirst(Articles.class);
                arts.add(art);
            }
            return arts;
        }
    }
    public static List<Articles> findByPCatId(int parent_cate_id) {
        final String cateQuery = "select id from categories where parent_cate_id= :parent_cate_id";
        try (Connection con = DbUtils.getConnection()) {
            List<Integer> cateId = con.createQuery(cateQuery)
                    .addParameter("parent_cate_id", parent_cate_id)
                    .executeAndFetch(Integer.class);
            List<Articles> arts = new ArrayList<>();;
            for (int id: cateId) {
                List<Articles> artsByCat = findByCatId(id);
                arts.addAll(artsByCat);
            }
            return arts;
        }
    }
    public static List<Articles> findByCatId(int id) {
        final String query = "select * from articles where categories_id = :id ORDER BY publish_date DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .addParameter("categories_id", id)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
    public static int add(Articles articles) {
        String insertSql = "INSERT INTO articles (title, views, abstract_content, content, categories_id,premium, writer_id, status) VALUES (:title, :views, :abstract_content, :content, :categories_id,:premium, :writer_id, :status)";
        try (Connection con = DbUtils.getConnection()) {
            return (int)con.createQuery(insertSql, true)
                    .addParameter("title",articles.getTitle())
                    .addParameter("views",0)
                    .addParameter("abstract_content", articles.getAbstract_content())
                    .addParameter("content",articles.getContent())
                    .addParameter("categories_id",articles.getCategories_id())
                    .addParameter("premium", articles.getPremium())
                    .addParameter("writer_id", articles.getWriter_id())
                    .addParameter("status",-1)
                    .executeUpdate()
                    .getKey();
        }
    }
}
