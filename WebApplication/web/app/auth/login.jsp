<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<%@include file="../../WEB-INF/components/head.jsp"%>
<body id="login" >
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
                <form action="/api/auth/login" method="post" class="form-conteudo">
                    <div class="field">
                        <label for="email" class="label-padrao">E-mail</label>
                        <input type="email" id="email" name="email" placeholder="Digite seu e-mail" required
                               class="input-padrao" />
                        <c:if test="${not empty emailError}">
                            <div class="form-error">
                                ${emailError}
                            </div>
                        </c:if>
                    </div>
                    <div class="field">
                        <label for="password" class="label-padrao">Senha</label>
                        <input type="password" id="password" name="password" required placeholder="Digite sua senha"
                               class="input-padrao" />
                        <c:if test="${not empty passwordError}">
                            <div class="form-error">
                                ${passwordError}
                            </div>
                        </c:if>
                    </div>
                    <div class="field">
                        <c:if test="${not empty loginError}">
                            <div class="form-error">
                                ${loginError}
                            </div>
                        </c:if>
                        <button type="submit" class="botao">ENTRAR</button>
                    </div>
                </form>
            </div>
        </main>
        <footer>
            <p class="texto-pequeno copy">
                Eletronics Store © 2024. Alguns direitos reservados.
            </p>
        </footer>
</body>

</html>