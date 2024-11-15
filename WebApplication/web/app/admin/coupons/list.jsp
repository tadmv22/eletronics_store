<%@page import="com.electronicsstore.models.Coupon"%>
<jsp:useBean id="services" class="com.electronicsstore.services.CouponService" />
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
        PagedList<Coupon> coupons = services.getAllCouponWithFilter(q, pageNumber);
        request.setAttribute("coupons", coupons);
    } catch (NumberFormatException e) {
        PagedList<Coupon> coupons = services.getAllCouponWithFilter(q, 1);
        request.setAttribute("coupons", coupons);
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
        <link rel="stylesheet" href="/public/css/pages/coupons.css" />
        <title>Eletronics Store - Cupons</title>
    </head>
    <body id="coupons-list">
        <div class="layout">
            <%@include file="../../../WEB-INF/components/sidebar.jsp" %>
            <div id="modal-container">
                <div class="modal-content">
                    <div class="model-info">
                        <h3 class="text-large">Confirmação de exclusão do cupom</h3>
                        <div>
                            <p class="text-sm">Tem certeza de que deseja excluir o cupom
                                <span class="modal-details"></span>?
                            </p>
                            <p class="text-sm">
                                Esta ação é irreversível e todas as informações associadas a este cupom serão permanentemente removidas do sistema.
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
                            <a href="/app/admin/coupons/list.jsp"  class="text-xs icon-none">
                                Cupons
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Gerenciamento de cupons</h1>
                    <div class="table-container">
                        <div class="table-container-header">
                            <p class="text-base">Total de cupons<span
                                    class="text-sm">
                                    <c:out value="${coupons.totalCount}" />
                                    cupons
                                </span></p>
                            <div class="table-container-actions">
                                <form action="/app/admin/coupons/list.jsp" method="get"
                                      class="search-input">
                                    <input class="input-default" type="search" name="q"
                                           id="q" value="${param.q}"
                                           placeholder="Buscar cupon por código" />

                                    <c:if test="${not empty param.q}">
                                        <a href="/app/admin/coupons/list.jsp"
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
                                    <a href="/app/admin/coupons/create.jsp" class="btn text-xs">
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
                                        <th>Código</th>
                                        <th>Valor de desconto</th>
                                        <th>Data de início</th>
                                        <th>Data de expiração</th>
                                        <th>Status</th>
                                        <th>Data de Cadastrado</th>
                                        <th>Última atualização</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody class="text-sm">
                                    <c:forEach var="coupon" items="${coupons.items}">
                                        <tr>
                                            <td>${coupon.code}</td>
                                            <td class="coupon-value">
                                                <fmt:setLocale value="pt-BR" />
                                                <fmt:formatNumber value="${coupon.discountValue}" minFractionDigits="2" type="currency" />
                                            </td>
                                            <td class="item-date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${coupon.startAt}"/></td>
                                            <td class="item-date">
                                                <c:choose>
                                                    <c:when test="${empty coupon.expirationAt}">
                                                        Sem validade definida
                                                    </c:when>
                                                    <c:otherwise>
                                                         <fmt:formatDate pattern = "dd/MM/yyyy" value = "${coupon.expirationAt}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="item-date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${coupon.createdAt}"/></td>
                                            <td class="item-date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${coupon.updateAt}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${coupon.isExpired()}">
                                                        <a href="/api/coupons/change-status?id=${coupon.id}" class="status status-expired text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-x"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/><path d="m14 14-4 4"/><path d="m10 14 4 4"/></svg>
                                                            Expirado
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${coupon.IsActiveAndValid()}">
                                                        <a href="/api/coupons/change-status?id=${coupon.id}" class="status status-current text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-check-2"><path d="M8 2v4"/><path d="M16 2v4"/><path d="M21 14V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h8"/><path d="M3 10h18"/><path d="m16 20 2 2 4-4"/></svg>
                                                            Vigente 
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${coupon.active}">
                                                        <a href="/api/coupons/change-status?id=${coupon.id}" class="status status-scheduled text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-clock"><path d="M21 7.5V6a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h3.5"/><path d="M16 2v4"/><path d="M8 2v4"/><path d="M3 10h5"/><path d="M17.5 17.5 16 16.3V14"/><circle cx="16" cy="16" r="6"/></svg>
                                                            Programado 
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/api/coupons/change-status?id=${coupon.id}" class="status text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-off"><path d="M4.2 4.2A2 2 0 0 0 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 1.82-1.18"/><path d="M21 15.5V6a2 2 0 0 0-2-2H9.5"/><path d="M16 2v4"/><path d="M3 10h7"/><path d="M21 10h-5.5"/><path d="m2 2 20 20"/></svg>
                                                            Inativo
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button class="table-action-remove table-row-actions"
                                                        data-detail="${coupon.code}"
                                                        data-id="${coupon.id}">
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
                                                <a href="/app/admin/coupons/update.jsp?id=${coupon.id}"
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
                                Página ${coupons.page} de ${Math.round(coupons.totalCount / coupons.pageSize)}
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${coupons.HasPreviousPage()}">
                                        <a href="/app/admin/coupons/list.jsp?q=${param.q}&p=${coupons.previousPage()}"
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
                                        <a href="/app/admin/coupons/list.jsp?q=${param.q}&p=${coupons.previousPage()}"
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
                                    <c:when test="${coupons.HasNextPage()}">
                                        <a href="/app/admin/coupons/list.jsp?q=${param.q}&p=${coupons.nextPage()}" class="pagination-item text-sm">
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
                                        <a href="/app/admin/coupons/list.jsp?q=${param.q}&p=${coupons.nextPage()}" class="pagination-item-inative pagination-item text-sm">
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
                                "/api/coupons/remove?id=" + e.target.dataset.id;

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