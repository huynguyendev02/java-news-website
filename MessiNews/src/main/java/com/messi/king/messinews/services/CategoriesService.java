package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Categories;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

public class CategoriesService {
    public static Categories findById(int id) {
        final String query = "select * from categories where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Categories cate = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Categories.class);
            return cate;
        }
    }
}
