package com.electronicsstore.services;

import jakarta.servlet.ServletException;
import com.electronicsstore.dao.UserDao;
import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.User;

public class UserService {

    public CurrentUser Login(String email, String password) throws ClassNotFoundException 
    {
        UserDao userDao = new UserDao();
        User user = userDao.getUserByEmail(email);
            
        if (user != null && user.getPassword().equals(password)) {
            return new CurrentUser(user.getEmail(), user.getName());
        }
        
        return null;
            
    }
    
    public CurrentUser CreateUser(String name, String email, String password, String address) throws ServletException, ClassNotFoundException {
        User user = new User(name, email, password, address);
        UserDao userDao = new UserDao();
        userDao.Create(user);

        return new CurrentUser(user.getEmail(), user.getName());
    }
}
