<%@page import="com.electronicsstore.models.Product"%>
<%@page import="com.electronicsstore.models.Category"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="dao" class="com.electronicsstore.dao.CategoryDao"/>
<jsp:useBean id="services" class="com.electronicsstore.services.ProductsService" />

<%
    List<Category> categories = dao.list();
    
    request.setAttribute("categories", categories);
    
    String id = (String) request.getParameter("id");
    try {
        int productId = Integer.parseInt(id);
        Product product = services.getProductById(productId);
        request.setAttribute("product", product);
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
    <body id="products-register">
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
                            <a href="/app/admin/products/list.jsp"  class="text-xs">
                                Produtos
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/products/update.jsp" class="text-xs icon-none">
                                Atualizar produto
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Atualizar produto</h1>
                    <form action="/api/products/update?id=${product.id}" method="post" class="create-product-form">
                        <div class="field">
                            <label for="name" class="label-default">Nome</label>
                            <input
                                value="${product.name}"
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
                                >${product.description}</textarea>  
                            <c:if test="${not empty descriptionError}">
                                <div class="form-error text-sm">
                                    ${descriptionError}
                                </div>
                            </c:if>
                        </div>
                        <div class="field">
                            <label for="value" class="label-default">Valor do produto</label>
                            <input
                                value="${product.value}"
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
                                value="${product.stockQuantity}"
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
                                
                                <option 
                                    <c:if test="${category.id eq product.id}"> 
                                    selected
                                    </c:if>
                                    value="${category.id}"
                                    >${category.name}</option>
                                
                    
                            
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
                        window.location.replace(window.location.origin + "/app/admin/products/list.jsp");
                    }, 3500);
                }
            }

            document.addEventListener("DOMContentLoaded", () => {
                toast(${updateSuccess});
            });
        </script>   
    </body>
</html>
