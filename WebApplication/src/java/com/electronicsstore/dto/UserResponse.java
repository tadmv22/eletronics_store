package com.electronicsstore.dto;

import java.util.Date;

public class UserResponse {


    private int id;
    private String name;
    private String surname;
    private String email;
    private boolean isActive;
    private Date createdAt;
    public UserResponse(int id, String name, String surname, String email, boolean isActive, Date createdAt) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public String getEmail() {
        return email;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

}
