<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
    <%@include file="../../../WEB-INF/components/head.jsp"%>

    <body id="register">
        <%@include file="../../../WEB-INF/components/sidebar.jsp"%>
        <div class="container">
            <main>
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="titulo-principal">Registar novo usuário</h2>
                    </div>
                    <form action="/api/admin/users/register" method="post" class="form-conteudo">
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
                        <div class="field-actions">
                            <c:if test="${not empty invalidValues}">
                                <div class="form-error">
                                    ${invalidValues}
                                </div>
                            </c:if>

                            <button type="submit" class="botao">Salvar</button>
                            <button type="reset" class="botao">Cancelar</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
        <script src="/public/scripts/index.js"></script>
    </body>
</html>
