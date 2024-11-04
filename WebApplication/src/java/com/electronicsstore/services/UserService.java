package com.electronicsstore.services;

import jakarta.servlet.ServletException;
import com.electronicsstore.dao.UserDao;
import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.User;

public class UserService {

    public CurrentUser CreateUser(String name, String email, String password, String address) throws ServletException, ClassNotFoundException {
        User user = new User(name, email, password, address);
        UserDao userDao = new UserDao();
        userDao.Create(user);

        return new CurrentUser(user.getEmail(), user.getName());
    }
}
