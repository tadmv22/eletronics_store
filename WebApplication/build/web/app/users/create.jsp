<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<form action="/WebApplication/controllers/validaCadastro.jsp" method="post">
<div>
    <label for="nome">Nome</label>
    <input type="text" name="nome" id="nome" required />
</div>
    <div>
        <label for="email">Email</label>
        <input type="email" name="email" id="email" required/>
    </div>
    <div>
        <label for="endereco">Endereço</label>
        <input type="text" name="endereco" id="endereco" required />
    </div>
    <div>
        <label for="senha">Nome</label>
        <input type="password" name="senha" id="senha" required/>
    </div>
    <button type="submit">Cadastrar</button>
</form>
</body>
</html>
