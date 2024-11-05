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

@WebServlet(name = "UsersController", urlPatterns = {"/users/register"})
public class UsersController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = ((HttpServletRequest) request).getRequestURI();

        try {
            if (path.contains("/users/register")) {
                this.create(request, response);
            } else {
                throw new ServletException("Rota invalida");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UsersController.class.getName()).log(Level.SEVERE, null, ex);
        }


    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        try {
            if (!address.isBlank() || name == null || !name.isBlank() || email == null || !email.isBlank() || !password.isBlank() || address == null) {
                response.sendRedirect("/app/users/register.jsp?error=4", true);
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
