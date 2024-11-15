package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = {"/api/auth/*"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = ((HttpServletRequest) request).getRequestURI();
        if (path.contains("/api/auth/logout")) {
            this.logout(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = ((HttpServletRequest) request).getRequestURI();
        try {
            if (path.contains("/api/auth/login")) {
                this.login(request, response);

            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }

    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate();
        }
        
        request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, ClassNotFoundException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()) {
            request.setAttribute("emailError", "ErrorMensagemO email é obrigatório. Por favor, preencha este campo.");
            request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);

        }

        if (password == null || password.isBlank()) {
            request.setAttribute("passwordError", "O senha é obrigatório. Por favor, preencha este campo.");
            request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);
        }

        try {
            AuthService authService = new AuthService();
            CurrentUser currentUser = authService.Login(email, password);

            if (currentUser != null) {
                this.setCurrentUserInSession(request, currentUser);

                response.sendRedirect("/");

            } else {
                request.setAttribute("loginError", "Usuário ou senha incorretos. Por favor, verifique suas credenciais e tente novamente.");
                request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);
            }
        } catch (IOException ex) {
            throw new ServletException(ex);
        }

    }

    private void setCurrentUserInSession(HttpServletRequest request, CurrentUser currentUser) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = (HttpSession) httpRequest.getSession();
        session.setMaxInactiveInterval(24 * 60 * 60);
        session.setAttribute("currentSessionUser", currentUser);

    }
}
