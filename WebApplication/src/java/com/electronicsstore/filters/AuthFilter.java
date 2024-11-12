package com.electronicsstore.filters;

import com.electronicsstore.dto.CurrentUser;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter(
        filterName = "AuthFilter",
        urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    List<String> listPublicViews = Arrays.asList("/app/auth/login.jsp", "/public");
    List<String> listPublicRouters = Arrays.asList("/api/auth/login");

    public AuthFilter() {
    }

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        if (this.isAuthenticate(httpRequest) && (httpRequest.getRequestURI().endsWith("/app/auth/login.jsp") || httpRequest.getRequestURI().endsWith("/api/auth/login"))) {
            httpResponse.sendRedirect("/");
            return;
        }

        if (this.isPublicViews(httpRequest)) {
            chain.doFilter(request, response);
            return;
        }

        if (!this.isAuthenticate(httpRequest) && !this.isPublicViews(httpRequest) && !isPublicRouters(httpRequest)) {
            httpResponse.sendRedirect("/app/auth/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isAuthenticate(HttpServletRequest request) {
        CurrentUser currentSessionUser = this.getCurrentUserFromSession(request);
        return currentSessionUser != null;
    }

    private CurrentUser getCurrentUserFromSession(HttpServletRequest httpRequest) {
        HttpSession session = (HttpSession) httpRequest.getSession();
        CurrentUser currentSessionUser = (CurrentUser) session.getAttribute("currentSessionUser");
        return currentSessionUser;
    }

    private boolean isPublicViews(HttpServletRequest httpRequest) {
        boolean isPublic = false;

        String path = httpRequest.getRequestURI();

        for (String p : listPublicViews) {
            if (path.contains(p)) {
                isPublic = true;
                break;
            }
        }

        return isPublic;
    }

    private boolean isPublicRouters(HttpServletRequest httpRequest) {
        boolean isPublic = false;

        String path = httpRequest.getRequestURI();

        for (String p : listPublicRouters) {
            if (path.contains(p)) {
                isPublic = true;
                break;
            }
        }

        return isPublic;
    }
}
