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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UsersController", urlPatterns = {"/api/users/*"})
public class UsersController extends HttpServlet {

    private final UserService service;

    public UsersController() throws ClassNotFoundException {
        this.service = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/users/remove")) {
                this.remove(request, response);
            } else if (path.endsWith("/api/users/change-status")) {
                this.changeStatus(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UsersController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/users/create")) {
                this.create(request, response);
            } else if (path.endsWith("/api/users/update")) {
                this.update(request, response);
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void changeStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {

        int id = Integer.parseInt(request.getParameter("id"));

        this.service.changeStatusUser(id);

        response.sendRedirect("/app/admin/users/list.jsp");
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));

        this.service.deleteUser(id);

        response.sendRedirect("/app/admin/users/list.jsp");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String email = request.getParameter("email");
            String oldPassword = request.getParameter("oldPassword");
            String password = request.getParameter("password");
            int status = Integer.parseInt(request.getParameter("status"));

            HttpSession session = request.getSession();
            CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

            User userExist = this.service.getUserById(id);

            if (userExist == null) {
                this.setRequestDispatcherError(request, "userNotFoud", "Usuário com id informado não localizado");
                request.getRequestDispatcher("/app/admin/users/list.jsp").forward(request, response);
                return;
            }

            if (currentUser.getId() != id) {

                if (this.checkValuesIsBlank(name, surname, email)) {
                    this.setRequestDispatcherError(request, "invalidValues", "Os dados de cadastros não podem ser vazios");
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                if (this.validateUserInputs(request, name, surname, email,null)) {
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                if (!userExist.getEmail().equals(email) && this.service.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(name);
                userExist.setSurname(surname);
                userExist.changeStatus(status);

            } else {

                if (this.checkValuesIsBlank(name, surname, email, oldPassword, password)) {
                    this.setRequestDispatcherError(request, "invalidValues", "Os dados de cadastros não podem ser vazios");
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                if (!oldPassword.equals(password)) {
                    this.setRequestDispatcherError(request, "passwordNoMatchError", "passwordNoMatchError");
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                if (this.validateUserInputs(request, name, surname, email, password)) {
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                if (!userExist.getEmail().equals(email) && this.service.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + id).forward(request, response);
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(name);
                userExist.setSurname(surname);
                userExist.setPassword(password);
                userExist.changeStatus(status);
            }

            User user = this.service.updateUser(userExist);

            request.setAttribute("updateSuccess", true);
            request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + user.getId()).forward(request, response);

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String endpoint = "/app/admin/users/create.jsp";

        try {
            if (this.checkValuesIsBlank(name, surname, email, password)) {
                this.setRequestDispatcherError(request, "invalidValues", "Os dados de cadastros não podem ser vazios");
                request.getRequestDispatcher("/app/admin/users/create.jsp").forward(request, response);
                return;
            }

            if (this.validateUserInputs(request, name, surname, email, password)) {
                request.getRequestDispatcher("/app/admin/users/create.jsp").forward(request, response);
                return;
            }

            User userExist = service.getUserByEmail(email);

            if (userExist != null) {
                this.setRequestDispatcherError(request, "emailInUseError", "Este endereço de e-mail já está em uso!");
                request.getRequestDispatcher("/app/admin/users/create.jsp").forward(request, response);
                return;
            }

            service.createUser(name, surname, email, password);
            response.sendRedirect("/app/admin/users/list.jsp");

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void setRequestDispatcherError(HttpServletRequest request, String code, String mensagem) throws ServletException, IOException {
        request.setAttribute(code, mensagem);
    }

    private boolean checkValuesIsBlank(String... values) {
        for (String v : values) {
            if (v == null || v.isBlank()) {
                return true;
            }
        }
        return false;
    }

    private boolean validateUserInputs(HttpServletRequest request, String name, String surname, String email, String password) throws ServletException, IOException {

        if (name.length() < 2) {
            this.setRequestDispatcherError(request, "nameError", "O nome deve ter pelo menos 2 caracteres");
            return true;
        }

        if (surname.length() < 2) {
            this.setRequestDispatcherError(request, "surnameError", "O sobrenome deve ter pelo menos 2 caracteres");
            return true;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            this.setRequestDispatcherError(request, "invalidEmail", "O endereço deve ser um email válido");
            return true;
        }

        if (password != null && password.length() < 8) {
            this.setRequestDispatcherError(request, "passwordError", "A senha deve ter pelo menos 8 caracteres");
            return true;
        }

        return false;
    }

}
