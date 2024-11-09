package com.electronicsstore.services;

import com.electronicsstore.dao.UserDao;
import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.User;

public class AuthService {

    public CurrentUser Login(String email, String password) throws ClassNotFoundException {
        UserDao userDao = new UserDao();
        User user = userDao.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            return new CurrentUser(user.getEmail(), user.getName(),user.getId());
        }
        return null;
    }

}
