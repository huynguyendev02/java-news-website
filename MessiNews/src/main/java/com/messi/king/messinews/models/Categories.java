package com.messi.king.messinews.models;

import com.messi.king.messinews.services.CategoriesService;
import com.messi.king.messinews.services.UsersService;

public class Categories {
    private int id;
    private String name_category;
    private int parent_cate_id;

    public Categories(int id, String name_category, int parent_cate_id) {
        this.id = id;
        this.name_category = name_category;
        this.parent_cate_id = parent_cate_id;
    }

    public Categories() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName_category() {
        return name_category;
    }

    public void setName_category(String name_category) {
        this.name_category = name_category;
    }

    public int getParent_cate_id() {
        return parent_cate_id;
    }

    public void setParent_cate_id(int parent_cate_id) {
        this.parent_cate_id = parent_cate_id;
    }
    public String getCategoriesName(int id) {return CategoriesService.findById(id).getName_category();}
}
