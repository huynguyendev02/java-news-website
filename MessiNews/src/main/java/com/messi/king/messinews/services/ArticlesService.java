package com.messi.king.messinews.services;

import com.messi.king.messinews.models.ArticleHasTag;
import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.stream.Collectors;

public class ArticlesService {
    public static List<Articles> top10AllCate() {
        final String query = "select * from articles WHERE status=1 ORDER BY views DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }

    public static List<Articles> top5AllCateInWeek() {
        final String query = "select * from articles WHERE DATEDIFF(NOW(),publish_date)<=7 and status=1 ORDER BY views DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }

    public static List<Articles> searchArticles(String key) {
        final String query = "SELECT * from articles WHERE MATCH(title) AGAINST (:key) and status=1 UNION SELECT * from articles WHERE MATCH(abstract_content) AGAINST (:key) and status=1 UNION SELECT * from articles WHERE MATCH(content) AGAINST (:key) and status=1";
        List<Articles> arts = new ArrayList<>();
        try (Connection con = DbUtils.getConnection()) {
            arts.addAll(con.createQuery(query)
                    .addParameter("key", key)
                    .executeAndFetch(Articles.class));
            return arts;
        }
    }

    public static List<Articles> searchArticlesByTitle(String key) {
        final String query = "SELECT * from articles WHERE MATCH(title) AGAINST (:key) and status=1";
        List<Articles> arts = new ArrayList<>();
        try (Connection con = DbUtils.getConnection()) {
            arts.addAll(con.createQuery(query)
                    .addParameter("key", key)
                    .executeAndFetch(Articles.class));
            return arts;
        }
    }

    public static List<Articles> searchArticlesByAbs(String key) {
        final String query = "SELECT * from articles WHERE MATCH(abstract_content) AGAINST (:key) and status=1";
        List<Articles> arts = new ArrayList<>();
        try (Connection con = DbUtils.getConnection()) {
            arts.addAll(con.createQuery(query)
                    .addParameter("key", key)
                    .executeAndFetch(Articles.class));
            return arts;
        }
    }

    public static List<Articles> searchAriclesByContent(String key) {
        final String query = "SELECT * from articles WHERE MATCH(content) AGAINST (:key) and status=1";
        List<Articles> arts = new ArrayList<>();
        try (Connection con = DbUtils.getConnection()) {
            arts.addAll(con.createQuery(query)
                    .addParameter("key", key)
                    .executeAndFetch(Articles.class));
            return arts;
        }
    }

    public static List<Articles> newsRelated(int artId) {
        Articles art = ArticlesService.findById(artId);
        List<Articles> arts = ArticlesService.findByCatId(art.getCategories_id());
        int pcatId = CategoriesService.findById(art.getCategories_id()).getParent_cate_id();


        if (arts.size() < 5) {
            List<Articles> artsByPCat = ArticlesService.findByPCatId(pcatId);
            for (Articles artP : artsByPCat) {
                int check = 1;
                for (Articles artC : arts)
                    if (artC.getId() == artP.getId()) {
                        check = 0;
                        break;
                    }
                if (check == 1)
                    arts.add(artP);
            }
        }
        return arts;
    }

    public static List<Articles> newest10PerCate() {
        final String query = "SELECT * FROM  ( (select * from articles where status=1 and publish_date = ( select Max(publish_date) from articles as f where f.categories_id=articles.categories_id ) group by categories_id, publish_date ) as bangmot JOIN (SELECT categories_id from articles GROUP BY categories_id ORDER BY SUM(views) DESC  ) as banghai ON bangmot.categories_id = banghai.categories_id )";
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

    public static void edit(int id, String title, String abstractContent, String content, int cateId) {
        final String query = "update articles set title= :title, abstract_content= :abstract_content, content= :content, categories_id= :categories_id  where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("title", title)
                    .addParameter("abstract_content", abstractContent)
                    .addParameter("content", content)
                    .addParameter("categories_id", cateId)
                    .executeUpdate();
        }
    }

    public static List<Articles> latestNewsAllCate() {
        final String query = "select * from articles where status=1 ORDER BY publish_date DESC";
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
                    .addParameter("writerId", writerId)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }

    public static List<Articles> findByTagId(int tag_id) {
        final String tagQuery = "select * from article_has_tag where tag_id= :tag_id";
        try (Connection con = DbUtils.getConnection()) {
            List<ArticleHasTag> artsId = con.createQuery(tagQuery)
                    .addParameter("tag_id", tag_id)
                    .executeAndFetch(ArticleHasTag.class);
            List<Articles> arts = new ArrayList<>();
            Articles art = new Articles();
            for (ArticleHasTag articleHasTag : artsId) {
                art = ArticlesService.findById(articleHasTag.getArticle_id());
                if (art.getStatus()==1){
                    arts.add(art);
                }
            }
            return arts;
        }
    }

    public static void viewArticle(int id) {
        final String query = "update articles set views= views+1 where id = :id and status=1";
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
            List<Articles> arts = new ArrayList<>();

            for (int id : cateId) {
                List<Articles> artsByCat = findByCatId(id);
                arts.addAll(artsByCat);
            }
            return arts;
        }
    }

    public static List<Articles> findByCatId(int id) {
        final String query = "select * from articles where categories_id = :id and status=1 ORDER BY publish_date DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }

    public static List<Articles> findByCatIdPublish(int userId) {
        List<Categories> catList = CategoriesService.findAllByEditorId(userId);
        List<Articles> arts = new ArrayList<>();
        final String query = "select * from articles where categories_id = :id and status=1 ORDER BY publish_date DESC";
        try (Connection con = DbUtils.getConnection()) {
            for (Categories cat : catList) {
                arts.addAll(con.createQuery(query).addParameter("id", cat.getId()).executeAndFetch(Articles.class));
            }
            return arts;
        }
    }

    public static void delete(Articles art) {
        final String query = "delete from articles where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", art.getId())
                    .executeUpdate();
        }
    }

    public static int add(Articles articles) {
        String insertSql = "INSERT INTO articles (title, views, abstract_content, content, categories_id,premium, writer_id, status) VALUES (:title, :views, :abstract_content, :content, :categories_id,:premium, :writer_id, :status)";
        try (Connection con = DbUtils.getConnection()) {
            BigInteger bigInt = (BigInteger) con.createQuery(insertSql, true)
                    .addParameter("title", articles.getTitle())
                    .addParameter("views", 0)
                    .addParameter("abstract_content", articles.getAbstract_content())
                    .addParameter("content", articles.getContent())
                    .addParameter("categories_id", articles.getCategories_id())
                    .addParameter("premium", articles.getPremium())
                    .addParameter("writer_id", articles.getWriter_id())
                    .addParameter("status", -1)
                    .executeUpdate()
                    .getKey();
            return bigInt.intValue();
        }
    }

    public static List<Articles> findByEditorId(int id) {
        final String query = "select * from articles where editor_id = :editor_id";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .addParameter("editor_id", id)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
}
