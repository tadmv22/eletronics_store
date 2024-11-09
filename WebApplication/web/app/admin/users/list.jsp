<%@page import="com.electronicsstore.dto.UserResponse" %>
<%@page import="com.electronicsstore.dto.PagedList" %>
<jsp:useBean id="services" class="com.electronicsstore.services.UserService" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String p = (String) request.getParameter("p");
    String q = (String) request.getParameter("q");
    try {
        int pageNumber = Integer.parseInt(p);
        PagedList<UserResponse> users = services.getAllUser(pageNumber, q);
        request.setAttribute("users", users);
    } catch (NumberFormatException e) {
        PagedList<UserResponse> users = services.getAllUser(1, q);
        request.setAttribute("users", users);
    }
%>


<!DOCTYPE html>
<html lang="pt-br">
    <%@include file="../../../WEB-INF/components/head.jsp" %>

    <body id="admin">
        <div id="remove-user-modal">
            <div class="modal-content">

                <div class="model-info">
                    <h3 class="titulo-principal">Confirmação de Exclusão de Usuário</h3>
                    <div>
                        <p class="texto-normal">Tem certeza de que deseja excluir o usuário
                      <span class="modal-user-email"></span>?
                        </p>
                        <p class="texto-normal">Esta ação é irreversível e todas as informações
                            associadas a este
                            usuário
                            serão permanentemente removidas do sistema. </p>
                    </div>


                </div>
                <div class="modal-actions">
                    <button type="button" class="botao close">Cancelar</button>
                    <a href="/api/admin/users/remove?id=" class="botao submit-delete">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide-trash-2 lucide">
                        <path d="M3 6h18" />
                        <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6" />
                        <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2" />
                        <line x1="10" x2="10" y1="11" y2="17" />
                        <line x1="14" x2="14" y1="11" y2="17" />
                        </svg>
                        Excluir
                    </a>
                </div>

            </div>
        </div>
        <div>
            <%@include file="../../../WEB-INF/components/header.jsp" %>
            <div class="container">
                <main>
                    <h1 class="titulo-principal">Gerenciamento de usuários</h1>
                    <div class="main-table">
                        <div class="products-list-header">
                            <p class="texto-normal">Total de usuários <span
                                    class="texto-pequeno">
                                    <c:out value="${users.totalCount}" />
                                    usuários
                                </span></p>
                            <div class="products-actions">
                                <form action="/app/admin/users/list.jsp" method="get"
                                      class="products-query">
                                    <input class="input-padrao" type="search" name="q"
                                           id="q" value="${param.q}"
                                           placeholder="Buscar usuário" />

                                    <c:if test="${not empty param.q}">
                                        <a href="/app/admin/users/list.jsp"
                                           class="clear-form">
                                            <svg xmlns="http://www.w3.org/2000/svg"
                                                 width="24" height="24" viewBox="0 0 24 24"
                                                 fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round"
                                                 stroke-linejoin="round"
                                                 class="lucide lucide-x">
                                            <path d="M18 6 6 18" />
                                            <path d="m6 6 12 12" />
                                            </svg>
                                        </a>
                                    </c:if>
                                    <button type="submit" class="botao">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide lucide-search">
                                        <circle cx="11" cy="11" r="8" />
                                        <path d="m21 21-4.3-4.3" />
                                        </svg>
                                    </button>
                                </form>
                                <a href="/app/admin/users/register.jsp" class="botao">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                         height="24" viewBox="0 0 24 24" fill="none"
                                         stroke="currentColor" stroke-width="2"
                                         stroke-linecap="round" stroke-linejoin="round"
                                         class="lucide lucide-plus">
                                    <path d="M5 12h14" />
                                    <path d="M12 5v14" />
                                    </svg>
                                    Registrar novo usuário
                                </a>
                            </div>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Sobrenome</th>
                                    <th>E-mail</th>
                                    <th>Data de Cadastrado</th>
                                    <th>Última atualização</th>
                                    <th>Status</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users.items}">
                                    <tr>
                                        <td>${user.name}</td>
                                        <td>${user.surname}</td>
                                        <td>${user.email}</td>
                                        <td>${user.createdAt}</td>
                                        <td>${user.createdAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.isActive}">
                                                    <span class="status status-active">
                                                        <span
                                                            class="status-active status-dot"></span>
                                                        Ativo
                                                    </span>
                                                </c:when>
                                                <c:when test="${!user.isActive}">
                                                    <span class="status">
                                                        <span class="status-dot"></span>
                                                        Inativo
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="remove-user user-action"
                                                                          data-email="${user.email}"
                                                    data-id="${user.id}">
                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                     width="24" height="24"
                                                     viewBox="0 0 24 24" fill="none"
                                                     stroke="currentColor" stroke-width="2"
                                                     stroke-linecap="round"
                                                     stroke-linejoin="round"
                                                     class="lucide-trash-2 lucide">
                                                <path d="M3 6h18" />
                                                <path
                                                    d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6" />
                                                <path
                                                    d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2" />
                                                <line x1="10" x2="10" y1="11" y2="17" />
                                                <line x1="14" x2="14" y1="11" y2="17" />
                                                </svg>
                                            </button>
                                        </td>
                                        <td>
                                            <a href="/app/admin/users/update.jsp?id=${user.id}"
                                               class="user-action">
                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                     width="24" height="24"
                                                     viewBox="0 0 24 24" fill="none"
                                                     stroke="currentColor" stroke-width="2"
                                                     stroke-linecap="round"
                                                     stroke-linejoin="round"
                                                     class="lucide lucide-pencil">
                                                <path
                                                    d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z" />
                                                <path d="m15 5 4 4" />
                                                </svg>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination-container">
                            <c:choose>
                                <c:when test="${users.HasPreviousPage()}">
                                    <a href="/app/admin/users/list.jsp?q=${param.q}&p=${param.p - 1}"
                                       class="pagination-item">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide-chevron-left lucide">
                                        <path d="m15 18-6-6 6-6" />
                                        </svg>
                                        Anterior
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/app/admin/users/list.jsp?q=${param.q}&p=${param.p}"
                                       class="pagination-item-inative pagination-item">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide-chevron-left lucide">
                                        <path d="m15 18-6-6 6-6" />
                                        </svg>
                                        Anterior
                                    </a>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${users.HasNextPage()}">
                                    <a href="/app/admin/users/list.jsp?q=${param.q}&p=${param.p + 1}"
                                       class="pagination-item">
                                        Próxima
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide-chevron-right lucide">
                                        <path d="m9 18 6-6-6-6" />
                                        </svg>

                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/app/admin/users/list.jsp?q=${param.q}&p=${param.p}"
                                       class="pagination-item-inative pagination-item">
                                        Próxima
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide-chevron-right lucide">
                                        <path d="m9 18 6-6-6-6" />
                                        </svg>

                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </main>
            </div>

    </body>
    <script>
        const removeUserInput = document.querySelectorAll(".remove-user")
        const removeUserModel = document.getElementById("remove-user-modal")
        const buttonModalClose = document.querySelector(".modal-actions .close")

        removeUserInput.forEach((el) => {
            el.addEventListener("click", (e) => {
                removeUserModel.querySelector(".modal-user-email").innerText = e.target.dataset.email
                removeUserModel.querySelector(".submit-delete").href = "/api/admin/users/remove?id=" + e.target.dataset.id


                removeUserModel.classList.add("modal-open")
            })
        })

        buttonModalClose.addEventListener("click", (e) => {
            removeUserModel.classList.remove("modal-open")
        })


    </script>

</html>