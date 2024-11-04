<%@page import="com.electronicsstore.utils.ErrorMensagem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap" %>



<% String messageEmailError = "";
    String messageSenhaError = "";
    String messageLoginError = "";
    String error = request.getParameter("error");;
    if (error != null) {
        switch (error) {
            case "1" -> {
                messageEmailError = new ErrorMensagem().getMessageByCode(Integer.parseInt(error));
            }
            case "2" -> {
                messageSenhaError = new ErrorMensagem().getMessageByCode(Integer.parseInt(error));;
            }
            case "3" -> {
                messageLoginError = new ErrorMensagem().getMessageByCode(Integer.parseInt(error));;
            }
            default -> {

            }
        }
    }


%>


<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
            rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="/public/assets/favicon.ico">
        <link rel="stylesheet" href="/public/css/styles.css" />
        <title>Eletronics Store - Login</title>
    </head>

    <body>
        <div id="login">
            <main>
                <div class="logo">
                    <img src="/public/assets/logo.svg" alt="Logo AgendaTennis" />
                </div>
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="titulo-principal">Acesse sua conta</h2>
                        <p class="texto-normal">
                            Bem-vindo de volta! Por favor, insira seus dados.
                        </p>
                    </div>
                    <form action="/users/login" method="post" class="form-conteudo">
                        <div>
                            <label for="email" class="label-padrao">E-mail</label>
                            <input type="email" id="email" name="email" placeholder="Digite seu e-mail"
                                   required class="input-padrao" />
                            <div class="form-error">
                                <c:if test="${not empty messageEmailError}">
                                    ${messageEmailError}
                                </c:if>
                            </div>
                        </div>
                        <div>
                            <label for="password" class="label-padrao">Senha</label>
                            <input type="password" id="password" name="password" required
                                   placeholder="Digite sua senha" class="input-padrao" />
                            <div class="form-error">
                                <c:if test="${not empty messageEmailError}">
                                    ${messageSenhaError}
                                </c:if>
                            </div>
                        </div>
                        <div class="form-error">
                            <c:if test="${not empty messageEmailError}">
                                ${messageLoginError}
                            </c:if>
                        </div>
                        <button type="submit" class="botao">ENTRAR</button>
                    </form>
                </div>
                <p class="texto-pequeno copy">
                    Eletronics Store © 2024. Alguns direitos reservados.
                </p>
            </main>
        </div>
    </body>

</html>