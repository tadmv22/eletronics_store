package com.electronicsstore.services;

import jakarta.servlet.ServletException;
import com.electronicsstore.dao.UserDao;
import com.electronicsstore.models.User;
import java.util.ArrayList;

public class UserService {
    
    private final UserDao dao;
    
    public UserService() throws ClassNotFoundException {
        this.dao = new UserDao();
    }
    
    public User createUser(String name, String email, String password, String address) throws ServletException {
        User user = new User(name, email, password, address);
        return this.dao.Create(user);
    }
    
    public void deleteUser() {
        
    }
    
    public User updateUser(User user) {
        return null;
    }
    
    public User getUserByEmail(String email) {
        return this.dao.getUserByEmail(email);
    }
    
    public ArrayList<User> getAll() {
        return null;
    }
}
