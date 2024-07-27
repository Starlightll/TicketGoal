package Controllers.Ticket;

import DAO.PromotionDAO;
import DAO.TicketDAO;
import Models.Promotion;
import Models.Ticket;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "checkout", value = "/checkout")
public class Checkout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedTicketsJson = request.getParameter("selectedTickets");
        HttpSession session = request.getSession();
        // Parse JSON string to array of Strings
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        Gson gson = new Gson();
        String[] selectedTicketsArray = gson.fromJson(selectedTicketsJson, String[].class);

        // Convert array of Strings to list of Integers
        List<Integer> selectedTickets = Arrays.stream(selectedTicketsArray).map(Integer::parseInt).toList();

        //Get list of tickets from database
        TicketDAO ticketDAO = new TicketDAO();
        List<Ticket> tickets = new ArrayList<>();
        for(Integer ticketId : selectedTickets){
            tickets.add(ticketDAO.getTicketById(ticketId));
        }

        String ticketListHTML = "";
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        currencyFormatter.setMaximumFractionDigits(0);
        for(Ticket ticket : tickets){
            ticketListHTML += "<div class=\"ticket\">\n" +
                    "                        <div>\n" +
                    "                            <div class=\"area\">Area: "+ticket.getSeat().getArea().getAreaName()+"</div>\n" +
                    "                            <div class=\"row\">Row: "+ticket.getSeat().getRow()+"</div>\n" +
                    "                            <div class=\"seat\">Seat: "+ticket.getSeat().getSeatNumber()+"</div>\n" +
                    "                        </div>\n" +
                    "                        <div class=\"price\">"+currencyFormatter.format(ticket.getSeat().getPrice())+"</div>\n" +
                    "                    </div>";
        }
        json.addProperty("tickets", ticketListHTML);

        //Calculate Price
        double serviceFee = 24000;
        String promotionCode = request.getParameter("promotionCode").trim();
        double discount = 0;
        PromotionDAO promotionDAO = new PromotionDAO();
        if(!promotionCode.isEmpty()){
            if(promotionDAO.isPromotionCodeExists(promotionCode)){
                discount = (promotionDAO.getPromotionByCode(promotionCode).getPromotionDiscount());
                if(discount>0){
                    discount = discount/100;
                }
            }
        }else{
            if(session.getAttribute("promotionCode") != null){
                session.removeAttribute("promotionCode");
            }
        }
        // Calculate total item price
        double totalItemPrice = tickets.stream().mapToDouble(ticket -> ticket.getSeat().getPrice()).sum();
        json.addProperty("totalPrice", totalItemPrice);
        //Calculate total price after discount
        double totalPriceAfterDiscount = totalItemPrice - totalItemPrice*discount;
        //Calculate final price
        double finalPrice = totalPriceAfterDiscount + serviceFee;
        json.addProperty("finalPrice", finalPrice);
        json.addProperty("serviceFee", serviceFee);
        json.addProperty("discount", totalItemPrice*discount);
        json.addProperty("discountPercent", discount);
        json.addProperty("totalItem", tickets.size());
        response.getWriter().write(gson.toJson(json));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String promotionCode = request.getParameter("promotionCode").trim();
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        Gson gson = new Gson();
        String selectedTicketsJson = request.getParameter("selectedTickets");
        String[] selectedTicketsArray = gson.fromJson(selectedTicketsJson, String[].class);
        // Convert array of Strings to list of Integers
        List<Integer> selectedTickets = Arrays.stream(selectedTicketsArray).map(Integer::parseInt).toList();

        //Get list of tickets from database
        TicketDAO ticketDAO = new TicketDAO();
        List<Ticket> tickets = new ArrayList<>();
        Set<Integer> matchIds = new HashSet<>();
        for(Integer ticketId : selectedTickets){
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            tickets.add(ticket);
            matchIds.add(ticket.getMatch().getMatchId());
        }

        boolean isMultipleMatch = matchIds.size() > 1;

        if(!promotionCode.isEmpty()){
            if(isMultipleMatch){
                json.addProperty("valid", false);
                json.addProperty("message", "You can only apply promotion code for tickets of the same match");
                response.getWriter().write(gson.toJson(json));
                return;
            }
            PromotionDAO promotionDAO = new PromotionDAO();
            if(promotionDAO.isPromotionCodeExists(promotionCode)){
                Promotion promotion = promotionDAO.getPromotionByCode(promotionCode);
                HttpSession session = request.getSession();
                if(promotion.getPromotionMatchId() != (int) session.getAttribute("matchId")){
                    json.addProperty("valid", false);
                    json.addProperty("message", "Promotion code is not valid for this match");
                }else{
                    json.addProperty("valid", true);
                    json.addProperty("message", "applied promotion");
                    session.setAttribute("promotionCode", promotionCode);
                }
            }
            else{
                json.addProperty("valid", false);
                json.addProperty("message", "Invalid promotion code");
            }
        }else{
            json.addProperty("valid", false);
            json.addProperty("message", "Please enter promotion code");
        }
        response.getWriter().write(gson.toJson(json));
    }
}
