package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public UserDao() throws ClassNotFoundException {

    }

    public User Create(User user) throws ClassNotFoundException {
        String sql = "INSERT INTO users (name,surname,email,password) VALUES (?,?,?,?);";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getSurname());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());

            int result = stmt.executeUpdate();

            if (result != 0) {
                return this.getUserByEmail(user.getEmail());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public int getTotal() throws ClassNotFoundException {
        String sql = "SELECT COUNT(*) AS total FROM users";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public List<User> getList(int page, String query) throws ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String sql;
        
        String searchTerm =  (query == null) ? "%%" : "%" + query + "%"; 
        int size = 10;
        int offset = (page - 1) * size;
        
        sql = "SELECT * FROM users WHERE (name LIKE ? or surname LIKE ? ) LIMIT ?,?";
        
        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setInt(3, offset);
            stmt.setInt(4, size);
            
            
            ResultSet rs = stmt.executeQuery();
            System.out.println(stmt);
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("surname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at")
                ));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        
        
        return users;
    }

    public User getUserByEmail(String email) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE  email =?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("surname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

     public User getUserById(int id) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE  id =?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("surname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}
