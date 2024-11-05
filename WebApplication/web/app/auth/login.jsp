<%@page import="com.electronicsstore.utils.ErrorMensagem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.HashMap" %>

<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="icon" type="image/x-icon" href="/public/assets/favicon.ico" />
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
          <form action="/auth/login" method="post" class="form-conteudo">
            <div class="field">
              <label for="email" class="label-padrao">E-mail</label>
              <input
                type="email"
                id="email"
                name="email"
                placeholder="Digite seu e-mail"
                required
                class="input-padrao"
              />
              <div class="form-error">
                <c:if test="${not empty emailError}"> ${emailError} </c:if>
              </div>
            </div>
            <div class="field">
              <label for="password" class="label-padrao">Senha</label>
              <input
                type="password"
                id="password"
                name="password"
                required
                placeholder="Digite sua senha"
                class="input-padrao"
              />
              <div class="form-error">
                <c:if test="${not empty passwordError}">
                  ${passwordError}
                </c:if>
              </div>
            </div>
            <div class="field">
              <div class="form-error">
                <c:if test="${not empty loginError}"> ${loginError} </c:if>
              </div>
              <button type="submit" class="botao">ENTRAR</button>
            </div>
          </form>
          <div class="texto-normal account-register">
            <span>Não tem uma conta?</span>
            <a href="/app/users/register.jsp">Cadastre-se agora</a>
          </div>
        </div>
      </main>
      <footer>
        <p class="texto-pequeno copy">
          Eletronics Store © 2024. Alguns direitos reservados.
        </p>
      </footer>
    </div>
  </body>
</html>
