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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/users/remove")) {
                this.remove(request, response);
            } else if(path.endsWith("/api/users/change-status")) {
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
        String endpoint = "/app/admin/users/list.jsp";
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        HttpSession session = request.getSession();
        CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

        if (currentUser == null) {
            this.setRequestDispatcherError(request, response, endpoint, "unauthorizedError", "unauthorizedError");
            return;
        }
        
        UserService userService = new UserService();
        
        userService.changeStatusUser(id);
        
        response.sendRedirect("/app/admin/users/list.jsp");
    }
    
    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));

        String endpoint = "/app/admin/users/list.jsp";

        HttpSession session = request.getSession();
        CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

        if (currentUser == null) {
            this.setRequestDispatcherError(request, response, endpoint, "unauthorizedError", "unauthorizedError");
            return;
        }

        UserService userService = new UserService();
        userService.deleteUser(id);

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

            if (currentUser == null) {
                this.setRequestDispatcherError(request, response, "/app/admin/users/list.jsp", "unauthorizedError", "unauthorizedError");
                return;
            }

            if (currentUser.getId() != id) {

                if (this.checkValuesIsBlank(name, surname, email)) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "invalidValues", "Os dados de cadastros não podem ser vazios");
                    return;
                }

                if (name.length() < 2) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "nameError", "O nome deve ter pelo menos 2 caracteres");
                    return;
                }

                if (surname.length() < 2) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "surnameError", "O sobrenome deve ter pelo menos 2 caracteres");
                    return;
                }

                if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "invalidEmail", "O endereço deve ser um email válido");
                    return;
                }

                UserService userService = new UserService();
                User userExist = userService.getUserById(id);

                if (userExist == null) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/list.jsp", "userNotFoud", "Usuário com id informado não localizado");
                    return;
                }

                if (!userExist.getEmail().equals(email) && userService.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(name);
                userExist.setSurname(surname);
                userExist.changeStatus(status);

                User user = userService.updateUser(userExist);
                
                
                request.setAttribute("updateSuccess", true);
                request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + user.getId()).forward(request, response);
        

            } else {

                if (this.checkValuesIsBlank(name, surname, email, oldPassword, password)) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "invalidValues", "Os dados de cadastros não podem ser vazios");
                    return;
                }

                if (!oldPassword.equals(password)) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "passwordNoMatchError", "passwordNoMatchError");
                    return;
                }

                if (name.length() < 2) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "nameError", "O nome deve ter pelo menos 2 caracteres");
                    return;
                }

                if (surname.length() < 2) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "surnameError", "O sobrenome deve ter pelo menos 2 caracteres");
                    return;
                }

                if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "invalidEmail", "O endereço deve ser um email válido");
                    return;
                }

                if (password.length() < 8) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "passwordError", "A senha deve ter pelo menos 8 caracteres");
                    return;
                }

                UserService userService = new UserService();
                User userExist = userService.getUserById(id);

                if (userExist == null) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/list.jsp", "userNotFoud", "userNotFoud");
                    return;
                }

                if (!userExist.getEmail().equals(email) && userService.checkEmailAlreadyInUse(email, id)) {
                    this.setRequestDispatcherError(request, response, "/app/admin/users/update.jsp?id=" + id, "emailInUseError", "Este endereço de e-mail já está em uso!");
                    return;
                }

                userExist.setEmail(email);
                userExist.setName(name);
                userExist.setSurname(surname);
                userExist.setPassword(password);
                
                if (status == 1) {
                    userExist.setIsActive(true);
                } else {
                    userExist.setIsActive(false);
                }

                User user = userService.updateUser(userExist);

                request.setAttribute("updateSuccess", true);
                request.getRequestDispatcher("/app/admin/users/update.jsp?id=" + user.getId()).forward(request, response);
        
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

        String endpoint = "/app/admin/users/create.jsp";

        try {
            if (this.checkValuesIsBlank(name, surname, email, password)) {
                this.setRequestDispatcherError(request, response, endpoint, "invalidValues", "Os dados de cadastros não podem ser vazios");
                return;
            }

            if (name.length() < 2) {
                this.setRequestDispatcherError(request, response, endpoint, "nameError", "O nome deve ter pelo menos 2 caracteres");
                return;
            }

            if (surname.length() < 2) {
                this.setRequestDispatcherError(request, response, endpoint, "surnameError", "O sobrenome deve ter pelo menos 2 caracteres");
                return;
            }

            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
                this.setRequestDispatcherError(request, response, endpoint, "invalidEmail", "O endereço deve ser um email válido");
                return;
            }

            if (password.length() < 8) {
                this.setRequestDispatcherError(request, response, endpoint, "passwordError", "A senha deve ter pelo menos 8 caracteres");
                return;
            }

            UserService userService = new UserService();
            User userExist = userService.getUserByEmail(email);

            if (userExist != null) {
                this.setRequestDispatcherError(request, response, endpoint, "emailInUseError", "Este endereço de e-mail já está em uso!");
                return;
            }

            User user = userService.createUser(name, surname, email, password);
            CurrentUser currentUser = new CurrentUser(user.getId(), user.getEmail(), user.getName(), user.getSurname());

            this.setCurrentUserInSession(request, currentUser);
            response.sendRedirect("/app/admin/users/list.jsp");

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void setCurrentUserInSession(HttpServletRequest request, CurrentUser currentUser) {
        HttpSession session = request.getSession();
        session.setAttribute("currentSessionUser", currentUser);
    }

    private void setRequestDispatcherError(HttpServletRequest request, HttpServletResponse response, String endpoint, String code, String mensagem) throws ServletException, IOException {
        request.setAttribute(code, mensagem);
        request.getRequestDispatcher(endpoint).forward(request, response);
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
