package Controllers.Operator;

import DAO.TicketDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "TicketChecking", value = "/TicketChecking")
public class TicketChecking extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("Views/Operator/TicketChecking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TicketDAO ticketDAO = new TicketDAO();
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        Gson gson = new Gson();
        String code = request.getParameter("code");
        // Check if the ticket code is valid
        // If valid, display the ticket information
        // If not, display an error message
        if(ticketDAO.verifyTicket(code)) {
            json.addProperty("valid", true);
            response.getWriter().write(gson.toJson(json));
        } else {
            json.addProperty("valid", false);
            response.getWriter().write(gson.toJson(json));
        }
    }
}
