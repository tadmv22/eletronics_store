<%@page import="com.electronicsstore.dto.ProductsAnalytics"%>
<%@page import="java.util.List"%>
<%@page import="com.electronicsstore.dto.CaterogryAnalytic"%>
<jsp:useBean id="daoCategory" class="com.electronicsstore.dao.CategoryDao" />
<jsp:useBean id="daoProducts" class="com.electronicsstore.dao.ProductDao" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%

    List<CaterogryAnalytic> categoryViewanAlytics = daoCategory.viewAnalytics();
    ProductsAnalytics productsAnalytics = daoProducts.viewAnalytics();

    request.setAttribute("categoryViewanAlytics", categoryViewanAlytics);
    request.setAttribute("productsAnalytics", productsAnalytics);
%>

<!DOCTYPE html>
<html lang="pt-br" data-theme='light'>
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
        <link rel="stylesheet" href="/public/css/pages/dashboard.css" />
        <title>Eletronics Store</title>
    </head>
    <body id="dashboard">
        <div class="layout">
            <%@include file="../../WEB-INF/components/sidebar.jsp"%>
            <div class="main-container-content">
                <main class="container">
                    <h1 class="text-large">Dashboard</h1>
                    <div class="card-container">
                        <div class="card-item sales">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Total vendas
                                </h4>
                                <p class="text-extra-large">R$ 902 mil</p>
                            </div>
                            <div href="" class="text-xs analytics card-footer">
                                <span class="text-base">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="lucide lucide-move-up">
                                    <path d="M8 6L12 2L16 6" />
                                    <path d="M12 2V22" />
                                    </svg>2.5%
                                </span>
                                <span>
                                    vs último mês
                                </span>
                            </div>
                        </div>
                        <div class="card-item sales">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Total pedidos
                                </h4>
                                <p class="text-extra-large">12 mil</p>
                            </div>
                            <div href="" class="text-xs analytics card-footer">
                                <span class="text-base">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="lucide lucide-move-up">
                                    <path d="M8 6L12 2L16 6" />
                                    <path d="M12 2V22" />
                                    </svg>3.8%
                                </span>
                                <span>
                                    vs último mês
                                </span>
                            </div>
                        </div>
                        <div class="card-item sales">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Média de Vendas
                                </h4>
                                <p class="text-extra-large">R$ 75,16 mil</p>
                            </div>
                            <div href="" class="text-xs analytics card-footer">
                                <span class="text-base">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="lucide lucide-move-up">
                                    <path d="M8 6L12 2L16 6" />
                                    <path d="M12 2V22" />
                                    </svg>1.8%
                                </span>
                                <span>
                                    vs último mês
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-container">
                        <div class="card-item">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Total de produtos em estoque
                                </h4>
                                <p class="text-extra-large">${productsAnalytics.units} mil unidades</p>

                            </div>
                            <a href="" class="text-sm card-footer">
                                Ver mais <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                              fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                              stroke-linejoin="round" class="lucide-move-right lucide">
                                <path d="M18 8L22 12L18 16" />
                                <path d="M2 12H22" />
                                </svg>
                            </a>
                        </div>
                        <div class="card-item">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Saldo em estoque
                                </h4>
                                <p class="text-extra-large">
                                    <fmt:setLocale value="pt-BR" />
                                    <fmt:formatNumber value="${productsAnalytics.balance}" minFractionDigits="2" type="currency" />
                                </p>
                            </div>
                            <a href="" class="text-sm card-footer">
                                Ver mais <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                              fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                              stroke-linejoin="round" class="lucide-move-right lucide">
                                <path d="M18 8L22 12L18 16" />
                                <path d="M2 12H22" />
                                </svg>
                            </a>
                        </div>
                        <div class="card-item">
                            <div class="card-main">
                                <h4 class="text-sm">
                                    Custo médio
                                </h4>
                                <p class="text-extra-large">
                                    <fmt:setLocale value="pt-BR" />
                                    <fmt:formatNumber value="${productsAnalytics.averange}" minFractionDigits="2" type="currency" />
                                </p>
                            </div>
                            <a href="" class="text-sm card-footer">
                                Ver mais <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                              fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                              stroke-linejoin="round" class="lucide-move-right lucide">
                                <path d="M18 8L22 12L18 16" />
                                <path d="M2 12H22" />
                                </svg>
                            </a>
                        </div>
                    </div>
                    <div class="categories-analytics-container">
                        <h2 class="text-sm">Análise de Produtos por Categoria</h2>
                        <div class="categories-analytics-main">
                            <ul class="category-analytics-list">
                                <c:forEach var="category" items="${categoryViewanAlytics}" >
                                    <li>
                                        <div class="card-item category-analytics-item">
                                            <div class="card-main">
                                                <h4 class="text-extra-large">
                                                    ${category.name}
                                                </h4>
                                            </div>
                                            <ul class="text-sm category-analytics-kpi">
                                                <li>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                         viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                         stroke-linecap="round" stroke-linejoin="round"
                                                         class="lucide lucide-cpu">
                                                    <rect width="16" height="16" x="4" y="4" rx="2" />
                                                    <rect width="6" height="6" x="9" y="9" rx="1" />
                                                    <path d="M15 2v2" />
                                                    <path d="M15 20v2" />
                                                    <path d="M2 15h2" />
                                                    <path d="M2 9h2" />
                                                    <path d="M20 15h2" />
                                                    <path d="M20 9h2" />
                                                    <path d="M9 2v2" />
                                                    <path d="M9 20v2" />
                                                    </svg>${category.products} produtos</li>
                                                <li>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                         viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                         stroke-linecap="round" stroke-linejoin="round"
                                                         class="lucide lucide-archive">
                                                    <rect width="20" height="5" x="2" y="3" rx="1" />
                                                    <path d="M4 8v11a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8" />
                                                    <path d="M10 12h4" />
                                                    </svg>${category.units} unidades em estoque
                                                </li>
                                                <li>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                         viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                         stroke-linecap="round" stroke-linejoin="round"
                                                         class="lucide lucide-circle-dollar-sign">
                                                    <circle cx="12" cy="12" r="10" />
                                                    <path d="M16 8h-6a2 2 0 1 0 0 4h4a2 2 0 1 1 0 4H8" />
                                                    <path d="M12 18V6" />
                                                    </svg> 
                                                    <fmt:setLocale value="pt-BR" />
                                                    <fmt:formatNumber value="${category.balance}" currencySymbol="" minFractionDigits="2" type="currency" /> de saldo
                                                </li>
                                                <li>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hand-coins"><path d="M11 15h2a2 2 0 1 0 0-4h-3c-.6 0-1.1.2-1.4.6L3 17"/><path d="m7 21 1.6-1.4c.3-.4.8-.6 1.4-.6h4c1.1 0 2.1-.4 2.8-1.2l4.6-4.4a2 2 0 0 0-2.75-2.91l-4.2 3.9"/><path d="m2 16 6 6"/><circle cx="16" cy="9" r="2.9"/><circle cx="6" cy="5" r="3"/></svg>
                                                    <fmt:formatNumber value="${category.averange}" currencySymbol="" minFractionDigits="2" type="currency" /> valor médio
                                                </li>
                                            </ul>
                                            <a href="" class="text-sm card-footer">
                                                Ver mais <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                              viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                              stroke-linecap="round" stroke-linejoin="round"
                                                              class="lucide-move-right lucide">
                                                <path d="M18 8L22 12L18 16" />
                                                <path d="M2 12H22" />
                                                </svg>
                                            </a>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="/public/scripts/index.js"></script>
    </body>

</html>