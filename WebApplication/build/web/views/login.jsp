<%@ page import="com.electronicsstore.modelos.Usuario" %>
<%@ page import="com.electronicsstore.database.dao.UsuarioDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap" %>


<%
    HashMap<Integer, String> messagesErrors = new HashMap<>();
    messagesErrors.put(1, "O email é obrigatório. Por favor, preencha este campo.");
    messagesErrors.put(2, "O senha é obrigatório. Por favor, preencha este campo.");
    messagesErrors.put(3, "Usuário ou senha incorretos. Por favor, verifique suas credenciais e tente novamente.");

    String messageEmailError = "";
    String messageSenhaError = "";
    String messageLoginError = "";

    String error = request.getParameter("error");

    if(error != null) {
        switch (error) {
            case "1" -> {
                messageEmailError = messagesErrors.get(1);
            }
            case "2" -> {
                messageSenhaError = messagesErrors.get(2);
            }
            case "3" -> {
                messageLoginError = messagesErrors.get(3);
            }
            default -> {

            }
        }
    }


%>

<!DOCTYPE html>
<html>
<head>
    <title>Eletronics Store - Login</title>
</head>
<body>
<form action="/WebApplication/controllers/validaLogin.jsp" method="post">
    <div>
        <label for="email">Email</label>
        <input type="email" name="email" id="email" required/>
        <div> <%= messageEmailError %> </div>
    </div>   
    <div>
        <label for="senha">Senha</label>
        <input type="password" name="senha" id="senha" required/>
        <div> <%= messageSenhaError %> </div>
    </div>
    <div> <%= messageLoginError %> </div>
    <button type="submit">Entrar</button>
</form>
</body>
</html>
