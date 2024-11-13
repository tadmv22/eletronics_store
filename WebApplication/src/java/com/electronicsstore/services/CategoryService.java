package com.electronicsstore.services;

import com.electronicsstore.dao.CategoryDao;
import com.electronicsstore.dto.PagedList;
import com.electronicsstore.dto.UserResponse;
import com.electronicsstore.models.Category;
import com.electronicsstore.models.User;
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

    public PagedList<Category> getAllCategories(int page, String query) throws ClassNotFoundException {

        if (page < 1) {
            page = 1;
        }

        List<Category> categories = this.dao.list(page, query);

        int total = this.dao.getTotal();

        ArrayList<Category> categoriesResponse = new ArrayList<>();

        for (Category c : categories) {
            categoriesResponse.add(
                    new Category(
                            c.getId(),
                            c.getName(),
                            c.getDescription(),
                            c.getIsActive(),
                            c.getCreatedAt(),
                            c.getUpdateAt()
                    ));
        }

        return new PagedList<>(page, 5, total, categoriesResponse);

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
