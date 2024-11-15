package com.electronicsstore.dto;

public class ProductsAnalytics {
    private int units;
    private double balance;
    private double averange;

    public ProductsAnalytics(int units, double balance, double averange) {
        this.units = units;
        this.balance = balance;
        this.averange = averange;
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
