package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements BaseDao<User> {

    public UserDao() throws ClassNotFoundException {

    }

    @Override
    public User create(User input) {
        String sql = "INSERT INTO users (name,surname,email,password) VALUES (?,?,?,?);";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getName());
            stmt.setString(2, input.getSurname());
            stmt.setString(3, input.getEmail());
            stmt.setString(4, input.getPassword());

            int result = stmt.executeUpdate();

            if (result == 1) {
                return this.getUserByEmail(input.getEmail());
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public User update(User input) {
        String sql = "UPDATE users SET name=?,surname=?,email=?,password=?,is_active=?,updated_at=? WHERE id = ?";
        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, input.getName());
            stmt.setString(2, input.getSurname());
            stmt.setString(3, input.getEmail());
            stmt.setString(4, input.getPassword());
            stmt.setBoolean(5, input.getIsActive());
            stmt.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(7, input.getId());

            int result = stmt.executeUpdate();

            if (result == 1) {
                return input;
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);

            int result = stmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public List<User> list(String search, int page, int size) {
        List<User> users = new ArrayList<>();
        String sql;

        String searchTerm = (search == null) ? "%%" : "%" + search + "%";
        int offset = (page - 1) * size;

        sql = "SELECT * FROM users WHERE (name LIKE ? or surname LIKE ? or email LIKE ? ) LIMIT ?,?";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setInt(4, offset);
            stmt.setInt(5, size);

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
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    @Override
    public User getById(int id) {
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
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public User getUserByEmail(String email) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE  email =? AND is_active;";

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
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public int getTotal(){
        String sql = "SELECT COUNT(*) AS total FROM users";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } 
        return 0;
    }
    
    public int getTotal(String search) {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE (name LIKE ? or surname LIKE ?);";
        
        String searchTerm = (search == null) ? "%%" : "%" + search + "%";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } 
        return 0;
    }
}
