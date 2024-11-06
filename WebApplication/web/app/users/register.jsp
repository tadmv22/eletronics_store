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
            rel="stylesheet"
            />
        <link
            rel="icon"
            type="image/x-icon"
            href="../../public/assets/favicon.ico"
            />
        <link rel="stylesheet" href="../../public/css/styles.css" />
        <title>Eletronics Store - Crie sua conta</title>
    </head>

    <body id="register">
        <div class="container">
            <main>
                <div class="logo">
                    <img src="../../public/assets/logo.svg" alt="Logo AgendaTennis" />
                </div>
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="titulo-principal">Crie sua conta</h2>
                        <p class="texto-normal">
                            Vamos começar! Crie sua conta preenchendo o formulário abaixo.
                        </p>
                    </div>
                    <form action="/users/register" method="post" class="form-conteudo">
                        <div class="field-container">
                            <div class="field">
                                <label for="name" class="label-padrao">Nome</label>
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    placeholder="Digite seu nome"
                                    required
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty nameError}">
                                    <div class="form-error">
                                        ${nameError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="surname" class="label-padrao">Sobrenome</label>
                                <input
                                    type="text"
                                    id="surname"
                                    name="surname"
                                    placeholder="Digite seu sobrenome"
                                    required
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty nameError}">
                                    <div class="form-error">
                                        ${nameError}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="field-container">
                            <div class="field">
                                <label for="address" class="label-padrao">Endereço</label>
                                <input
                                    type="text"
                                    id="address"
                                    name="address"
                                    required
                                    placeholder="Rua exemplos, 123"
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty addressError}">
                                    <div class="form-error">
                                        ${addressError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="zipcode" class="label-padrao">CEP</label>
                                <input
                                    type="text"
                                    id="zipcode"
                                    name="zipcode"
                                    required
                                    placeholder="Ex. 12345000"
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty zipcodeError}">
                                    <div class="form-error">
                                        ${zipcodeError}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="field">
                            <label for="email" class="label-padrao">E-mail</label>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                required
                                placeholder="Digite seu e-mail"
                                class="input-padrao"
                                />
                            <c:if test="${not empty invalidEmail}">
                                <div class="form-error">
                                    ${invalidEmail}
                                </div>
                            </c:if>
                            <c:if test="${not empty emailInUseError}">
                                <div class="form-error">
                                    ${emailInUseError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <label for="password" class="label-padrao">Senha</label>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                required
                                placeholder="Digite sua senha para login"
                                class="input-padrao"
                                />
                            <c:if test="${not empty passwordError}">
                                <div class="form-error">
                                    ${passwordError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <c:if test="${not empty invalidValues}">
                                <div class="form-error">
                                    ${invalidValues}
                                </div>
                            </c:if>
                            <button type="submit" class="botao">CADASTRAR</button>
                        </div>
                    </form>
                    <div class="texto-normal account-register">
                        <span>Já tem uma conta? </span>
                        <a href="/app/auth/login.jsp">Acesse agora</a>
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
