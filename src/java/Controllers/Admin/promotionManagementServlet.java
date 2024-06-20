/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import DAO.PromotionDAO;
import DAO.PromotionMatchDAO;
import Models.Promotion;
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
 *
 * @author MSI VN
 */
@WebServlet(name = "promotionManagementServlet", urlPatterns = {"/promotionManagement"})
public class promotionManagementServlet extends HttpServlet {

    private final PromotionDAO proDAO = new PromotionDAO();
    private final PromotionMatchDAO proMatchDAO = new PromotionMatchDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchParam = request.getParameter("q");
        String sortBy = request.getParameter("sort");

        List<Promotion> listPromotion = proDAO.getPromotionsBySearchAndSort(searchParam, sortBy);
        request.setAttribute("promotions", listPromotion);

        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("promotionManagement", "style=\"background-color: #00C767; pointer-events: none;\"");

        request.setAttribute("page", "/Views/Admin/Promotion/PromotionManagement.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        if (type == null) {
            request.getRequestDispatcher("404_Error.jsp").forward(request, response);
            return;
        }
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String id = request.getParameter("id");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        switch (type) {
            case "create" -> {
                if (code == null || description == null || startDate == null || endDate == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                Promotion newPromotion = proDAO.insertPromotion(new Promotion(
                        code, description,
                        LocalDateTime.parse(startDate, formatter),
                        LocalDateTime.parse(endDate, formatter)));
                System.out.println(newPromotion);
                response.sendRedirect("./promotionManagement");
                return;
            }
            case "update" -> {
                if (code == null || description == null || startDate == null || endDate == null || id == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                boolean isUpdated = proDAO.updatePromotion(new Promotion(Integer.parseInt(id),
                        code, description,
                        LocalDateTime.parse(startDate, formatter),
                        LocalDateTime.parse(endDate, formatter)));
                if (isUpdated) {
                    response.sendRedirect("./promotionManagement");
                    return;
                }
            }
            case "delete" -> {
                if (id == null) {
                    request.setAttribute("message", "you must input all field");
                    doGet(request, response);
                    return;
                }
                boolean isUpdated = proDAO.deletePromotion(Integer.parseInt(id));
                if (isUpdated) {
                    response.sendRedirect("./promotionManagement");
                    return;
                }
            }
            default ->
                throw new AssertionError();
        }
    }

}
