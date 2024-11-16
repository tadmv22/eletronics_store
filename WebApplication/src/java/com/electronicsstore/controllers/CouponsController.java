package com.electronicsstore.controllers;

import com.electronicsstore.dto.CurrentUser;
import com.electronicsstore.models.Coupon;
import com.electronicsstore.services.CouponService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "CouponsController", urlPatterns = {"/api/coupons/*"})
public class CouponsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/coupons/remove")) {
                this.remove(request, response);
            }
        } catch (ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();

        try {
            if (path.endsWith("/api/coupons/create")) {
                this.create(request, response);
            } else if (path.endsWith("/api/coupons/update")) {
                this.update(request, response);
            }

        } catch (ClassNotFoundException | ParseException ex) {
            throw new ServletException(ex);
        }
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ClassNotFoundException {
        int id = Integer.parseInt(request.getParameter("id"));

        String endpoint = "/app/admin/coupons/list.jsp";

        HttpSession session = request.getSession();
        CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

        if (currentUser == null) {
            this.setRequestDispatcherError(request, response, endpoint, "unauthorizedError", "unauthorizedError");
            return;
        }

        CouponService couponService = new CouponService();
        couponService.deleteCoupon(id);

        response.sendRedirect("/app/admin/coupons/list.jsp");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            Date expirationAt = null;
            int id = Integer.parseInt(request.getParameter("id"));

            String code = request.getParameter("code");
            String description = request.getParameter("description");
            double discountValue = Double.parseDouble(request.getParameter("discountValue"));
            Date startAt = sdf.parse(request.getParameter("startAt"));

            if (!request.getParameter("expirationAt").isBlank()) {
                expirationAt = sdf.parse(request.getParameter("expirationAt"));
            }

            int status = Integer.parseInt(request.getParameter("status"));

            String endpoint = "/app/admin/coupons/create.jsp";

            HttpSession session = request.getSession();
            CurrentUser currentUser = (CurrentUser) session.getAttribute("currentSessionUser");

            if (currentUser == null) {
                this.setRequestDispatcherError(request, response, "/app/admin/coupons/list.jsp", "unauthorizedError", "unauthorizedError");
                return;
            }

            if (this.checkValuesIsBlank(code, description)) {
                this.setRequestDispatcherError(request, response, "/app/admin/coupons/update.jsp?id=" + id, "invalidValues", "Os dados de cadastros não podem ser vazios");
                return;
            }

            if (code.length() < 6) {
                this.setRequestDispatcherError(request, response, endpoint, "nameError", "O código deve ter pelo menos 6 caracteres");
                return;
            }

            if (description.length() < 5) {
                this.setRequestDispatcherError(request, response, endpoint, "descriptionError", "A descrição deve ter pelo menos 5 caracteres");
                return;
            }

            if (discountValue <= 0) {
                this.setRequestDispatcherError(request, response, endpoint, "discountValueError", "O valor de desconto deve ser maior que zero");
                return;
            }

            if (expirationAt != null && !startAt.before(expirationAt)) {
                this.setRequestDispatcherError(request, response, endpoint, "startAtError", "A data de início deve ser maior que a data de expiração");
                return;
            }

            if (expirationAt != null && !expirationAt.after(new Date())) {
                this.setRequestDispatcherError(request, response, endpoint, "expirationAtError", "A data de expiração deve maior que a data atual");
                return;
            }

            CouponService couponService = new CouponService();
            Coupon couponExist = couponService.getCouponByCode(code);

            if (couponExist == null) {
                this.setRequestDispatcherError(request, response, "/app/admin/coupons/list.jsp", "couponNotFoud", "Cupom com id informação não locaizada");
                return;
            }

            if (!couponExist.getCode().equals(code) && couponService.checkCodeAlreadyInUse(code, id)) {
                this.setRequestDispatcherError(request, response, "/app/admin/coupons/update.jsp?id=" + id, "codeInUseError", "Este nome de código já está em uso!");
                return;
            }

            couponExist.setCode(code);
            couponExist.setDescription(description);
            couponExist.setDiscountValue(discountValue);
            couponExist.setStartAt(startAt);
            couponExist.setExpirationAt(expirationAt);
            couponExist.changeStatus(status);

            Coupon coupon = couponService.updateCoupon(couponExist);

            request.setAttribute("updateSuccess", true);
            request.getRequestDispatcher("/app/admin/coupons/update.jsp?id=" + coupon.getId()).forward(request, response);

        } catch (ServletException | IOException | ClassNotFoundException ex) {
            throw new ServletException(ex);
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, ClassNotFoundException, IOException, ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date expirationAt = null;

        String code = request.getParameter("code");
        String description = request.getParameter("description");
        double discountValue = Double.parseDouble(request.getParameter("discountValue"));
        Date startAt = sdf.parse(request.getParameter("startAt"));
        
        if (request.getParameter("expirationAt") != null && !request.getParameter("expirationAt").isBlank()) {
            expirationAt = sdf.parse(request.getParameter("expirationAt"));
        }

        String endpoint = "/app/admin/coupons/create.jsp";

        try {
            if (this.checkValuesIsBlank(code, description)) {
                this.setRequestDispatcherError(request, response, endpoint, "invalidValues", "Os dados de cadastros não podem ser vazios");
                return;
            }

            if (code.length() < 6) {
                this.setRequestDispatcherError(request, response, endpoint, "nameError", "O código deve ter pelo menos 6 caracteres");
                return;
            }

            if (description.length() < 5) {
                this.setRequestDispatcherError(request, response, endpoint, "descriptionError", "A descrição deve ter pelo menos 5 caracteres");
                return;
            }

            if (discountValue <= 0) {
                this.setRequestDispatcherError(request, response, endpoint, "discountValueError", "O valor de desconto deve ser maior que zero");
                return;
            }

            if (expirationAt != null && !startAt.before(expirationAt)) {
                this.setRequestDispatcherError(request, response, endpoint, "startAtError", "A data de início deve ser maior que a data de expiração");
                return;
            }

            if (expirationAt != null && !expirationAt.after(new Date())) {
                this.setRequestDispatcherError(request, response, endpoint, "expirationAtError", "A data de expiração deve maior que a data atual");
                return;
            }

            CouponService couponService = new CouponService();
            Coupon CouponExist = couponService.getCouponByCode(code);

            if (CouponExist != null) {
                this.setRequestDispatcherError(request, response, endpoint, "codeError", "Este código de cupom já está em uso!");
                return;
            }

            Coupon coupon = couponService.createCoupon(code.toUpperCase(), description, discountValue, startAt, expirationAt);

            response.sendRedirect("/app/admin/coupons/list.jsp");

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
