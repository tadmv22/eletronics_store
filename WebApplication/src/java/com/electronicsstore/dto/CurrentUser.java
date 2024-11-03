package com.electronicsstore.dto;

public class CurrentUser {
 
    public CurrentUser() {}

    public CurrentUser(String email, String name) {
        this.email = email;
        this.name = name;
    }

    private String email;
    private String name;

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
}
