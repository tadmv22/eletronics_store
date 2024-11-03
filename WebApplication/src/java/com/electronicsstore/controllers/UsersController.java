package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UsersController", urlPatterns = {"/users/login", "/users/create"})
public class UsersController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = ((HttpServletRequest) request).getRequestURI();

        try {
            if (path.contains("/users/login")) {
                this.login(request, response);
            } else if (path.contains("/users/create")) {
                this.create(request, response);
            } else {
                throw new ServletException("Rota invalida");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UsersController.class.getName()).log(Level.SEVERE, null, ex);
        }


    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()) {
            response.sendRedirect("/app/users/login.jsp?error=1");
            return;
        }

        if (password == null || password.isBlank()) {
            response.sendRedirect("/app/users/login.jsp?error=2");
            return;
        }

        try {
            UserService userService = new UserService();
            CurrentUser currentUser = userService.Login(email, password);
            if (currentUser != null) {
                this.setCurrentUserInSession(request, currentUser);
                response.sendRedirect("/index.jsp");
               
            } else {
                response.sendRedirect("/app/users/login.jsp?error=3");
            }
        } catch (IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }

    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        try {
            if (!address.isBlank() || name == null || !name.isBlank() || email == null || !email.isBlank() || !password.isBlank() || address == null) {
                response.sendRedirect("/app/users/create.jsp?error=4", true);
            }

            UserService userService = new UserService();
            CurrentUser currentUser = userService.CreateUser(name, email, password, address);

            this.setCurrentUserInSession(request, currentUser);
            response.sendRedirect("/index.jsp", true);

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }

    }


    private void setCurrentUserInSession(HttpServletRequest request, CurrentUser currentUser) {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = (HttpSession) httpRequest.getSession();

        session.setAttribute("currentSessionUser", currentUser);

    }
}
