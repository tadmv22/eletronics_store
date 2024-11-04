package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDao {

    private final Connection conn;

    public ProductDao() throws ClassNotFoundException {
        this.conn = new ConnectionFactory().getConnection();
    }

    public void Create(Product product) {
        String sql = "INSERT INTO products (name,value,description,stock_quantity) VALUES (?,?,?,?);";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setDouble(2, product.getValue());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getStock_quantity());

            stmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Product getProductById(int id) {
        String sql = "SELECT id FROM products WHERE  id =?;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("value"),
                        rs.getString("description"),
                        rs.getInt("stock_quantity")
                );
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        
        return null;
    }
        

    public ArrayList<Product> getAll(int limit, int offset) {
        
        ArrayList productList = new ArrayList(); 
        String sql = "SELECT id,name,value,description,stock_quantity FROM products ORDER BY ProductID LIMIT ?,?";
                
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, offset);
            stmt.setInt(2, limit);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("value"),
                        rs.getString("description"),
                        rs.getInt("stock_quantity")
                ));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return productList;
    }
    
    public void Delete(int id) {
        
        String sql = "DELETE FROM products WHERE id= ?";
                
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
