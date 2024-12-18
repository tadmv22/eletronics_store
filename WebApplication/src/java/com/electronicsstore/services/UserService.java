package com.electronicsstore.services;

import com.electronicsstore.dao.UserDao;
import com.electronicsstore.dto.PagedList;
import com.electronicsstore.dto.UserResponse;
import com.electronicsstore.models.User;
import jakarta.servlet.ServletException;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    private final UserDao dao;

    public UserService() throws ClassNotFoundException {
        this.dao = new UserDao();
    }

    public User createUser(String name, String surname, String email, String password) throws ServletException, ClassNotFoundException {
        User user = new User(name, surname, email, password);
        return this.dao.create(user);
    }

    public void deleteUser(int id) {
        this.dao.delete(id);
    }

    public User updateUser(User user) {
        return this.dao.update(user);
    }

    public boolean checkEmailAlreadyInUse(String email, int id) throws ClassNotFoundException {
        User user = this.dao.getUserByEmail(email);

        if (user == null) {
            return false;
        }

        if (user.getId() == id) {
            return false;
        }

        return true;
    }

    public User getUserByEmail(String email) throws ClassNotFoundException {
        return this.dao.getUserByEmail(email);
    }

    public User getUserById(int id) throws ClassNotFoundException {
        return this.dao.getById(id);
    }

    public PagedList<UserResponse> getAllUsersWithFilter(String search, int page) throws ClassNotFoundException {
        int size = 5;
        int total;
        
        if (page < 1) {
            page = 1;
        }

        List<User> users = this.dao.list(search, page, size);
        
        if(search == null) {
            total = this.dao.getTotal();
        } else {
            total = this.dao.getTotal(search);
        }

        ArrayList<UserResponse> usersResponse = new ArrayList<>();

        for (User u : users) {
            usersResponse.add(
                    new UserResponse(
                            u.getId(),
                            u.getName(),
                            u.getSurname(),
                            u.getEmail(),
                            u.getIsActive(),
                            u.getCreatedAt(),
                            u.getUpdateAt()
                    ));
        }

        return new PagedList<>(page, size, total, usersResponse);

    }

    public void changeStatusUser(int id) {
        User user = this.dao.getById(id);

        if (user != null) {
            user.changeStatus();
        }

        this.dao.update(user);
    }
}
