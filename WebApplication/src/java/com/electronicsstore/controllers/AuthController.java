package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.services.AuthService;
import com.electronicsstore.utils.ErrorMensagem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = {"/auth/login"})
public class AuthController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = ((HttpServletRequest) request).getRequestURI();
        try {
            if (path.contains("/auth/login")) {
                this.login(request, response);

            } else {
               // Redirecionar para uma pagina 404
                throw new ServletException("Rota invalida");
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }

    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, ClassNotFoundException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()) {
            request.setAttribute("emailError", ErrorMensagem.getMessageByCode(1));
            request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);

        }

        if (password == null || password.isBlank()) {
            request.setAttribute("passwordError", ErrorMensagem.getMessageByCode(2));
            request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);
        }

        try {
            AuthService authService = new AuthService();
            CurrentUser currentUser = authService.Login(email, password);
            if (currentUser != null) {
                this.setCurrentUserInSession(request, currentUser);
                response.sendRedirect("/index.jsp");

            } else {
                request.setAttribute("loginError", ErrorMensagem.getMessageByCode(3));
                request.getRequestDispatcher("/app/auth/login.jsp").forward(request, response);
            }
        } catch (IOException ex) {
            throw new ServletException(ex);
        }

    }

    private void setCurrentUserInSession(HttpServletRequest request, CurrentUser currentUser) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = (HttpSession) httpRequest.getSession();

        session.setAttribute("currentSessionUser", currentUser);

    }
}
