package com.messi.king.messinews.models;

public class ArticleHasTag {
    private int id;
    private int tag_id;
    private int article_id;

    public ArticleHasTag(int id, int tag_id, int article_id) {
        this.id = id;
        this.tag_id = tag_id;
        this.article_id = article_id;
    }

    public ArticleHasTag() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTag_id() {
        return tag_id;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }
}
