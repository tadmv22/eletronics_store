package com.electronicsstore.dto;

public class ProductResponse {

    private int id;
    private String name;
    private String description;
    private double value;
    private int stockQuantity;
    private String categoryName;
    
    public ProductResponse(int id, String name, String description,double value, int stockQuantity, String categoryName) {
        this.id = id;
        this.name = name;
        this.value = value;
        this.description = description;
        this.stockQuantity = stockQuantity;
        this.categoryName = categoryName;
    }
    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public double getValue() {
        return value;
    }
    public String getDescription() {
        return description;
    }
    public int getStockQuantity() {
        return stockQuantity;
    }
    public String getCategoryName() {
        return categoryName;
    }
}
