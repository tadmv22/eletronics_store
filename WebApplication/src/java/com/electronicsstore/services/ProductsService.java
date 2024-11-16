package com.electronicsstore.services;

import com.electronicsstore.dao.ProductDao;
import com.electronicsstore.dto.PagedList;
import com.electronicsstore.dto.UserResponse;
import com.electronicsstore.models.Product;
import com.electronicsstore.models.User;
import jakarta.servlet.ServletException;
import java.util.ArrayList;
import java.util.List;

public class ProductsService {

    private final ProductDao dao;

    public ProductsService() {
        this.dao = new ProductDao();
    }

    public Product getProductByName(String name) throws ClassNotFoundException {
        return this.dao.getByName(name);

    }

    public Product createProduct(String name, double value, String description, int stockQuantity, int categoryId) throws ServletException, ClassNotFoundException {
        Product product = new Product(name, value, description, stockQuantity, categoryId);
        return this.dao.create(product);
    }

    public void deleteProduct(int id) {
        this.dao.delete(id);
    }

    public Product updateProduct(Product product) {
        return this.dao.update(product);
    }

    public Product getProductById(int id) {
        return this.dao.getById(id);
    }

    public boolean checkNameAlreadyInUse(String name, int id) throws ClassNotFoundException {
        Product product = this.dao.getByName(name);

        if (product == null) {
            return false;
        }

        if (product.getId() == id) {
            return false;
        }

        return true;
    }

    public PagedList<Product> getAllProductWithFilter(String search, int page) throws ClassNotFoundException {
        int size = 5;
        int total;

        if (page < 1) {
            page = 1;
        }

        List<Product> products = this.dao.list(search, page, size);

        if (search == null) {
            total = this.dao.getTotal();
        } else {
            total = this.dao.getTotal(search);
        }

        return new PagedList<>(page, size, total, products);

    }

}
