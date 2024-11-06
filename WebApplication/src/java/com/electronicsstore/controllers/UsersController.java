package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.User;
import com.electronicsstore.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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
            throw new ServletException(ex);
        }

    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {

        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String zipcode = request.getParameter("zipcode");
        String password = request.getParameter("password");

        try {
            if (this.checkValuesIsBlank(name, surname, email, address, zipcode, password)) {
                this.setRequestDispatcherError(request, response, "invalidValues", "Os dados de cadastros não podem ser vázios");
                return;
            }

            if (name.length() < 2) {
                this.setRequestDispatcherError(request, response, "nameError", "O nome deve ter pelo menos 2 caracteres");
                return;
            }

            if (surname.length() < 2) {
                this.setRequestDispatcherError(request, response, "surnameError", "O sobrenome deve ter pelo menos 2 caracteres");
                return;
            }

            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                this.setRequestDispatcherError(request, response, "invalidEmail", "O endereço deve ter pelo menos 5 caracteres");
                return;
            }
            
            
            if (address.length() < 5) {
                this.setRequestDispatcherError(request, response, "addressError", "O endereço deve ter pelo menos 5 caracteres");
                return;
            }

             if (!zipcode.matches("(^[0-9]{5})-?([0-9]{3}$)")) {
                this.setRequestDispatcherError(request, response, "addressError", "O endereço deve ter pelo menos 5 caracteres");
                return;
            }
            if (password.length() < 8) {
                this.setRequestDispatcherError(request, response, "passwordError", "A senha deve ter pelo menos 8 caracteres");
                return;
            }

            UserService userService = new UserService();
            User userExist = userService.getUserByEmail(email);

            if (userExist != null) {
                this.setRequestDispatcherError(request, response, "emailInUseError", "Este endereço de e-mail já está em uso!");
                return;
            }

            User user = userService.createUser(name,surname, email, password, address,zipcode);
            CurrentUser currentUser = new CurrentUser(user.getName(), user.getEmail(),user.getAddress(),user.getZipcode());

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

    private void setRequestDispatcherError(HttpServletRequest request, HttpServletResponse response, String code, String mensagem) throws ServletException, IOException {
        request.setAttribute(code, mensagem);
        request.getRequestDispatcher("/app/users/register.jsp").forward(request, response);
    }

    private boolean checkValuesIsBlank(String...values) {
        boolean isBlank = false;
        
        for (String v : values) {
            if (v == null || v.isBlank()) {
                isBlank = true;
                break;
            }
        }
        return isBlank;
    }

}
