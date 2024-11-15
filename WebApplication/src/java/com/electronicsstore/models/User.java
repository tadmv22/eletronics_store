package com.electronicsstore.models;

import java.util.Date;

public class User {

    private int id;
    private String name;
    private String surname;
    private String email;
    private String password;
    private boolean isActive;
    private Date createdAt;
    private Date updateAt;

    public User(String name, String surname, String email, String password) {
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
    }

    public User(int id, String name, String surname, String email, String password, boolean isActive, Date createdAt, Date updateAt) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public void changeStatus() {
        if (this.getIsActive()) {
            this.setIsActive(false);
        } else {
            this.setIsActive(true);
        }
    }
   public void changeStatus(int status) {
        if (status == 1) {
            this.setIsActive(true);
        } else {
            this.setIsActive(false);
        }
    }
}
