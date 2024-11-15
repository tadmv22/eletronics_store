package com.electronicsstore.services;

import com.electronicsstore.dao.CouponDao;
import com.electronicsstore.dto.PagedList;
import com.electronicsstore.models.Coupon;
import jakarta.servlet.ServletException;
import java.util.Date;
import java.util.List;


public class CouponService {
     private final CouponDao dao;
     
     public CouponService() throws ClassNotFoundException {
        this.dao = new CouponDao();
    }

    public Coupon createCoupon(String code,String description,double discount_value,Date start_at, Date expiration_at) throws ServletException, ClassNotFoundException {
        Coupon coupon = new Coupon(code, description,discount_value,start_at,expiration_at);
        return this.dao.create(coupon);
    }

    public void deleteCategory(int id) {
        this.dao.delete(id);
    }

    public Coupon updateCategory(Coupon coupon) {
        return this.dao.update(coupon);
    }

    public Coupon getCouponByCode(String name) throws ClassNotFoundException {
        return this.dao.getByCode(name);
    }

    public Coupon getById(int id) throws ClassNotFoundException {
        return this.dao.getById(id);
    }

    public PagedList<Coupon> getAllCouponWithFilter(String search, int page) throws ClassNotFoundException {
        int size = 5;
        int total;
                
        if (page < 1) {
            page = 1;
        }

        List<Coupon> coupons = this.dao.list(search, page, size);
        
        if(search == null) {
            total = this.dao.getTotal();
        } else {
            total = this.dao.getTotal(search);
        }
        

        return new PagedList<>(page, size, total, coupons);

    }

    public boolean checkCodeAlreadyInUse(String code, int id) throws ClassNotFoundException {
        Coupon coupon = this.dao.getByCode(code);

        if (coupon == null) {
            return false;
        }

        if (coupon.getId() == id) {
            return false;
        }

        return true;
    }

    public void changeStatus(int id) {
        Coupon coupon = this.dao.getById(id);

        if (coupon != null) {
            coupon.changeStatus();
            this.dao.update(coupon);
        }
    }
}
