package com.messi.king.messinews.models;

public class EditorManageCategories {
    private int id;
    private int editor_id;
    private int category_id;

    public EditorManageCategories(int id, int editor_id, int category_id) {
        this.id = id;
        this.editor_id = editor_id;
        this.category_id = category_id;
    }

    public EditorManageCategories() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEditor_id() {
        return editor_id;
    }

    public void setEditor_id(int editor_id) {
        this.editor_id = editor_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }
}
