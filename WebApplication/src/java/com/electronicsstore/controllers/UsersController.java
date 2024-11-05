package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.User;
import com.electronicsstore.services.UserService;
import com.electronicsstore.utils.ErrorMensagem;
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
                request.setAttribute("invalidValues", ErrorMensagem.getMessageByCode(4));
                request.getRequestDispatcher("/app/users/create.jsp").forward(request, response);
            }

            UserService userService = new UserService();
            User userExist = userService.getUserByEmail(email);
            
            if(userExist != null) {
                request.setAttribute("emailInUseError", ErrorMensagem.getMessageByCode(5));
                request.getRequestDispatcher("/app/users/create.jsp").forward(request, response);
            }
            
            
            User user = userService.createUser(name, email, password, address);
            CurrentUser currentUser = new CurrentUser(user.getName(),user.getEmail());

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
