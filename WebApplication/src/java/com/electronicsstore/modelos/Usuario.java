package com.electronicsstore.modelos;
import java.util.Date;

public class Usuario {

    private int Id;
    private String Nome;
    private String  Email;
    private String Senha;
    private String Endereco;
    private boolean Ativo;
    private Date DataCadastro;

    public Usuario(int id,
                   String nome,
                   String email,
                   String senha,
                   String endereco,
                   boolean ativo,
                   Date dataCadastro) {
        Id = id;
        Nome = nome;
        Email = email;
        Endereco = endereco;
        Ativo = ativo;
        DataCadastro = dataCadastro;
    }

    public Usuario(
            String nome,
            String email,
            String senha,
            String endereco) {
        Nome = nome;
        Email = email;
        Endereco = endereco;
        Senha = senha;
    }


    public int getId() {
        return Id;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String nome) {
        Nome = nome;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getEndereco() {
        return Endereco;
    }

    public void setEndereco(String endereco) {
        Endereco = endereco;
    }

    public boolean isAtivo() {
        return Ativo;
    }

    public void setAtivo(boolean ativo) {
        Ativo = ativo;
    }

    public Date getDataCadastro() {
        return DataCadastro;
    }

    public String getSenha() {
        return Senha;
    }

    public void setSenha(String senha) {
        Senha = senha;
    }

}