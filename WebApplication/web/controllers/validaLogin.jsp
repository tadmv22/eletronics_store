<%@ page import="com.electronicsstore.database.dao.UsuarioDao" %>
<%@ page import="jakarta.websocket.Session" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap" %>


<%
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (email == null || email.isBlank()) {
            response.sendRedirect("/WebApplication/views/login.jsp?error=1");
        } else if (senha == null || senha.isBlank()) {
            response.sendRedirect("/WebApplication/views/login.jsp?error=2");
        } else {

            try {
                UsuarioDao usuarioDao = new UsuarioDao();
                boolean loginValido = usuarioDao.ValidaLogin(email,senha);

                if(loginValido) {
                    session.setAttribute("email", email);
                    response.sendRedirect("/WebApplication/index.jsp");
                } else {
                    response.sendRedirect("/WebApplication/views/login.jsp?error=3");
                }
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }


        }
%>