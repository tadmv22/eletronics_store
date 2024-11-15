<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("uri", request.getRequestURI());%>

<aside class="sidebar">
    <div class="logo-container">
        <a href="/">
            <img src="/public/assets/logo.svg" alt="Logo Eletronics Store" class="logo-image" />
        </a>
    </div>
    <nav aria-label="nav-main">
        <div class="nav-categories">
            <h3 class="text-xs">Menu principal</h3>
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
                    <a href="/app/admin/categories/list.jsp"
                       class="${uri.endsWith('/app/admin/categories/list.jsp') ? 'active' : ''}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-grip"><circle cx="12" cy="5" r="1"/><circle cx="19" cy="5" r="1"/><circle cx="5" cy="5" r="1"/><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/><circle cx="12" cy="19" r="1"/><circle cx="19" cy="19" r="1"/><circle cx="5" cy="19" r="1"/></svg>
                        Categorias
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/app/admin/coupons/list.jsp"
                       class="${uri.endsWith('/app/admin/coupons/list.jsp') ? 'active' : ''}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-badge-percent"><path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/><path d="m15 9-6 6"/><path d="M9 9h.01"/><path d="M15 15h.01"/></svg>
                        Cupons
                    </a>
                </li>
            </ul>
        </div>
        <div class="nav-categories">
            <h3 class="text-xs">Invent�rio</h3>
            <ul class="nav-list text-sm">

                <li class="nav-item">
                    <a href="/app/admin/products/list.jsp"
                       class="${uri.endsWith('/app/admin/products/list.jsp') ? 'active' : ''}">
                       <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-cpu"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>
                        Produtos
                    </a>
                </li>
            </ul>
        </div>
        <div class="nav-categories">
            <h3 class="text-xs">Configura��es</h3>
            <ul class="nav-list text-sm">
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
                        Gerenciamento de usu�rios
                    </a>
                </li>
            </ul>
        </div>
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