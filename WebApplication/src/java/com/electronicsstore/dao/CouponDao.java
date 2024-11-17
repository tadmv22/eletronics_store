package com.electronicsstore.dao;

import com.electronicsstore.database.ConnectionFactory;
import com.electronicsstore.models.Coupon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CouponDao implements BaseDao<Coupon> {

    @Override
    public Coupon create(Coupon input) {
        String sql = "INSERT INTO coupons (code,description,discount_value,start_at,expiration_at) VALUES (?,?,?,?,?);";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getCode());
            stmt.setString(2, input.getDescription());
            stmt.setDouble(3, input.getDiscountValue());
            stmt.setDate(4, new Date(input.getStartAt().getTime()));

            if (input.getExpirationAt() != null) {
                stmt.setDate(5, new Date(input.getExpirationAt().getTime()));
            }
            stmt.setDate(5, null);

            int result = stmt.executeUpdate();

            if (result == 1) {
                return this.getByCode(input.getCode());
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public Coupon update(Coupon input) {
        String sql = "UPDATE coupons SET code = ?,description =?,discount_value=?,start_at=?,expiration_at=?,is_active=?,updated_at =? WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, input.getCode());
            stmt.setString(2, input.getDescription());
            stmt.setDouble(3, input.getDiscountValue());
            stmt.setDate(4, new Date(input.getStartAt().getTime()));

            if (input.getExpirationAt() != null) {
                stmt.setDate(5, new Date(input.getExpirationAt().getTime()));
            } else {
                stmt.setDate(5, null);
            }

            stmt.setBoolean(6, input.getActive());
            stmt.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(8, input.getId());

            int rs = stmt.executeUpdate();

            if (rs == 1) {
                return this.getByCode(input.getCode());
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM coupons WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Coupon> list(String search, int page, int size) {
        List<Coupon> coupons = new ArrayList<>();

        String sql = "SELECT * FROM coupons WHERE (code LIKE ? or description LIKE ?) LIMIT ?,?";

        String searchTerm = (search == null) ? "%%" : "%" + search + "%";
        int offset = (page - 1) * size;

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setInt(3, offset);
            stmt.setInt(4, size);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                coupons.add(new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("description"),
                        rs.getDouble("discount_value"),
                        rs.getDate("start_at"),
                        rs.getDate("expiration_at"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return coupons;
    }

    @Override
    public int getTotal() {
        String sql = "SELECT COUNT(*) AS total FROM coupons";

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

        String sql = "SELECT COUNT(*) AS total FROM coupons WHERE (code LIKE ? or description LIKE ?);";

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

    @Override
    public Coupon getById(int id) {
        String sql = "SELECT * FROM coupons WHERE id = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("description"),
                        rs.getDouble("discount_value"),
                        rs.getDate("start_at"),
                        rs.getDate("expiration_at"),
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

    public Coupon getByCode(String code) {

        String sql = "SELECT * FROM coupons WHERE code = ?;";

        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("description"),
                        rs.getDouble("discount_value"),
                        rs.getDate("start_at"),
                        rs.getDate("expiration_at"),
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
    
    public List<Coupon> getCouponsByProducts(int productId) {
        List<Coupon> coupons = new ArrayList<>();

        String sql = """
                SELECT 
                    *
                FROM
                    eletronics_store.coupons
                WHERE
                    id IN (SELECT 
                            coupon_id
                        FROM
                            eletronics_store.product_coupon
                        WHERE
                            product_id = ?
                        GROUP BY 1)
                """;


        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                coupons.add(new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("description"),
                        rs.getDouble("discount_value"),
                        rs.getDate("start_at"),
                        rs.getDate("expiration_at"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return coupons;
    }

    public List<Coupon> getCouponsAvalibleByProducts(int productId) {
        List<Coupon> coupons = new ArrayList<>();

        String sql = """
                SELECT 
                    c.id, c.code,c.description,c.discount_value,c.start_at,c.expiration_at,c.is_active,c.created_at,c.updated_at
                FROM
                    eletronics_store.coupons c
                        LEFT JOIN
                    eletronics_store.product_coupon cp ON c.id = cp.coupon_id
                WHERE
                    c.id NOT IN (SELECT 
                            coupon_id
                        FROM
                            eletronics_store.product_coupon
                        WHERE
                            product_id = ?
                        GROUP BY 1)
                """;


        try (Connection conn = new ConnectionFactory().getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                coupons.add(new Coupon(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("description"),
                        rs.getDouble("discount_value"),
                        rs.getDate("start_at"),
                        rs.getDate("expiration_at"),
                        rs.getBoolean("is_active"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                ));
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return coupons;
    }
}

