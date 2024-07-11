/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import DAO.TicketDAO;
import Models.Ticket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author MSI VN
 */
@WebServlet(name = "ticketManagementServlet", urlPatterns = {"/ticketManagement"})
public class ticketManagementServlet extends HttpServlet {

    private final TicketDAO tickDAO = new TicketDAO();
    private final int tickScannedStatus = 1;
    private final int ticketMarkedStatus = 2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        if (type == null) {
            type = "scanned";
        }

        List<Ticket> tickets = new ArrayList<>();
        tickets = switch (type) {
            case "scanned" -> tickDAO.getTicketByTicketStatus(tickScannedStatus);
            case "marked" -> tickDAO.getTicketByTicketStatus(ticketMarkedStatus);
            default -> tickDAO.getTicketByTicketStatus(tickScannedStatus);
        };

        request.setAttribute("tickets", tickets);
        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("ticketManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");

        request.setAttribute("page", "/Views/Admin/Ticket/TicketManagement.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
