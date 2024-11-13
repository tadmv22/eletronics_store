<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <body id="categories-register">
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
                            <a href="/app/admin/categories/list.jsp"  class="text-xs">
                                Categorias
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"/></svg>
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/app/admin/categories/create.jsp" class="text-xs icon-none">
                                Registar nova categoria
                            </a>
                        </li>
                    </ul>
                </div>
                <main class="container">
                    <h1 class="text-large">Registar nova categoria</h1>
                    <form action="/api/categories/create" method="post" class="create-category-form">
                        <div class="field">
                            <label for="name" class="label-default">Nome</label>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                placeholder="Digite o nome da categoria"
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
                            <input
                                type="text"
                                id="description"
                                name="description"
                                placeholder="Escreva uma descrição para a categoria"
                                required
                                class="input-default"
                                />
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
                            <a href="/app/admin/categories/list.jsp" class="btn btn-outline close">Cancelar</a>
                        </div>
                    </form>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
    </body>
</html>
