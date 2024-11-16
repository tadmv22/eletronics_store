<%@page import="com.electronicsstore.models.Coupon"%>
<jsp:useBean id="services" class="com.electronicsstore.services.CouponService" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
    String id = (String) request.getParameter("id");
    try {
        int coupomId = Integer.parseInt(id);
        Coupon coupon = services.getById(coupomId);
        request.setAttribute("coupon", coupon);
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
        <link rel="stylesheet" href="/public/css/pages/coupons.css" />
        <title>Eletronics Store - Usuários</title>
    </head>

    <body id="coupons-update">
        <div class="layout">
            <%@include file="../../../WEB-INF/components/sidebar.jsp" %>
            <div class="main-container-content">
                <div class="toast text-sm">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="lucide lucide-circle-check">
                    <circle cx="12" cy="12" r="10" />
                    <path d="m9 12 2 2 4-4" />
                    </svg>
                    Atualização realizada com sucesso!
                </div>
                <div class="breadcrumb-container">
                    <ul class="breadcrumb-list">
                        <li class="breadcrumb-item">
                            <a href="/" class="text-xs">
                                Home
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/categories/list.jsp"  class="text-xs">
                                Categorias
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/categories/update.jsp?id=${param.id}"  class="text-xs icon-none">
                                Atualizar as informações do cupom
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Atualizar as informações do cupom</h1>
                    <form action="/api/coupons/update?id=${coupon.id}" method="post" class="update-coupom-form">
                        <div class="field-container">
                            <div class="field">
                                <label for="code" class="label-default">Código</label>
                                <input
                                    type="text"
                                    id="code"
                                    name="code"
                                    value="${coupon.code}"
                                    placeholder="Digite um código para o cupom"
                                    required
                                    class="input-default"
                                    />
                                <c:if test="${not empty codeError}">
                                    <div class="form-error text-xs">
                                        ${codeError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="discountValue" class="label-default">Valor</label>
                                <input
                                    type="number"
                                    id="discountValue"
                                    value="${coupon.discountValue}"
                                    name="discountValue"
                                    min="0.00"
                                    max="10000.00"
                                    step="0.01"
                                    placeholder="Digite o valor do cupom"
                                    required
                                    class="input-default"
                                    />
                                <c:if test="${not empty valueError}">
                                    <div class="form-error text-xs">
                                        ${valueError}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="field-container">
                            <div class="field">
                                <label for="startAt" class="label-default">Data de início</label>
                                <input
                                    type="date"
                                    id="startAt"
                                    name="startAt"
                                    value="${coupon.startAt}"
                                    required
                                    class="input-default"
                                    />
                                <c:if test="${not empty codeError}">
                                    <div class="form-error text-xs">
                                        ${codeError}
                                    </div>
                                </c:if>
                            </div>
                            <div class="field">
                                <label for="expirationAt" class="label-default">Data de expiração</label>
                                <input
                                    type="date"
                                    id="expirationAt"
                                    name="expirationAt"
                                    value="${coupon.expirationAt}"
                                    class="input-default"
                                    />
                                <c:if test="${not empty codeError}">
                                    <div class="form-error text-xs">
                                        ${codeError}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="field">
                            <label for="status" class="label-default">Status</label>
                            <select name="status" id="status"  class="select-default">
                                <option value="1" ${coupon.active ? "selected" : ""}>Ativo</option>
                                <option value="0" ${!coupon.active ? "selected" : ""} >Inativo</option>
                            </select>
                        </div>
                        <div class="field">
                            <label for="description" class="label-default">Descrição</label>
                            <textarea
                                id="description"
                                name="description"
                                placeholder="Escreva uma descrição para o cupom"
                                required
                                rows="4"
                                class="textarea-default"
                                >${coupon.description}</textarea>  
                            <c:if test="${not empty descriptionError}">
                                <div class="form-error text-sm">
                                    ${descriptionError}
                                </div>
                            </c:if>
                        </div>

                        <div class="field-actions">
                            <c:if test="${not empty invalidValues}">
                                <div class="form-error text-sm">
                                    ${invalidValues}
                                </div>
                            </c:if>

                            <button type="submit" class="btn">Salvar</button>
                            <a href="/app/admin/coupons/list.jsp" class="btn btn-outline close">Cancelar</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
        <script>
            const toastElement = document.querySelector(".toast");

            function toast(open) {
                if (open) {
                    setTimeout(() => {
                        if (toastElement) {
                            toastElement.classList.add("active");
                        }
                    }, 10);

                    setTimeout(() => {
                        if (toastElement) {
                            toastElement.classList.remove("active");
                        }
                    }, 2500);

                    setTimeout(() => {
                        window.location.replace(window.location.origin + "/app/admin/coupons/list.jsp");
                    }, 3500);
                }
            }

            document.addEventListener("DOMContentLoaded", () => {
                toast(${updateSuccess});
            });
        </script>
    </body>
</html>
