<%@ page import="com.electronicsstore.modelos.Usuario" %>
<%@ page import="com.electronicsstore.database.dao.UsuarioDao" %>
<%@ page import="jakarta.websocket.Session" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String endereco = request.getParameter("endereco");
    String senha = request.getParameter("senha");

    if(!nome.isBlank() && !email.isBlank() && !endereco.isBlank() && !senha.isBlank()) {
        try {
            Usuario usuario = new Usuario(nome, email, endereco, senha);
            UsuarioDao usuarioDao = new UsuarioDao();
            usuarioDao.Criar(usuario);
            session.setAttribute("session",usuario.getId());

            out.println("Sucesso ao cadastrar o usuário");

        } catch (Exception ex) {
            out.println(ex.getMessage());
        }


    }
    else {
        out.println("Os dados de cadastros não podem ser vázios");
    }
%>