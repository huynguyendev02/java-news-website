package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

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
}
