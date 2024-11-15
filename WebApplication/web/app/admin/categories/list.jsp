<jsp:useBean id="services" class="com.electronicsstore.services.CategoryService" />
<%@page import="com.electronicsstore.dto.CategoryResponse"%>
<%@page import="com.electronicsstore.dto.PagedList" %>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String p = (String) request.getParameter("p");
    String q = (String) request.getParameter("q");

    try {
        int pageNumber = Integer.parseInt(p);
        PagedList<CategoryResponse> categories = services.getAllCategoriesWithFilter(q, pageNumber);
        request.setAttribute("categories", categories);
    } catch (NumberFormatException e) {
        PagedList<CategoryResponse> categories = services.getAllCategoriesWithFilter(q, 1);
        request.setAttribute("categories", categories);
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
        <link rel="stylesheet" href="/public/css/pages/categories.css" />
        <title>Eletronics Store - Categorias</title>
    </head>
    <body id="categories-list">
        <div class="layout">
            <%@include file="../../../WEB-INF/components/sidebar.jsp" %>
            <div id="modal-container">
                <div class="modal-content">
                    <div class="model-info">
                        <h3 class="text-large">Confirmação de exclusão de categoria</h3>
                        <div>
                            <p class="text-sm">Tem certeza de que deseja excluir a categoria
                                <span class="modal-details"></span>?
                            </p>
                            <p class="text-sm">
                                Esta ação é irreversível e todas as informações associadas a está categoria serão permanentemente removidas do sistema.
                            </p>
                        </div>
                    </div>
                    <div class="modal-actions">
                        <a href="" class="btn text-sm submit-delete">Excluir</a>
                        <button type="button" class="btn btn-outline close text-sm">Cancelar</button>
                    </div>

                </div>
            </div>
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
                            <a href="/app/admin/categories/list.jsp"  class="text-xs icon-none">
                                Categorias
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Gerenciamento de categorias</h1>
                    <div class="table-container">
                        <div class="table-container-header">
                            <p class="text-base">Total de categorias<span
                                    class="text-sm">
                                    <c:out value="${categories.totalCount}" />
                                    categorias
                                </span></p>
                            <div class="table-container-actions">
                                <form action="/app/admin/categories/list.jsp" method="get"
                                      class="search-input">
                                    <input class="input-default" type="search" name="q"
                                           id="q" value="${param.q}"
                                           placeholder="Buscar categoria por nome ou descrição" />

                                    <c:if test="${not empty param.q}">
                                        <a href="/app/admin/categories/list.jsp"
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
                                    <button type="submit" class="btn">
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
                                <div class="table-container-action-add">
                                    <a href="/app/admin/categories/create.jsp" class="btn text-xs">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                             height="24" viewBox="0 0 24 24" fill="none"
                                             stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide lucide-plus">
                                        <path d="M5 12h14" />
                                        <path d="M12 5v14" />
                                        </svg>
                                        Registrar nova categoria
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="table-container-content">
                            <table class="table-default">
                                <thead class="text-xs">
                                    <tr>
                                        <th>Nome</th>
                                        <th>Descrição</th>
                                        <th>Data de Cadastrado</th>
                                        <th>Última atualização</th>
                                        <th>Status</th>
                                        <th>Total de produtos</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody class="text-sm">
                                    <c:forEach var="category" items="${categories.items}">
                                        <tr>
                                            <td>${category.name}</td>
                                            <td class="category-description">${category.description}</td>
                                            <td class="item-date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${category.createdAt}"/></td>
                                            <td class="item-date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${category.updateAt}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${category.isActive}">
                                                        <a href="/api/categories/change-status?id=${category.id}" class="status status-active text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-check"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
                                                            Ativo
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/api/categories/change-status?id=${category.id}" class="status text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-x"><circle cx="12" cy="12" r="10"/><path d="m15 9-6 6"/><path d="m9 9 6 6"/></svg>
                                                            Inativo
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="category-total-products">
                                                <c:choose>
                                                    <c:when test="${category.totalProducts == 0}">
                                                        N/A
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="" title="Click para ver os produtos da categoria" class="category-total-products-link">${category.totalProducts}<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-cpu"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button class="table-action-remove table-row-actions"
                                                        data-detail="${category.name}"
                                                        data-id="${category.id}">
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
                                                <a href="/app/admin/categories/update.jsp?id=${category.id}"
                                                   class="table-row-actions">
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
                        </div>

                        <div class="pagination-container">
                            <div class="text-sm">
                                Página ${categories.page} de ${Math.round(categories.totalCount / categories.pageSize)}
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${categories.HasPreviousPage()}">
                                        <a href="/app/admin/categories/list.jsp?q=${param.q}&p=${categories.previousPage()}"
                                           class="pagination-item text-sm">
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
                                        <a href="/app/admin/categories/list.jsp?q=${param.q}&p=${categories.previousPage()}"
                                           class="pagination-item-inative pagination-item text-sm">
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
                                    <c:when test="${categories.HasNextPage()}">
                                        <a href="/app/admin/categories/list.jsp?q=${param.q}&p=${categories.nextPage()}" class="pagination-item text-sm">
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
                                        <a href="/app/admin/categories/list.jsp?q=${param.q}&p=${categories.nextPage()}" class="pagination-item-inative pagination-item text-sm">
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
                    </div>
                </main>
            </div>
            <script>
                const tableActionRemoveList = document.querySelectorAll(".table-action-remove");
                const modalContainer = document.getElementById("modal-container");
                const btnModalClose = document.querySelector(".modal-actions .close");

                tableActionRemoveList.forEach((el) => {
                    el.addEventListener("click", (e) => {
                        modalContainer.querySelector(".modal-details").innerText =
                                e.target.dataset.detail;
                        modalContainer.querySelector(".submit-delete").href =
                                "/api/categories/remove?id=" + e.target.dataset.id;

                        modalContainer.classList.add("modal-open");
                    });
                });

                btnModalClose.addEventListener("click", (e) => {
                    modalContainer.classList.remove("modal-open");
                });

            </script>
    </body>
    <script src="/public/scripts/index.js"></script>
</html>