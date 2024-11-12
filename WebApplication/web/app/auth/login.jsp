<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <link rel="icon" type="image/x-icon" href="/public/assets/favicon.ico" />
        <link rel="stylesheet" href="/public/css/index.css" />
        <link rel="stylesheet" href="/public/css/pages/login.css" />
        <title>Eletronics Store</title>
    </head>
    <body id="login" >
        <main>
            <div class="logo">
                <img src="/public/assets/logo.svg" alt="Logo AgendaTennis" />
            </div>
            <div class="form-container">
                <div class="form-header">
                    <h2 class="text-large">Acesse sua conta</h2>
                    <p class="text-base">
                        Bem-vindo de volta! Por favor, insira seus dados.
                    </p>
                </div>
                <form action="/api/auth/login" method="post" class="form-content">
                    <div class="field">
                        <label for="email" class="label-default text-sm">E-mail</label>
                        <input type="email" id="email" name="email" placeholder="Digite seu e-mail" required
                               class="input-default" />
                        <c:if test="${not empty emailError}">
                            <div class="form-error text-sm">
                                ${emailError}
                            </div>
                        </c:if>
                    </div>
                    <div class="field">
                        <label for="password" class="label-default text-sm">Senha</label>
                        <input type="password" id="password" name="password" required placeholder="Digite sua senha"
                               class="input-default" />
                        <c:if test="${not empty passwordError}">
                            <div class="form-error text-sm">
                                ${passwordError}
                            </div>
                        </c:if>
                    </div>
                     <c:if test="${not empty loginError}">
                            <div class="form-error text-sm">
                                ${loginError}
                            </div>
                        </c:if>
                    <div class="field">
                       <button type="submit" class="btn text-base">ENTRAR</button>
                    </div>
                </form>
            </div>
        </main>
        <footer>
            <p class="text-xs">
                Eletronics Store © 2024. Alguns direitos reservados.
            </p>
        </footer>
        <script src="/public/scripts/index.js"></script>
    </body>
</html>