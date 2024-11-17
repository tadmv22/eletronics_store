<%@page import="com.electronicsstore.models.Category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="dao" class="com.electronicsstore.dao.CategoryDao"/>
<%
    List<Category> categories = dao.list();
    
    request.setAttribute("categories", categories);
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
    <body id="products-register">
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
                            <a href="/app/admin/products/list.jsp"  class="text-xs">
                                Produtos
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/products/create.jsp" class="text-xs icon-none">
                                Registar novo produto
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Registar novo produto</h1>
                    <form action="/api/products/create" method="post" class="create-product-form">
                        <div class="field">
                            <label for="name" class="label-default">Nome</label>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                placeholder="Digite o nome do produto"
                                required
                                class="input-default"
                                />
                            <c:if test="${not empty nameError}">
                                <div class="form-error text-xs">
                                    ${nameError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <label for="description" class="label-default">Descrição</label>
                            <textarea
                                id="description"
                                name="description"
                                placeholder="Escreva uma descrição para o produto"
                                required
                                rows="3"
                                class="textarea-default"
                                ></textarea>  
                            <c:if test="${not empty descriptionError}">
                                <div class="form-error text-sm">
                                    ${descriptionError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <label for="value" class="label-default">Valor do produto</label>
                            <input
                                type="text"
                                id="value"
                                name="value"
                                placeholder="Digite o valor do produto"
                                required
                                class="input-default"
                                />
                            <c:if test="${not empty valueError}">
                                <div class="form-error text-xs">
                                    ${valueError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <label for="stockQuantity" class="label-default">Quantidade em Estoque</label>
                            <input
                                type="text"
                                id="stockQuantity"
                                name="stockQuantity"
                                placeholder="Digite a quantidade em estoque do produto"
                                required
                                class="input-default"
                                />
                            <c:if test="${not empty stockError}">
                                <div class="form-error text-xs">
                                    ${stockError}
                                </div>
                            </c:if>
                        </div>
                        <div class='field'> 
                        <label for="categoryId" class="label-default">Categorias</label>
                        <select name='categoryId' class="select-default">
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                        </div>
                        <div class="field-actions">
                            <c:if test="${not empty invalidValues}">
                                <div class="form-error text-sm">
                                    ${invalidValues}
                                </div>
                            </c:if>
                            
                            <button type="submit" class="btn">Salvar</button>
                            <a href="/app/admin/products/list.jsp" class="btn btn-outline close">Cancelar</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
    </body>
</html>
