package com.electronicsstore.dto;

public class CurrentUser {

    private String email;
    private String name;
    private int id;

    public CurrentUser() {
    }

    public CurrentUser(String email, String name,int id) {
        this.email = email;
        this.name = name;
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
     public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
