package com.electronicsstore.dto;

public class CurrentUser {

    private String email;
    private String name;
    private String surname;

    private int id;

    public CurrentUser() {
    }

    public CurrentUser(int id,String email, String name,String surname) {
        this.email = email;
        this.name = name;
        this.surname = surname;
        this.id = id;
    }
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
    
    public String getSurname() {
        return surname;
    }

}
