package com.electronicsstore.dto;

public class CaterogryAnalytic {
    private int id;
    private String name;
    private int products;
    private int units;
    private double balance;
    private double averange;

    public CaterogryAnalytic(int id, String name, int products, int units, double balance, double averange) {
        this.id = id;
        this.name = name;
        this.products = products;
        this.units = units;
        this.balance = balance;
        this.averange = averange;
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

    public int getProducts() {
        return products;
    }

    public void setProducts(int products) {
        this.products = products;
    }

    public int getUnits() {
        return units;
    }

    public void setUnits(int units) {
        this.units = units;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getAverange() {
        return averange;
    }

    public void setAverange(double averange) {
        this.averange = averange;
    }
}
