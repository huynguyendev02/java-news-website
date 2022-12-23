package com.messi.king.messinews.models;

public class ParentCategories {
    private int id;
    private String name_parent_cate;

    public ParentCategories(int id, String name_parent_cate) {
        this.id = id;
        this.name_parent_cate = name_parent_cate;
    }

    public ParentCategories() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName_parent_cate() {
        return name_parent_cate;
    }

    public void setName_parent_cate(String name_parent_cate) {
        this.name_parent_cate = name_parent_cate;
    }
}
