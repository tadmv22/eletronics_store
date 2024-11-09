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
        return this.dao.Create(user);
    }

    public void deleteUser() {

    }

    public User updateUser(User user) {
        return null;
    }
    
    public boolean checkEmailAlreadyInUse(String email, int id) {
        return true;
    }

    public User getUserByEmail(String email) throws ClassNotFoundException {
        return this.dao.getUserByEmail(email);
    }
    
     public User getUserById(int id) throws ClassNotFoundException {
        return this.dao.getUserById(id);
    }

    public PagedList<UserResponse> getAllUser(int page, String query) throws ClassNotFoundException {
        
        if(page < 1) {
            page = 1;
        }
        
        List<User> users = this.dao.getList(page,query);
        int total = this.dao.getTotal();

        ArrayList<UserResponse> usersResponse = new ArrayList<>();

        for (User u : users) {
            usersResponse.add(
                    new UserResponse(
                            u.getId(),
                            u.getName(),
                            u.getSurname(),
                            u.getEmail(),
                            u.getIsActive(),
                            u.getCreatedAt()
                    ));
        }

        return new PagedList<>(page, 10, total, usersResponse);

    }
}
