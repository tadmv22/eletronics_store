<%@page import="com.electronicsstore.models.Coupon"%>
<%@page import="com.electronicsstore.models.Product"%>
<%@page import="java.util.List"%>
<jsp:useBean id="services" class="com.electronicsstore.services.ProductsService" />
<jsp:useBean id="servicesCoupon" class="com.electronicsstore.services.CouponService" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String id = (String) request.getParameter("id");

    try {
        int productId = Integer.parseInt(id);
        Product product = services.getProductById(productId);
        List<Coupon> coupons = servicesCoupon.getCouponsByProducts(productId);
        List<Coupon> couponsAvaliable = servicesCoupon.getCouponsAvalibleByProducts(productId);
        request.setAttribute("product", product);
        request.setAttribute("coupons", coupons);
        request.setAttribute("couponsAvaliable", couponsAvaliable);
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
        <link rel="stylesheet" href="/public/css/pages/products.css" />
        <title>Eletronics Store - Produtos</title>
    </head>

    <body id="products-coupons-list">
        <div class="layout">
            <%@include file="../../../../WEB-INF/components/sidebar.jsp" %>
            <div id="modal-container">
                <div class="modal-content">
                    <div class="model-info">
                        <h3 class="text-large">Confirmação de exclusão do cupom</h3>
                        <div>
                            <p class="text-sm">Tem certeza de que deseja excluir a
                                cupom
                                <span class="modal-details"></span>?
                            </p>
                            <p class="text-sm">
                                Esta ação é irreversível e todas as informações associadas a este produto serão permanentemente removidas do sistema.
                            </p>
                        </div>
                    </div>
                    <div class="modal-actions">
                        <a href="" class="text-sm btn submit-delete">Excluir</a>
                        <button type="button" class="text-sm btn btn-outline close">Cancelar</button>
                    </div>

                </div>
            </div>
            <div id="modal-container" class="add-coupon">
                <div class="modal-content">
                    <form action="/api/products/coupons/add/${product.id}" method="post">
                        <div class="field">
                            <c:choose>
                                <c:when test="${empty couponsAvaliable}">
                                    <p class="text-base" style="text-align:center">Nenhum novo cupom disponível</p>
                                </c:when>
                                <c:otherwise>
                                    <label class="label-default">Cupons disponível</label>
                                    <select name='couponId' class="select-default" required>
                                        <c:forEach var="coupon" items="${couponsAvaliable}">
                                            <option 
                                                value="${coupon.id}"
                                                >${coupon.code}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="modal-actions">
                            <button type="submit" class="text-sm btn"
                                    <c:if test="${empty couponsAvaliable}">disabled</c:if>
                                        >Adicionar</button>
                                    <button type="button" class="text-sm btn btn-outline close">Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="main-container-content">
                    <div class="toast text-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-circle-check">
                        <circle cx="12" cy="12" r="10" />
                        <path d="m9 12 2 2 4-4" />
                        </svg>
                        Cupom adicionado com sucesso!
                    </div>
                    <div class="breadcrumb-container">
                        <ul class="breadcrumb-list">
                            <li class="breadcrumb-item">
                                <a href="/" class="text-xs">
                                    Home
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="lucide-chevron-right lucide">
                                    <path d="m9 18 6-6-6-6" />
                                    </svg>
                                </a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/app/admin/products/list.jsp" class="text-xs icon-none">
                                    Produtos
                                </a>
                            </li>
                        </ul>
                    </div>
                    <main class="container">
                        <div class="card-product">
                            <div class="prodcut-details">
                                <h1 class="text-extra-large">${product.name}</h1>
                            <p class="text-base">${product.description}</p>
                        </div>
                        <div class="text-extra-large product-value">
                            <fmt:setLocale value="pt-BR" />
                            <fmt:formatNumber value="${product.value}" minFractionDigits="2" type="currency" />
                        </div>
                    </div>
                    <div class="coupons-manager">
                        <h1 class="text-base">Gerenciamento de cupons</h1>
                        <div class="table-container-header">
                            <p class="text-base">Total de cupons <span class="text-sm">
                                    <c:out value="${coupons.size()}" />
                                    cupons
                                </span></p>
                            <div class="table-container-actions">
                                <button class="table-container-action-add text-xs btn">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="lucide lucide-plus">
                                    <path d="M5 12h14" />
                                    <path d="M12 5v14" />
                                    </svg>
                                    Adicionar cupom
                                </button>
                            </div>
                        </div>
                        <div class="card-list-container">

                            <c:choose>
                                <c:when test="${empty coupons}">
                                    <div class="card-list-empty">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                             stroke-linejoin="round" class="lucide lucide-badge-percent">
                                        <path
                                            d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z" />
                                        <path d="m15 9-6 6" />
                                        <path d="M9 9h.01" />
                                        <path d="M15 15h.01" />
                                        </svg>
                                        <p class="text-base">Nenhum cupom registrado</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="card-coupons-container">
                                        <c:forEach var="coupon" items="${coupons}">
                                            <div class="card-coupon">
                                                <div class="card-coupon-details">
                                                    <div>
                                                        <p class="text-base coupon-code">${coupon.code}</p>
                                                        <p class="text-xs">${coupon.description}</p>
                                                    </div>
                                                    <span class="text-extra-large coupon-discount">
                                                        <fmt:setLocale value="pt-BR" />
                                                        <fmt:formatNumber value="${coupon.discountValue}" minFractionDigits="2" type="currency" />
                                                    </span>
                                                </div>
                                                <div class="card-footer">
                                                    <div class="card-coupon-date">
                                                        <span class="text-xs">Válido até 26 abril 2024</span>
                                                    </div>
                                                    <button
                                                        class="card-coupon-remove-link"
                                                        data-detail="${coupon.code}"
                                                        data-id="${coupon.id}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                             stroke-linecap="round" stroke-linejoin="round"
                                                             class="lucide-trash-2 lucide">
                                                        <path d="M3 6h18" />
                                                        <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6" />
                                                        <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2" />
                                                        <line x1="10" x2="10" y1="11" y2="17" />
                                                        <line x1="14" x2="14" y1="11" y2="17" />
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </main>
            </div>
            <script>

                const toastElement = document.querySelector(".toast");

                function toast(open, message) {
                    if (open) {
                        setTimeout(() => {
                            if (toastElement) {
                                toastElement.innertext = message;
                                toastElement.classList.add("active");
                            }
                        }, 10);

                        setTimeout(() => {
                            if (toastElement) {
                                toastElement.innertext = "";
                                toastElement.classList.remove("active");
                            }
                        }, 2500);

                        setTimeout(() => {
                            window.location.replace(window.location.origin + "/app/admin/products/coupons/list.jsp?id=${product.id}");
                        }, 3500);
                    }
                }

                <c:if test="${changeIsSucess}">
                    toast(${changeIsSucess},${changeMessage});
                </c:if>

                const cardCuponRemove = document.querySelectorAll(".card-footer .card-coupon-remove-link");

                const cardCupon = document.querySelector(".table-container-action-add");
                const modalContainerAdd = document.querySelector("#modal-container.add-coupon");
                const btnModalAddClose = document.querySelector(".add-coupon .modal-actions .close");

                const modalContainer = document.getElementById("modal-container");
                const btnModalClose = document.querySelector(".modal-actions .close");

                cardCupon.addEventListener("click", (e) => {
                    modalContainerAdd.classList.add("modal-open");
                })

                btnModalAddClose.addEventListener("click", (e) => {
                    modalContainerAdd.classList.remove("modal-open");
                });


                function removeCouponHandler(e) {
                    modalContainer.querySelector(".modal-details").innerText =
                            e.target.dataset.detail;
                    modalContainer.querySelector(".submit-delete").href =
                            "/api/products/coupons/remove?productId=${product.id}&couponId=" + e.target.dataset.id;
                    modalContainer.classList.add("modal-open");
                }

                cardCuponRemove.forEach((el) => {
                    el.addEventListener("click", removeCouponHandler);
                });

                btnModalClose.addEventListener("click", (e) => {
                    modalContainer.classList.remove("modal-open");
                });

            </script>
            <script src="/public/scripts/index.js"></script>
    </body>
</html>