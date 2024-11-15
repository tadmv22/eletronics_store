package com.electronicsstore.dto;

import java.util.Date;

public class UserResponse {

    private int id;
    private String name;
    private String surname;
    private String email;
    private boolean isActive;
    private Date createdAt;
    private Date updateAt;
    
    public UserResponse(int id, String name, String surname, String email, boolean isActive, Date createdAt, Date updateAt) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
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

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
