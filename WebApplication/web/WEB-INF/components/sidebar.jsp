<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("uri", request.getRequestURI());%>

<aside class="sidebar">
    <div class="logo-container">
        <a href="/">
            <img src="/public/assets/logo.svg" alt="Logo Eletronics Store" class="logo-image" />
        </a>
    </div>
    <nav aria-label="nav-main">
        <ul class="nav-list text-sm">
            <li class="nav-item">
                <a href="/" class="${uri.equals('/') ? 'active' : ''}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="lucide lucide-chart-column-decreasing">
                        <path d="M13 17V9" />
                        <path d="M18 17v-3" />
                        <path d="M3 3v16a2 2 0 0 0 2 2h16" />
                        <path d="M8 17V5" />
                    </svg>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="/app/admin/users/list.jsp" class="${uri.contains('/app/admin/users') ? 'active' : ''}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="lucide lucide-users">
                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                        <circle cx="9" cy="7" r="4" />
                        <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                        <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                    </svg>
                    Usuários
                </a>
            </li>
            <li class="nav-item">
                <a href="/app/admin/products/list.jsp"
                   class="${uri.endsWith('/app/admin/products/list.jsp') ? 'active' : ''}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="lucide lucide-package">
                        <path
                            d="M11 21.73a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73z" />
                        <path d="M12 22V12" />
                        <path d="m3.3 7 7.703 4.734a2 2 0 0 0 1.994 0L20.7 7" />
                        <path d="m7.5 4.27 9 5.15" />
                    </svg>
                    Produtos
                </a>
            </li>
            <li class="nav-item">
                <a href="/app/admin/categories/list.jsp"
                   class="${uri.endsWith('/app/admin/orders/list.jsp') ? 'active' : ''}">
                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-boxes"><path d="M2.97 12.92A2 2 0 0 0 2 14.63v3.24a2 2 0 0 0 .97 1.71l3 1.8a2 2 0 0 0 2.06 0L12 19v-5.5l-5-3-4.03 2.42Z"/><path d="m7 16.5-4.74-2.85"/><path d="m7 16.5 5-3"/><path d="M7 16.5v5.17"/><path d="M12 13.5V19l3.97 2.38a2 2 0 0 0 2.06 0l3-1.8a2 2 0 0 0 .97-1.71v-3.24a2 2 0 0 0-.97-1.71L17 10.5l-5 3Z"/><path d="m17 16.5-5-3"/><path d="m17 16.5 4.74-2.85"/><path d="M17 16.5v5.17"/><path d="M7.97 4.42A2 2 0 0 0 7 6.13v4.37l5 3 5-3V6.13a2 2 0 0 0-.97-1.71l-3-1.8a2 2 0 0 0-2.06 0l-3 1.8Z"/><path d="M12 8 7.26 5.15"/><path d="m12 8 4.74-2.85"/><path d="M12 13.5V8"/></svg>
                    Categorias
                </a>
            </li>
            <li class="nav-item">
                <a href="/app/admin/orders/list.jsp"
                   class="${uri.endsWith('/app/admin/orders/list.jsp') ? 'active' : ''}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="lucide lucide-shopping-cart">
                        <circle cx="8" cy="21" r="1" />
                        <circle cx="19" cy="21" r="1" />
                        <path
                            d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12" />
                    </svg>
                    Pedidos
                </a>
            </li>
        </ul>
    </nav>
    <div class="profile-container">
        <div class="profile-avatar">
            <span>
                ${sessionScope.currentSessionUser.name.charAt(0)}${sessionScope.currentSessionUser.surname.charAt(0)}
            </span>
        </div>
        <div class="profile-user-info">
            <p class="profile-usernmae">${sessionScope.currentSessionUser.name}</p>
            <p>${sessionScope.currentSessionUser.email}</p>
        </div>
        <div class="profile-modal-container">
            <main>
                <ul class="profile-options-list">
                    <li class="profile-option-item profile-option-item-noaction">
                        <div class="profile-modal-details">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" class="lucide lucide-user">
                                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                                <circle cx="12" cy="7" r="4" />
                            </svg>
                            <span class="profile-at">Meu perfil @${sessionScope.currentSessionUser.email.split("@")[0]}</span>
                        </div>
                    </li>
                    <li class="profile-option-item">
                        <div class="profile-action theme">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                     stroke-linecap="round" stroke-linejoin="round"
                                     class="lucide lucide-sun-moon">
                                    <path d="M12 8a2.83 2.83 0 0 0 4 4 4 4 0 1 1-4-4" />
                                    <path d="M12 2v2" />
                                    <path d="M12 20v2" />
                                    <path d="m4.9 4.9 1.4 1.4" />
                                    <path d="m17.7 17.7 1.4 1.4" />
                                    <path d="M2 12h2" />
                                    <path d="M20 12h2" />
                                    <path d="m6.3 17.7-1.4 1.4" />
                                    <path d="m19.1 4.9-1.4 1.4" />
                                </svg>
                                Tema dark
                            </span>
                            <div>
                                <label class="switch">
                                    <input type="checkbox" id="switch-theme">
                                        <span class="round slider"></span>
                                </label>
                            </div>
                        </div>
                    </li>
                    <li class="profile-option-item">
                        <a href="/api/auth/logout" class="profile-action">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                     stroke-linecap="round" stroke-linejoin="round"
                                     class="lucide lucide-log-out">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                                    <polyline points="16 17 21 12 16 7" />
                                    <line x1="21" x2="9" y1="12" y2="12" />
                                </svg>
                                Logout
                            </span>
                        </a>
                    </li>
                </ul>
            </main>
            <footer>
                <div>
                    <img src="/public/assets/logo.svg" alt="Logo Eletronics Store" class="logo-image" />
                </div>
                &copy;
            </footer>
        </div>
    </div>
</aside>