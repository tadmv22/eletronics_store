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
        String sql = "INSERT INTO users (name,surname,email,address,zipcode,password) VALUES (?,?,?,?,?,?);";

        try(PreparedStatement stmt  = conn.prepareStatement(sql)) {
            stmt .setString(1,user.getName());
            stmt .setString(2,user.getSurname());
            stmt .setString(3,user.getEmail());
            stmt .setString(4,user.getAddress());
            stmt .setString(5,user.getZipcode());
            stmt .setString(6,user.getPassword());

            int result =  stmt.executeUpdate();
            
            if(result != 0) {
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
                        rs.getString("surname"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("zipcode"),
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
