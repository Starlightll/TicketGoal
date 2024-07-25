/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import DAO.AccountDAO;
import DAO.MatchDAO;
import DAO.PromotionDAO;
import Models.Promotion;
import Utils.EmailSender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author MSI VN
 */
@WebServlet(name = "promotionManagementServlet", urlPatterns = {"/promotionManagement"})
public class promotionManagementServlet extends HttpServlet {

    private final PromotionDAO proDAO = new PromotionDAO();
    private final AccountDAO accDAO = AccountDAO.INSTANCE;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchParam = request.getParameter("q");
        String sortBy = request.getParameter("sort");
        String index = request.getParameter("index");
        int pageSize = 10;
        int pageIndex = 1;
        if (index != null) {
            pageIndex = Integer.parseInt(index);
        }
        int totalPage = proDAO.getAllPromotions().size() / pageSize + 1;
        List<Promotion> listPromotion = proDAO.getPromotionsBySearchAndSort(searchParam, sortBy, pageIndex, pageSize);

        request.setAttribute("pageIndex", pageIndex);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("promotions", listPromotion);
        request.setAttribute("searchParam", searchParam);
        request.setAttribute("listMatch", MatchDAO.INSTANCE.getMatchesByStatusId(1));
        request.setAttribute("MatchDAO", MatchDAO.INSTANCE);
        //set cssF
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("promotionManagement", "style=\"background-color: #00C767; pointer-events: none;\"");

        request.setAttribute("page", "/Views/Admin/Promotion/PromotionManagement.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String referrer = request.getHeader("referer");

        if (type == null) {
            request.getRequestDispatcher("404_Error.jsp").forward(request, response);
            return;
        }
        String code = request.getParameter("code");
        int discount = 0;
        if (code != null) {
            code = code.toUpperCase();
        }
        String description = request.getParameter("description");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String id = request.getParameter("id");
        String promotionMatch = request.getParameter("promotionMatch");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        String promotionDiscount = request.getParameter("promotionDiscount");
        if (promotionDiscount != null && !promotionDiscount.isEmpty()) {
            System.out.println(Integer.parseInt(promotionDiscount));
            discount = Integer.parseInt(promotionDiscount);
        }
        switch (type) {
            case "create" -> {
                if (code == null || description == null || startDate == null || endDate == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                LocalDateTime startDateTime = LocalDateTime.parse(startDate, formatter);
                LocalDateTime endDateTime = LocalDateTime.parse(endDate, formatter);
                if (startDateTime.isAfter(endDateTime)) {
                    request.setAttribute("message", "Start date must be earlier than end date.");
                    doGet(request, response);
                    return;
                }
                if (discount > 100 || discount < 1) {
                    System.out.println(discount);
                    request.setAttribute("message", "Invalid Discount");
                    doGet(request, response);
                    return;
                }
                try {
                    Promotion pro = new Promotion(
                            code, description,
                            startDateTime, endDateTime, Integer.parseInt(promotionMatch), discount);
                    new Thread(() -> {
                        try {
                            new EmailSender().sendPromotion(accDAO.getAccountByRole(2), pro, request, response);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }).start();
                    proDAO.insertPromotion(pro);
                    response.sendRedirect(referrer);
                } catch (Exception e) {
                    request.setAttribute("message", e.getMessage());
                    doGet(request, response);
                }
                break;
            }
            case "update" -> {
                if (code == null || description == null || startDate == null || endDate == null || id == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                LocalDateTime startDateTime = LocalDateTime.parse(startDate, formatter);
                LocalDateTime endDateTime = LocalDateTime.parse(endDate, formatter);
                if (startDateTime.isAfter(endDateTime)) {
                    request.setAttribute("message", "Start date must be earlier than end date.");
                    doGet(request, response);
                    return;
                }
                if (discount > 100 || discount < 1) {
                    request.setAttribute("message", "Invalid Discount");
                    doGet(request, response);
                    return;
                }
                boolean isUpdated = proDAO.updatePromotion(new Promotion(Integer.parseInt(id),
                        code, description,
                        startDateTime,
                        endDateTime, Integer.parseInt(promotionMatch), discount));
                if (isUpdated) {
                    response.sendRedirect(referrer);
                    return;
                }
                break;
            }
            case "delete" -> {
                System.out.println(id);
                if (id == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                boolean isUpdated = proDAO.deletePromotion(Integer.parseInt(id));
                if (isUpdated) {
                    response.sendRedirect(referrer);
                }
                break;
            }
            default ->
                throw new AssertionError();
        }
    }

}
