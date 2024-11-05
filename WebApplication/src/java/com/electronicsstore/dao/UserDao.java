package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    private final Connection conn;

    public UserDao() throws ClassNotFoundException  {
        this.conn = new ConnectionFactory().getConnection();
    }

    public User Create(User user) {
        String sql = "INSERT INTO users (name,email,address,password) VALUES (?,?,?,?);";

        try(PreparedStatement stmt  = conn.prepareStatement(sql)) {
            stmt .setString(1,user.getName());
            stmt .setString(2,user.getEmail());
            stmt .setString(3,user.getAddress());
            stmt .setString(4,user.getPassword());

            boolean rs =  stmt.execute();
            
            if(rs) {
                return this.getUserByEmail(user.getEmail());
            }           
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
        
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE  email =?;";

        try(PreparedStatement stmt  = conn.prepareStatement(sql)) {

            stmt.setString(1,email);

            ResultSet rs = stmt.executeQuery();

            if(rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
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
