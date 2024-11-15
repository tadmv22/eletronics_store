package com.electronicsstore.dto;

import java.util.Date;

public class CategoryResponse {
    private int id;
    private String name;
    private String description;
    private int totalProducts;
    private boolean isActive;
    private Date createdAt;
    private Date updateAt;

    public CategoryResponse(int id, String name, String description, int totalProducts, boolean isActive, Date createdAt, Date updateAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.totalProducts = totalProducts;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getTotalProducts() {
        return totalProducts;
    }

    public void setTotalProducts(int totalProducts) {
        this.totalProducts = totalProducts;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }
}
