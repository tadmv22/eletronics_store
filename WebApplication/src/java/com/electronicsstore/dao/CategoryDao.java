package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class CategoryDao implements BaseDao<Category> {

    public CategoryDao() throws ClassNotFoundException {
    }

    @Override
    public Category create(Category input) {

        String sql = "INSERT INTO categories (name,description) VALUES (?,?);";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getName());
            stmt.setString(2, input.getDescription());

            int result = stmt.executeUpdate();

            if (result == 1) {
                return this.getByName(input.getName());
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return null;

    }

    @Override
    public Category update(Category input
    ) {

        String sql = "UPDATE categories SET name = ?,description =?,is_active=?,updated_at =? WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getName());
            stmt.setString(2, input.getDescription());
            stmt.setBoolean(3, input.getIsActive());
            stmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(5, input.getId());

            int rs = stmt.executeUpdate();

            if (rs == 1) {
                return this.getByName(input.getName());
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public void delete(int id
    ) {

        String sql = "DELETE FROM categories WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Category> list(int page, String query
    ) {
        List<Category> categories = new ArrayList<>();
        String sql;

        String searchTerm = (query == null) ? "%%" : "%" + query + "%";
        int size = 5;
        int offset = (page - 1) * size;

        sql = "SELECT * FROM categories WHERE (name LIKE ? or description LIKE ?) LIMIT ?,?";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setInt(3, offset);
            stmt.setInt(4, size);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return categories;
    }

    @Override
    public Category getById(int id
    ) {

        String sql = "SELECT * FROM categories WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
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

    public Category getByName(String name) {

        String sql = "SELECT * FROM categories WHERE name = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
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

    @Override
    public int getTotal() {
        String sql = "SELECT COUNT(*) AS total FROM categories";

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
}
