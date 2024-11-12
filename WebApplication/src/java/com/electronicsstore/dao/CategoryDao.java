package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CategoryDao implements BaseDao<Category> {

    private final Connection conn;

    public CategoryDao(Connection conn) throws ClassNotFoundException {
        this.conn = new ConnectionFactory().getConnection();
    }

    @Override
    public Category create(Category input) {

        String sql = "INSERT INTO categories (name) VALUES (?);";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, input.getName());
            int result = stmt.executeUpdate();

            if (result != 0) {
                this.getByName(input.getName());
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public Category update(Category input) {

        String sql = "UPDATE categories SET name = ? WHERE id = ?;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, input.getName());
            stmt.setInt(2, input.getId());

            int rs = stmt.executeUpdate();

            if (rs != 0) {
                this.getByName(input.getName());
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public void delete(int id) {

        String sql = "DELETE FROM categories WHERE id = ?;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Category> list(int page, String query) {
        List<Category> categories = new ArrayList<>();
        String sql;

        String searchTerm = (query == null) ? "%%" : "%" + query + "%";
        int size = 10;
        int offset = (page - 1) * size;

        sql = "SELECT * FROM categories WHERE name LIKE ? LIMIT ?,?";

        try (PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, searchTerm);
            stmt.setInt(2, offset);
            stmt.setInt(3, size);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return categories;
    }

    @Override
    public Category getById(int id) {

        String sql = "SELECT id,name FROM categories WHERE id = ?;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public Category getByName(String name) {

        String sql = "SELECT id,name FROM categories WHERE name = ?;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}
