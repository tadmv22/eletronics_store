package com.electronicsstore.dto;

public class CurrentUser {

    public CurrentUser() {
    }

    public CurrentUser(String email, String name, String address, String zipcode) {
        this.email = email;
        this.name = name;
        this.address = address;
        this.zipcode = zipcode;
    }

    private String email;
    private String name;
    private String address;
    private String zipcode;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
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
}
