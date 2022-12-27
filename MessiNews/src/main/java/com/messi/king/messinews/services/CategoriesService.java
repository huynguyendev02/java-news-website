package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.models.ParentCategories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

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
    public static ParentCategories findPCatById(int id) {
        final String query = "select * from parent_categories where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            ParentCategories cate = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(ParentCategories.class);
            return cate;
        }
    }

}
