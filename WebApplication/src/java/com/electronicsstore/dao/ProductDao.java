package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.dto.ProductsAnalytics;
import com.electronicsstore.models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDao implements BaseDao<Product> {
    
    @Override
    public Product create(Product input) {
        String sql = "INSERT INTO products (name,value,description,stock_quantity) VALUES (?,?,?,?);";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, input.getName());
            stmt.setDouble(2, input.getValue());
            stmt.setString(3, input.getDescription());
            stmt.setInt(4, input.getStockQuantity());

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
    public Product update(Product input) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(int id) {

        String sql = "DELETE FROM products WHERE id= ?";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){

            stmt.setInt(1, id);

            stmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } 
    }

    @Override
    public List<Product> list(String search, int page, int size) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Product getById(int id) {
        String sql = "SELECT  FROM products WHERE  id =?;";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("value"),
                        rs.getString("description"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    @Override
    public int getTotal() {
        String sql = "SELECT COUNT(*) AS total FROM products";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public Product getByName(String name) {

        String sql = "SELECT * FROM products WHERE name = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("value"),
                        rs.getString("description"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id")
                );
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }
    
    public ProductsAnalytics viewAnalytics() {
        String sql = "SELECT * FROM ProductsViewAnalytics";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return new ProductsAnalytics(
                        rs.getInt("total_units"),
                        rs.getDouble("total_balanceas"),
                        rs.getDouble("averange")
                );
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }


}
