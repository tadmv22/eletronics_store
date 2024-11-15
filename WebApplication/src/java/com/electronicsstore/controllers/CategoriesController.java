package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.Category;
import com.electronicsstore.services.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CategoriesController", urlPatterns = {"/api/categories/*"})
public class CategoriesController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/categories/remove")) {
                this.remove(request, response);
            } else if (path.endsWith("/api/categories/change-status")) {
                this.changeStatus(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CategoriesController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/categories/create")) {
                this.create(request, response);
            } else if (path.endsWith("/api/categories/update")) {
                this.update(request, response);
            }

        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void changeStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        String endpoint = "/app/admin/categories/list.jsp";

        int id = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

        if (currentUser == null) {
            this.setRequestDispatcherError(request, response, endpoint, "unauthorizedError", "unauthorizedError");
            return;
        }

         CategoryService categoryService = new CategoryService();
        categoryService.changeStatusCategory(id);

        response.sendRedirect("/app/admin/categories/list.jsp");
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));

        String endpoint = "/app/admin/categories/list.jsp";

        HttpSession session = request.getSession();
        CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

        if (currentUser == null) {
            this.setRequestDispatcherError(request, response, endpoint, "unauthorizedError", "unauthorizedError");
            return;
        }

        CategoryService categoryService = new CategoryService();
        categoryService.deleteCategory(id);

        response.sendRedirect("/app/admin/categories/list.jsp");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int status = Integer.parseInt(request.getParameter("status"));

            HttpSession session = request.getSession();
            CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

            if (currentUser == null) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/list.jsp", "unauthorizedError", "unauthorizedError");
                return;
            }

            if (this.checkValuesIsBlank(name, description)) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/update.jsp?id=" + id, "invalidValues", "Os dados de cadastros não podem ser vazios");
                return;
            }

            if (name.length() < 2) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/update.jsp?id=" + id, "nameError", "O nome deve ter pelo menos 2 caracteres");
                return;
            }

            if (description.length() < 2) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/update.jsp?id=" + id, "descriptionError", "A descrição deve ter pelo menos 2 caracteres");
                return;
            }

            CategoryService categoryService = new CategoryService();
            Category categoryExist = categoryService.getById(id);

            if (categoryExist == null) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/list.jsp", "categorieNotFoud", "Categoria com id informação não locaizada");
                return;
            }

            if (!categoryExist.getName().equals(name) && categoryService.checkNameAlreadyInUse(name, id)) {
                this.setRequestDispatcherError(request, response, "/app/admin/categories/update.jsp?id=" + id, "nameInUseError", "Este nome de categoria já está em uso!");
                return;
            }

            categoryExist.setName(name);
            categoryExist.setDescription(description);

            if (status == 1) {
                categoryExist.setIsActive(true);
            } else {
                categoryExist.setIsActive(false);
            }

            Category category = categoryService.updateCategory(categoryExist);

            response.sendRedirect("/app/admin/categories/update.jsp?id=" + category.getId());

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        String endpoint = "/app/admin/categories/create.jsp";

        try {
            if (this.checkValuesIsBlank(name, description)) {
                this.setRequestDispatcherError(request, response, endpoint, "invalidValues", "Os dados de cadastros não podem ser vazios");
                return;
            }

            if (name.length() < 2) {
                this.setRequestDispatcherError(request, response, endpoint, "nameError", "O nome deve ter pelo menos 2 caracteres");
                return;
            }

            if (description.length() < 2) {
                this.setRequestDispatcherError(request, response, endpoint, "descriptionError", "A descrição deve ter pelo menos 2 caracteres");
                return;
            }

            CategoryService categoryService = new CategoryService();
            Category categoryExist = categoryService.getCategoryByName(name);

            if (categoryExist != null) {
                this.setRequestDispatcherError(request, response, endpoint, "nameInUseError", "Este nome de categoria já está em uso!");
                return;
            }

            Category category = categoryService.createCategory(name, description);

            response.sendRedirect("/app/admin/categories/list.jsp");

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
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
