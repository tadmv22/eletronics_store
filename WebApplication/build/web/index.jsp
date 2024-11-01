<%@ page import="com.electronicsstore.modelos.Usuario" %>
<%@ page import="com.electronicsstore.database.dao.UsuarioDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page session="true" %>

<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("/WebApplication/views/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
     <title>Eletronics Store - Home</title>
</head>
<body>
    <%= email %>
</form>
</body>
</html>
