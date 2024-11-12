package com.electronicsstore.models;

public class Category {
    private String name;
    private int id;
    
    public Category(String name) {
        this.name = name;
    }
    
    public Category( int id, String name) {
        this.name = name;
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}


