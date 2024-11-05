package com.electronicsstore.filters;

import com.electronicsstore.dto.CurrentUser;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(
        filterName = "AuthFilter",
        urlPatterns = {"/*"})
public class AuthFilter implements Filter {

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
        HttpSession session = (HttpSession) httpRequest.getSession();
        CurrentUser currentSessionUser = (CurrentUser) session.getAttribute("currentSessionUser");

        String path = ((HttpServletRequest) request).getRequestURI();
        
        boolean isPublicRouter = path.contains("/auth/login") || path.contains("/users/register");
        
        
        if (path.contains("/public")) {
            chain.doFilter(request, response);
            return;
        }
        if (currentSessionUser == null && !isPublicRouter) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/app/auth/login.jsp", true);
            return;
        }

        chain.doFilter(request, response);
    }
}
