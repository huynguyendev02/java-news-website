package com.messi.king.messinews.models;

import com.messi.king.messinews.services.UsersService;

import java.time.LocalDateTime;

public class Comments {
    private int id;
    private int user_id;
    private int article_id;
    private String comment;
    private LocalDateTime date;

    public Comments(int id, int user_id, int article_id, String comment, LocalDateTime date) {
        this.id = id;
        this.user_id = user_id;
        this.article_id = article_id;
        this.comment = comment;
        this.date = date;
    }
    public Comments() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getCommenterName(int id) {
        return UsersService.findById(id).getFull_name();
    }
}
