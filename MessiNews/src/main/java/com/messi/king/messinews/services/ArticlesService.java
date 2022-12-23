package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.util.ArrayList;
import java.util.List;

public class ArticlesService {
    public static Articles findById(int id) {
        final String query = "select * from articles where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Articles art = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Articles.class);
            return art;
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
        final String query = "select * from articles where categories_id = :id";
        try (Connection con = DbUtils.getConnection()) {
            List<Articles> arts = con.createQuery(query)
                    .addParameter("categories_id", id)
                    .executeAndFetch(Articles.class);
            return arts;
        }
    }
}
