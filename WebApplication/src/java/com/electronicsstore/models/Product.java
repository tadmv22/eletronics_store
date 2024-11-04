package com.electronicsstore.models;

public class Product {

    private int id;
    private String name;
    private double value;
    private String description;
    private int stock_quantity;

    public Product(String name, double value, String description, int stock_quantity) {
        this.name = name;
        this.value = value;
        this.description = description;
        this.stock_quantity = stock_quantity;
    }

    public Product(int id, String name, double value, String description, int stock_quantity) {
        this.id = id;
        this.name = name;
        this.value = value;
        this.description = description;
        this.stock_quantity = stock_quantity;
    }

    public int getId() {
        return id;
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

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }
    
}


   