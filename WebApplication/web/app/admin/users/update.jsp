<%@page import="com.electronicsstore.models.User"%>
<jsp:useBean id="services" class="com.electronicsstore.services.UserService" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
    String id = (String) request.getParameter("id");
    try {
        int userId = Integer.parseInt(id);
        User user = services.getUserById(userId);
        request.setAttribute("user", user);
    } catch (NumberFormatException e) {

    }
%>


<!DOCTYPE html>
<html lang="pt-br">
    <%@include file="../../../WEB-INF/components/head.jsp"%>

    <body id="register">
        <%@include file="../../../WEB-INF/components/header.jsp"%>
        <div class="container">
            <main>
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="titulo-principal">Atualizar usuário</h2>
                    </div>
                    <form action="/api/admin/users/update?id=${user.id}" method="post" class="form-conteudo">
                        <div class="field-container">
                            <div class="field">
                                <label for="name" class="label-padrao">Nome</label>
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    value="${user.name}"
                                    placeholder="Digite o nome"
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
                                    value="${user.surname}"
                                    placeholder="Digite o sobrenome"
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
                                value="${user.email}"
                                required
                                placeholder="Digite o e-mail"
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

                        <c:if test="${sessionScope.currentSessionUser.email eq user.email}" >
                            <div class="field">
                                <label for="oldPassword" class="label-padrao">Senha anterior</label>
                                <input
                                    type="password"
                                    id="oldPassword"
                                    name="oldPassword"
                                    required
                                    placeholder="Digite sua senha anterior"
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty passwordError}">
                                    <div class="form-error">
                                        ${passwordError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="newPassword" class="label-padrao">Nova senha</label>
                                <input
                                    type="password"
                                    id="newPassword"
                                    name="newPassword"
                                    required
                                    placeholder="Digite sua senha nova senha"
                                    class="input-padrao"
                                    />
                                <c:if test="${not empty passwordError}">
                                    <div class="form-error">
                                        ${passwordError}
                                    </div>
                                </c:if>
                            </div>
                        </c:if>        
                        <div class="field-actions">
                            <c:if test="${not empty invalidPassword}">
                                <div class="form-error">
                                    ${invalidPassword}
                                </div>
                            </c:if>
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
