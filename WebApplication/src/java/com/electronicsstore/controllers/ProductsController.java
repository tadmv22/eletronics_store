package com.electronicsstore.controllers;

import com.electronicsstore.models.Product;
import com.electronicsstore.services.ProductsService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProductsController", urlPatterns = {"/api/products/*"})

public class ProductsController extends HttpServlet {

    private final ProductsService service;

    public ProductsController() {
        this.service = new ProductsService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/products/remove")) {
                this.remove(request, response);
            }
        } catch (ClassNotFoundException ex) {
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/products/create")) {
                this.create(request, response);
            }
            else if (path.endsWith("/api/products/update")) {
                this.update(request, response);
                
            }
        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));

        this.service.deleteProduct(id);

        response.sendRedirect("/app/admin/products/list.jsp");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double value = Double.parseDouble(request.getParameter("value"));
        String description = request.getParameter("description");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Product productExisist = this.service.getProductById(id);

        if (productExisist == null) {
            this.setRequestDispatcherError(request, "productNotFoundError", "Produto não encrontado!");
            request.getRequestDispatcher("/app/admin/products/list.jsp").forward(request, response);
            return;
        }

        if (this.checkValuesIsBlank(name, description)) {
            this.setRequestDispatcherError(request, "invalidValues", "Os dados de cadastros não podem ser vazios");
            request.getRequestDispatcher("/app/admin/products/update.jsp").forward(request, response);
            return;
        }

        if (this.validateProductInput(request, name, value, description, stockQuantity)) {
            request.getRequestDispatcher("/app/admin/products/update.jsp").forward(request, response);
            return;
        }

        if (!productExisist.getName().equals(name) && this.service.checkNameAlreadyInUse(name, id)) {
            this.setRequestDispatcherError(request, "nameIsAlreadyUsedError", "Este nome de produto já está em uso!");
            request.getRequestDispatcher("/app/admin/products/update.jsp").forward(request, response);
            return;

        }

        productExisist.setName(name);
        productExisist.setValue(value);
        productExisist.setDescription(description);
        productExisist.setStockQuantity(stockQuantity);
        productExisist.setCategoryId(categoryId);

        service.updateProduct(productExisist);
        request.setAttribute("updateSuccess", true);
            request.getRequestDispatcher("/app/admin/products/update.jsp?id=" + productExisist.getId()).forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        String name = request.getParameter("name");
        double value = Double.parseDouble(request.getParameter("value"));
        String description = request.getParameter("description");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        if (this.checkValuesIsBlank(name, description)) {
            this.setRequestDispatcherError(request, "invalidValues", "Os dados de cadastros não podem ser vazios");
            request.getRequestDispatcher("/app/admin/products/create.jsp").forward(request, response);
            return;
        }

        if (this.validateProductInput(request, name, value, description, stockQuantity)) {
            request.getRequestDispatcher("/app/admin/products/create.jsp").forward(request, response);
            return;
        }

        Product productExisist = this.service.getProductByName(name);

        if (productExisist != null) {
            this.setRequestDispatcherError(request, "nameIsAlreadyUsedError", "Este nome de produto já está em uso!");
            request.getRequestDispatcher("/app/admin/products/create.jsp").forward(request, response);
            return;
        }

        service.createProduct(name, value, description, stockQuantity, categoryId);
        response.sendRedirect("/app/admin/products/list.jsp");
    }

    private boolean validateProductInput(HttpServletRequest request, String name, double value, String description, int stockQuantity) throws ServletException, IOException {
        if (name.length() < 2) {
            this.setRequestDispatcherError(request, "nameError", "O nome deve ter pelo menos 2 caracteres");
            return true;
        }

        if (description.length() < 2) {
            this.setRequestDispatcherError(request, "descriptionError", "A descrição deve ter pelo menos 2 caracteres");
            return true;
        }

        if (value <= 0) {
            this.setRequestDispatcherError(request, "valueError", "O valor deve ser maior que zero");
            return true;
        }

        if (stockQuantity <= 0) {
            this.setRequestDispatcherError(request, "stockError", "A quantidade de itens em estoque deve ser maior que zero");
            return true;
        }
        return false;
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
}
