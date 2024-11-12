package com.electronicsstore.models;

public class Product {

    private int id;
    private String name;
    private double value;
    private String description;
    private int stockQuantity;
    private int categoryId;
    
    public Product(String name, double value, String description, int stockQuantity, int categoryId) {
        this.name = name;
        this.value = value;
        this.description = description;
        this.stockQuantity = stockQuantity;
        this.categoryId = categoryId;
    }
    public Product(int id, String name, double value, String description, int stockQuantity, int categoryId) {
        this.id = id;
        this.name = name;
        this.value = value;
        this.description = description;
        this.stockQuantity = stockQuantity;
        this.categoryId = categoryId;
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

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }


}


   