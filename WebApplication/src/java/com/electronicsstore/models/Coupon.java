package com.electronicsstore.models;

import java.util.Date;

public class Coupon {

    private int id;
    private String code;
    private String description;
    private double discountValue;
    private Date startAt;
    private Date expirationAt;
    private boolean active;
    private Date createdAt;
    private Date updateAt;

    public Coupon(int id, String code, String description, double discountValue, Date startAt, Date expirationAt, boolean active, Date createdAt, Date updateAt) {
        this.id = id;
        this.code = code;
        this.description = description;
        this.discountValue = discountValue;
        this.startAt = startAt;
        this.expirationAt = expirationAt;
        this.active = active;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
    }

    public Coupon(String code, String description, double discountValue, Date startAt, Date expirationAt) {
        this.code = code;
        this.description = description;
        this.discountValue = discountValue;
        this.startAt = startAt;
        this.expirationAt = expirationAt;
    }

    public boolean isExpired() {        
        if(this.expirationAt == null) return false;
        return this.expirationAt.before(new Date());
    }

    public boolean IsActiveAndValid() {
        return this.active && !this.isExpired() && this.startAt.before(new Date());
    }
    
    public int getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public Date getStartAt() {
        return startAt;
    }

    public void setStartAt(Date startAt) {
        this.startAt = startAt;
    }

    public Date getExpirationAt() {
        return expirationAt;
    }

    public void setExpirationAt(Date expirationAt) {
        this.expirationAt = expirationAt;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
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

    public void changeStatus() {
        if (this.getActive()) {
            this.setActive(false);
        } else {
            this.setActive(true);
        }
    }

}
