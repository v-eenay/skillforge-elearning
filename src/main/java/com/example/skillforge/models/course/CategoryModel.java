package com.example.skillforge.models.course;

import java.io.Serializable;

/**
 * Model class for Course Categories
 */
public class CategoryModel implements Serializable {
    private int categoryId;
    private String name;
    private String description;

    public CategoryModel() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
