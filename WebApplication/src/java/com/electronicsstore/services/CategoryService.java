package com.electronicsstore.services;

import com.electronicsstore.dao.CategoryDao;
import com.electronicsstore.dto.CategoryResponse;
import com.electronicsstore.dto.PagedList;
import com.electronicsstore.models.Category;
import jakarta.servlet.ServletException;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {

    private final CategoryDao dao;

    public CategoryService() throws ClassNotFoundException {
        this.dao = new CategoryDao();
    }

    public Category createCategory(String name, String description) throws ServletException, ClassNotFoundException {
        Category category = new Category(name, description);
        return this.dao.create(category);
    }

    public void deleteCategory(int id) {
        this.dao.delete(id);
    }

    public Category updateCategory(Category category) {
        return this.dao.update(category);
    }

    public Category getCategoryByName(String name) throws ClassNotFoundException {
        return this.dao.getByName(name);
    }

    public Category getById(int id) throws ClassNotFoundException {
        return this.dao.getById(id);
    }

    public PagedList<CategoryResponse> getAllCategoriesWithFilter(String search, int page) throws ClassNotFoundException {
        int size = 5;
        int total;
                
        if (page < 1) {
            page = 1;
        }

        List<CategoryResponse> categories = this.dao.listWithTotalProducts(search, page, size);
        
        if(search == null) {
            total = this.dao.getTotal();
        } else {
            total = this.dao.getTotal(search);
        }

        ArrayList<CategoryResponse> categoriesResponse = new ArrayList<>();

        for (CategoryResponse c : categories) {
            categoriesResponse.add(
                    new CategoryResponse(
                            c.getId(),
                            c.getName(),
                            c.getDescription(),
                            c.getTotalProducts(),
                            c.getIsActive(),
                            c.getCreatedAt(),
                            c.getUpdateAt()
                    ));
        }

        return new PagedList<>(page, size, total, categoriesResponse);

    }

    public boolean checkNameAlreadyInUse(String name, int id) throws ClassNotFoundException {
        Category category = this.dao.getByName(name);

        if (category == null) {
            return false;
        }

        if (category.getId() == id) {
            return false;
        }

        return true;
    }

    public void changeStatusCategory(int id) {
        Category category = this.dao.getById(id);

        if (category != null) {
            if (category.getIsActive()) {
                category.setIsActive(false);
            } else {
                category.setIsActive(true);
            }
        }

        this.dao.update(category);
    }
}
