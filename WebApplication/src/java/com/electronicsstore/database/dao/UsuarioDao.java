package com.electronicsstore.database.dao;

import com.electronicsstore.database.jdbc.ConnectionFactory;
import com.electronicsstore.modelos.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDao {
    private final Connection conn;

    public  UsuarioDao() throws ClassNotFoundException  {
        this.conn = new ConnectionFactory().getConnection();
    }

    public void Criar(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nome,email,endereco,senha) VALUES (?,?,?,?);";

        try(PreparedStatement stmt  = conn.prepareStatement(sql)) {
            stmt .setString(1,usuario.getNome());
            stmt .setString(2,usuario.getEmail());
            stmt .setString(3,usuario.getEndereco());
            stmt .setString(4,usuario.getSenha());

            stmt.execute();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public  boolean ValidaLogin(String email, String senha) {
        String sql = "SELECT email FROM usuarios WHERE  email =? AND senha =?;";
        try(PreparedStatement stmt  = conn.prepareStatement(sql)) {

            stmt.setString(1,email);
            stmt.setString(2,senha);

            ResultSet rs = stmt.executeQuery();

            if(rs.next()) {
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
