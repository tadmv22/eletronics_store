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

@WebServlet(name = "UsersController", urlPatterns = {"/api/users/*"})
public class UsersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.contains("/api/users/remove")) {
            this.remove(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/users/register")) {
                this.create(request, response);
            } else if (path.endsWith("/api/users/update")) {
                this.update(request, response);
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) {

    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String email = request.getParameter("email");
            String oldPassword = request.getParameter("oldPassword");
            String password = request.getParameter("password");

            HttpSession session = request.getSession();
            CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

            if (currentUser == null) {
                this.setRequestDispatcherError(request, response, "unauthorizedError", "unauthorizedError");
                return;
            }

            if (currentUser.getId() != id) {
                if (this.checkValuesIsBlank(name, surname, email)) {
                    this.setRequestDispatcherError(request, response, "invalidValues", "Os dados de cadastros não podem ser vazios");
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
                    this.setRequestDispatcherError(request, response, "invalidEmail", "O endereço deve ser um email válido");
                    return;
                }

                UserService userService = new UserService();
                User userExist = userService.getUserByEmail(email);

                if (userExist == null) {
                    this.setRequestDispatcherError(request, response, "userNotFoud", "userNotFoud");
                    return;
                }

                if (userService.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, response, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(email);
                userExist.setSurname(email);

                User user = userService.updateUser(userExist);

            } else {
                if (this.checkValuesIsBlank(name, surname, email, oldPassword, password)) {
                    this.setRequestDispatcherError(request, response, "invalidValues", "Os dados de cadastros não podem ser vazios");
                    return;
                }

                if (!oldPassword.equals(password)) {
                    this.setRequestDispatcherError(request, response, "passwordNoMatchError", "passwordNoMatchError");
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
                    this.setRequestDispatcherError(request, response, "invalidEmail", "O endereço deve ser um email válido");
                    return;
                }

                if (password.length() < 8) {
                    this.setRequestDispatcherError(request, response, "passwordError", "A senha deve ter pelo menos 8 caracteres");
                    return;
                }

                UserService userService = new UserService();
                User userExist = userService.getUserByEmail(email);

                if (userExist == null) {
                    this.setRequestDispatcherError(request, response, "userNotFoud", "userNotFoud");
                    return;
                }

                if (userService.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, response, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(email);
                userExist.setSurname(email);

                User user = userService.updateUser(userExist);

                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (this.checkValuesIsBlank(name, surname, email, password)) {
                this.setRequestDispatcherError(request, response, "invalidValues", "Os dados de cadastros não podem ser vazios");
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
                this.setRequestDispatcherError(request, response, "invalidEmail", "O endereço deve ser um email válido");
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

            User user = userService.createUser(name, surname, email, password);
            CurrentUser currentUser = new CurrentUser(user.getId(),user.getEmail(),user.getName(),user.getSurname() );

            this.setCurrentUserInSession(request, currentUser);
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void setCurrentUserInSession(HttpServletRequest request, CurrentUser currentUser) {
        HttpSession session = request.getSession();
        session.setAttribute("currentSessionUser", currentUser);
    }

    private void setRequestDispatcherError(HttpServletRequest request, HttpServletResponse response, String code, String mensagem) throws ServletException, IOException {
        request.setAttribute(code, mensagem);
        request.getRequestDispatcher("/app/users/register.jsp").forward(request, response);
    }

    private boolean checkValuesIsBlank(String... values) {
        for (String v : values) {
            if (v == null || v.isBlank()) {
                return true;
            }
        }
        return false;
    }
}
