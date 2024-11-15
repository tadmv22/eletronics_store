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
        <link rel="stylesheet" href="/public/css/pages/users.css" />
        <title>Eletronics Store - Usuários</title>
    </head>
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
        <link rel="stylesheet" href="/public/css/pages/users.css" />
        <title>Eletronics Store - Usuários</title>
    </head>

    <body id="users-update">
        <div class="layout">
            <%@include file="../../../WEB-INF/components/sidebar.jsp" %>
            <div class="main-container-content">
                <div class="breadcrumb-container">
                    <ul class="breadcrumb-list">
                        <li class="breadcrumb-item">
                            <a href="/" class="text-xs">
                                Home
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/users/list.jsp"  class="text-xs">
                                Usuários
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/users/update.jsp?id=${param.id}"  class="text-xs icon-none">
                                Atualizar informações do usuário
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Atualizar informações do usuário</h1>
                    <div class="form-container">
                        <form action="/api/users/update?id=${user.id}" method="post" class="update-user-form">
    <body id="users-update">
        <div class="layout">
            <%@include file="../../../WEB-INF/components/sidebar.jsp" %>
            <div class="main-container-content">
                <div class="breadcrumb-container">
                    <ul class="breadcrumb-list">
                        <li class="breadcrumb-item">
                            <a href="/" class="text-xs">
                                Home
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/users/list.jsp"  class="text-xs">
                                Usuários
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/users/update.jsp?id=${param.id}"  class="text-xs icon-none">
                                Atualizar informações do usuário
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Atualizar informações do usuário</h1>
                    <div class="form-container">
                        <form action="/api/users/update?id=${user.id}" method="post" class="update-user-form">
                            <div class="field">
                                <label for="name" class="label-default">Nome</label>
                                <label for="name" class="label-default">Nome</label>
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    value="${user.name}"
                                    placeholder="Digite o nome"
                                    required
                                    class="input-default"
                                    class="input-default"
                                    />
                                <c:if test="${not empty nameError}">
                                    <div class="form-error text-sm">
                                    <div class="form-error text-sm">
                                        ${nameError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="surname" class="label-default">Sobrenome</label>
                                <label for="surname" class="label-default">Sobrenome</label>
                                <input
                                    type="text"
                                    id="surname"
                                    name="surname"
                                    value="${user.surname}"
                                    placeholder="Digite o sobrenome"
                                    required
                                    class="input-default"
                                    class="input-default"
                                    />
                                <c:if test="${not empty surnameError}">
                                    <div class="form-error text-sm">
                                        ${surnameError}
                                <c:if test="${not empty surnameError}">
                                    <div class="form-error text-sm">
                                        ${surnameError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="email" class="label-default">E-mail</label>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    value="${user.email}"
                                    required
                                    placeholder="Digite o e-mail"
                                    class="input-default"
                                    />
                                <c:if test="${not empty invalidEmail}">
                                    <div class="form-error text-sm">
                                        ${invalidEmail}
                                    </div>
                                </c:if>
                                <c:if test="${not empty emailInUseError}">
                                    <div class="form-error text-sm">
                                        ${emailInUseError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="status" class="label-default">Status</label>
                                <select name="status" id="status"  class="select-default">
                                    <option value="1" ${user.isActive ? "selected" : ""}>Ativo</option>
                                    <option value="0" ${!user.isActive ? "selected" : ""} >Inativo</option>
                                </select>
                            </div>
                            <c:if test="${sessionScope.currentSessionUser.email eq user.email}" >
                                <div class="field">
                                    <label for="oldPassword" class="label-default">Senha anterior</label>
                                    <input
                                        type="password"
                                        id="oldPassword"
                                        name="oldPassword"
                                        required
                                        placeholder="Digite sua senha anterior"
                                        class="input-default"
                                        />
                                    <c:if test="${not empty passwordError}">
                                        <div class="form-error text-sm">
                                            ${passwordError}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="field">
                                    <label for="newPassword" class="label-default">Nova senha</label>
                                    <input
                                        type="password"
                                        id="newPassword"
                                        name="newPassword"
                                        required
                                        placeholder="Digite sua senha nova senha"
                                        class="input-default"
                                        />
                                    <c:if test="${not empty passwordError}">
                                        <div class="form-error text-sm">
                                            ${passwordError}
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>        
                            <div class="field-actions">
                                <c:if test="${not empty invalidPassword}">
                                    <div class="form-error text-sm">
                                        ${invalidPassword}
                                    </div>
                                </c:if>
                                <c:if test="${not empty invalidValues}">
                                    <div class="form-error text-sm">
                                        ${invalidValues}
                                    </div>
                                </c:if>

                                <button type="submit" class="btn">Salvar</button>
                                <a href="/app/admin/users/list.jsp" class="btn btn-outline close">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
                                <button type="submit" class="btn">Salvar</button>
                                <a href="/app/admin/users/list.jsp" class="btn btn-outline close">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
    </body>
</html>
