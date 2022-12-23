package com.messi.king.messinews.models;

public class Tags {
    private int id;
    private String name_tags;

    public Tags(int id, String name_tags) {
        this.id = id;
        this.name_tags = name_tags;
    }

    public Tags() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName_tags() {
        return name_tags;
    }

    public void setName_tags(String name_tags) {
        this.name_tags = name_tags;
    }
}
