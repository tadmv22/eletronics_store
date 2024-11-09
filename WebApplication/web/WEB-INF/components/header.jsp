<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <% request.setAttribute("uri", request.getRequestURI()); %>

        <header class="header-main">
            <nav>
                <ul>
                    <li>
                        <a href="/">
                            <img src="/public/assets/logo.svg" alt="Logo Eletronics Store" class="logo" />
                        </a>
                    </li>
                    <li>
                        <a href="/app/admin/users/list.jsp"
                            class="${uri.contains('/app/admin/users') ? 'active' : ''}">Usuários</a>
                    </li>
                    <li><a href="/app/admin/products/list.jsp"
                            class="${uri.endsWith('/app/admin/products/list.jsp') ? 'active' : ''}">Produtos</a></li>
                    <li><a href="/app/admin/orders/list.jsp"
                            class="${uri.endsWith('/app/admin/orders/list.jsp') ? 'active' : ''}">Pedidos</a></li>
                </ul>
            </nav>
            <div class="account">
                <a href="/">
                    <span>Olá,
                        <c:out value="${sessionScope.currentSessionUser.name}" />
                    </span>Acesse sua conta
                </a>
            </div>
        </header>