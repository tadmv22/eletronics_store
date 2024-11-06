package com.electronicsstore.models;

import java.util.Date;

public class User {

    private int id;
    private String name;
    private String surname;
    private String email;
    private String password;
    private String address;
    private String zipcode;
    private boolean isActive;
    private Date createdAt;

    public User(int id, String name,String surname, String email, String password, String address,String zipcode, boolean isActive, Date createdAt) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.address = address;
        this.zipcode = zipcode;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public User(String name,String surname,  String email, String password, String address,String zipcode) {
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.address = address;
        this.zipcode = zipcode;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

}
