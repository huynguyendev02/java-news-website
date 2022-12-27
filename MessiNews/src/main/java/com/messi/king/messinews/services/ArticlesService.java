package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
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
    public static List<Articles> newsRelated(int artId) {
        Articles art = ArticlesService.findById(artId);
        List<Articles> arts = ArticlesService.findByCatId(art.getCategories_id());
        int pcatId = CategoriesService.findById(art.getCategories_id()).getParent_cate_id();
        if (arts.size() < 5) {
            arts.addAll(ArticlesService.findByPCatId(pcatId));
        }
        return arts;
    }
    public static List<Articles> newest10PerCate() {
        final String query = "SELECT * FROM  ( (select * from articles where publish_date = ( select Max(publish_date) from articles as f where f.categories_id=articles.categories_id ) group by categories_id, publish_date ) as bangmot JOIN (SELECT categories_id from articles GROUP BY categories_id ORDER BY SUM(views) DESC LIMIT 10 ) as banghai ON bangmot.categories_id = banghai.categories_id )";
//        final String top10cateId = "SELECT categories_id from articles GROUP BY categories_id ORDER BY SUM(views) DESC";
//        final String topNewestPerCate = "SELECT * from articles WHERE categories_id=:cate_id ORDER BY publish_date desc limit 1";
        try (Connection con = DbUtils.getConnection()) {
//            List<Integer> cateIds = con.createQuery(top10cateId)
//                    .executeAndFetch(Integer.class);
//            List<Articles> articlesList = new ArrayList<>();
//            for (int cateId: cateIds) {
//                articlesList.add(con.createQuery(topNewestPerCate)
//                        .addParameter("cate_id", cateId)
//                        .executeAndFetchFirst(Articles.class));
//                if (articlesList.size()<10) continue;
//                return articlesList;
//            }
            return con.createQuery(query)
                    .executeAndFetch(Articles.class);
//            return articlesList;
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
    public static void viewArticle(int id) {
        final String query = "update articles set views= views+1 where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .executeUpdate();
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
                    .addParameter("id", id)
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
