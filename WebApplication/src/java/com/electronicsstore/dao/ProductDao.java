package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.dto.ProductResponse;
import com.electronicsstore.dto.ProductsAnalytics;
import com.electronicsstore.models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDao implements BaseDao<Product> {

    @Override
    public Product create(Product input) {
        String sql = "INSERT INTO products (name,value,description,stock_quantity,category_id) VALUES (?,?,?,?,?);";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, input.getName());
            stmt.setDouble(2, input.getValue());
            stmt.setString(3, input.getDescription());
            stmt.setInt(4, input.getStockQuantity());
            stmt.setInt(5, input.getCategoryId());

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
        String sql = "UPDATE products SET name = ?,description =?,value=?,stock_quantity =?, category_id =?, updated_at =? WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getName());
            stmt.setString(2, input.getDescription());
            stmt.setDouble(3, input.getValue());
            stmt.setInt(4, input.getStockQuantity());
            stmt.setInt(5, input.getCategoryId());
            stmt.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(7, input.getId());

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
    public void delete(int id) {

        String sql = "DELETE FROM products WHERE id= ?";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            stmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Product> list(String search, int page, int size) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE name LIKE ? LIMIT ?,?";

        String searchTerm = (search == null) ? "%%" : "%" + search + "%";
        int offset = (page - 1) * size;

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setInt(2, offset);
            stmt.setInt(3, size);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("value"),
                        rs.getString("description"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("category_id")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    public List<ProductResponse> listWithCategoryName(String search, int page, int size) {
        List<ProductResponse> products = new ArrayList<>();

        String sql = """
        SELECT 
            p.id, p.name, p.value, p.description, p.stock_quantity, c.name as category_name
        FROM
            eletronics_store.products p
                LEFT JOIN
            eletronics_store.categories c ON p.category_id = c.id
        WHERE p.name LIKE ? LIMIT ?,?
        """;

        String searchTerm = (search == null) ? "%%" : "%" + search + "%";
        int offset = (page - 1) * size;

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setInt(2, offset);
            stmt.setInt(3, size);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new ProductResponse(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("value"),
                        rs.getInt("stock_quantity"),
                        rs.getString("category_name")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    @Override
    public Product getById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";

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

    public int getTotal(String search) {
        String sql = "SELECT COUNT(*) AS total FROM products WHERE name LIKE ?";

        String searchTerm = (search == null) ? "%%" : "%" + search + "%";

        try (Connection conn = new ConnectionFactory().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, searchTerm);
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
    
    
    public boolean addCoupon(int productId, int couponId) {
        String sql = "INSERT INTO product_coupon (product_id,coupon_id) VALUES (?,?)";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.setInt(2, couponId);

            int rs = stmt.executeUpdate();

            if (rs == 1) {
                return true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return false;
    }
    
    
    public boolean deleteCoupon(int productId, int couponId) {
        String sql = "DELETE FROM product_coupon WHERE product_id = ? AND coupon_id = ?";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.setInt(2, couponId);

            int rs = stmt.executeUpdate();

            if (rs == 1) {
                return true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return false;
    }

}
