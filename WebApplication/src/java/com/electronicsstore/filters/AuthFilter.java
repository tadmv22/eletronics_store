package com.electronicsstore.filters;

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
        String currentSessionUser = (String) session.getAttribute("currentSessionUser");

        String path = ((HttpServletRequest) request).getRequestURI();

        if (path.contains("/resources")) {
            chain.doFilter(request, response);
            return;
        }
        if (currentSessionUser == null && !path.contains("/login")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/app/users/login.jsp", true);
            return;
        }

        chain.doFilter(request, response);
    }
}
