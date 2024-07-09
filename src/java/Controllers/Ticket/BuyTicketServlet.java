/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Ticket;

import DAO.*;
import Models.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.*;


/**
 * @author mosdd
 */
@WebServlet(name = "BuyTicketServlet", urlPatterns = {"/BuyTicket"})
public class BuyTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        if (account == null) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("loginRequired");
            request.setAttribute("showLogin", "show-login");
            request.getRequestDispatcher("matchServlet").forward(request, response);
        } else {
            int matchId = 0;
            try {
                matchId = Integer.parseInt(request.getParameter("matchId"));
            } catch (Exception e) {
                System.out.println("Error: " + e);
            }
            Match match = MatchDAO.INSTANCE.getMatch(matchId);
            if (match.matchStatusId != 2) {
                request.setAttribute("notification", "Match is not available for ticket purchase");
            }
            List<Seat> seatList = getSeatListWithAccount(account, matchId);
            request.setAttribute("seatsARO", getSeatsARO(seatList));
            request.setAttribute("seatsALO", getSeatsALO(seatList));
            request.setAttribute("seatsBRO", getSeatsBRO(seatList));
            request.setAttribute("seatsCRO", getSeatsCRO(seatList));
            request.setAttribute("seatsCLO", getSeatsCLO(seatList));
            request.setAttribute("seatsDLO", getSeatsDLO(seatList));
            request.setAttribute("matchId", matchId);
            List<Ticket> ticketInCart = new TicketDAO().getTicketInCartByMatchAndAccount(account, matchId);
            request.setAttribute("ticketInCart", ticketInCart);
            request.setAttribute("total", total(ticketInCart));
            request.getRequestDispatcher("/Views/Ticket/BuyTicket.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        Gson gson = new Gson();
        if (account == null) {
            json.addProperty("loginRequired", "true");
            response.getWriter().write(gson.toJson(json));
        } else {
            String action = request.getParameter("action");
            int seatId = request.getParameter("seatId") != null ? Integer.parseInt(request.getParameter("seatId")) : 0;
            Match match = MatchDAO.INSTANCE.getMatch(request.getParameter("matchId") != null ? Integer.parseInt(request.getParameter("matchId")) : SeatDAO.INSTANCE.getSeatById(seatId).getMatchId());
            switch (action) {
                case "buyOneTicket":
                    int ticketId = addToCart(account, seatId);
                    if(ticketId == 0){
                        json.addProperty("isError", "true");
                    }else if(ticketId == -1){
                        json.addProperty("isPurchased", "true");
                        json.addProperty("stadium", stadium(request, response, account, match.getMatchId()));
                    }else if (ticketId == -2){
                        json.addProperty("notAvailable", "true");
                    }else{
                        List<Ticket> tickets = new ArrayList<>();
                        tickets.add(new TicketDAO().getTicketById(ticketId));
                        int orderId = OrderDAO.INSTANCE.createOrder(account, tickets, 2);
                        request.getSession().setAttribute("orderId", orderId);
                        request.getRequestDispatcher("payServlet").forward(request, response);
                    }
                    response.getWriter().write(gson.toJson(json));
                    break;
                case "buyTicket":
                    if(match.schedule.before(new java.util.Date())){
                        json.addProperty("notAvailable", "true");
                        json.addProperty("stadium", stadium(request, response, account, match.getMatchId()));
                        response.getWriter().write(gson.toJson(json));
                        return;
                    }else{
                    List<Ticket> ticketInCart = new TicketDAO().getTicketInCartByMatchAndAccount(account, match.matchId);
                    int order = OrderDAO.INSTANCE.createOrder(account, ticketInCart, 2);
                    request.getSession().setAttribute("orderId", order);
                    request.getRequestDispatcher("payServlet").forward(request, response);
                    }
                    break;
                case "addToCart":
                    int addedTicket = addToCart(account, seatId);
                    if(addedTicket == 0){
                        json.addProperty("isError", "true");
                    }else if(addedTicket == -1){
                        json.addProperty("isPurchased", "true");
                        json.addProperty("stadium", stadium(request, response, account, match.getMatchId()));
                    }else if (addedTicket == -2){
                        json.addProperty("notAvailable", "true");
                    } else {
                        json.addProperty("isSuccess", "true");
                        json.addProperty("stadium", stadium(request, response, account, match.getMatchId()));
                        Ticket ticket = new TicketDAO().getTicketById(addedTicket);
                        json.addProperty("addedTicket", ticket(ticket));
                        json.addProperty("total", total(new TicketDAO().getTicketInCartByMatchAndAccount(account, match.matchId)));
                    }
                    response.getWriter().write(gson.toJson(json));
                    break;
                case "removeFromCart":
                    ticketId = request.getParameter("ticketId") != null ? Integer.parseInt(request.getParameter("ticketId")) : 0;
                    int matchId = request.getParameter("matchId") != null ? Integer.parseInt(request.getParameter("matchId")) : 0;
                    TicketDAO ticketDAO = new TicketDAO();
                    ticketDAO.removeTicket(ticketId);
                    json.addProperty("isSuccess", "true");
                    json.addProperty("stadium", stadium(request, response, account, matchId));
                    List<Ticket> ticketInCart = new TicketDAO().getTicketInCartByMatchAndAccount(account, matchId);
                    json.addProperty("total", total(ticketInCart));
                    response.getWriter().write(gson.toJson(json));
                    break;
                default:
                    break;
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private int addToCart(Account account, int seatId) throws IOException {
        Seat seat = SeatDAO.INSTANCE.getSeatById(seatId);
        if (seat == null) {
            return 0;
        }
        Match match = MatchDAO.INSTANCE.getMatch(seat.getMatchId());
        if (match == null) {
            return 0;
        }
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        TicketDAO ticketDAO = new TicketDAO();
        if (match.schedule.after(new java.util.Date())) {
            int accountId = account.getAccountId();
            int cartId = 0;
            if (AccountDAO.INSTANCE.getCartIdByAccountId(accountId) > 0) {
                cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
            } else {
                AccountDAO.INSTANCE.createCart(accountId);
                cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
            }
            List<Ticket> ticketInCart = new TicketDAO().getTicketInCart(accountId);
            List<Ticket> paidTickets = new TicketDAO().getPaidTicket();
            //Hash map of paid seat id
            Map<Integer, Integer> paidSeatIds = new HashMap<>();
            for (Ticket ticket : paidTickets) {
                paidSeatIds.put(ticket.getSeat().getSeatId(), ticket.getSeat().getSeatId());
            }
            //Hash map of in cart seat id
            Map<Integer, Integer> inCartSeatIds = new HashMap<>();
            for (Ticket ticket : ticketInCart) {
                inCartSeatIds.put(ticket.getSeat().getSeatId(), ticket.getSeat().getSeatId());
            }
            if (paidSeatIds.containsKey(seatId)) {
                return -1;
            }
            Ticket ticket = new Ticket();
            ticket.setCode(null);
            ticket.setDate(match.schedule);
            ticket.setSeat(seat);
            ticket.setCartId(cartId);
            ticket.setMatch(match);
            if (!inCartSeatIds.containsKey(ticket.getSeat().getSeatId())) {
                ticket.setTicketId(ticketDAO.addToCart(ticket));
            }
            return ticket.getTicketId();
        } else {
            return -2;
        }
    }

    private List<Seat> getSeatListWithAccount(Account account, int matchId) {
        List<Seat> seatList = MatchDAO.INSTANCE.getSeatOfMatch(matchId);
        List<Ticket> ticketInCart = new TicketDAO().getTicketInCartByMatchAndAccount(account, matchId);
        //Hash map of in cart seat id
        Map<Integer, Integer> inCartSeatIds = new HashMap<>();
        for (Ticket ticket : ticketInCart) {
            inCartSeatIds.put(ticket.getSeat().getSeatId(), ticket.getSeat().getSeatId());
        }
        for (Seat seat : seatList) {
            if (inCartSeatIds.containsKey(seat.getSeatId())) {
                seat.setSeatStatusId(5);
            }
        }
        return seatList;
    }

    private List<Seat> getSeatsDLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 141) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 132) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 131) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsBRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 121) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsALO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 112) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsARO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for (Seat seat : seatList) {
            if (seat.getArea().id == 111) {
                seats.add(seat);
            }
        }
        return seats;
    }

    private String stadium(HttpServletRequest request, HttpServletResponse response, Account account, int matchId) {
        List<Seat> seatList = getSeatListWithAccount(account, matchId);
        List<Seat> seatsARO = getSeatsARO(seatList);
        List<Seat> seatsALO = getSeatsALO(seatList);
        List<Seat> seatsBRO = getSeatsBRO(seatList);
        List<Seat> seatsCRO = getSeatsCRO(seatList);
        List<Seat> seatsCLO = getSeatsCLO(seatList);
        List<Seat> seatsDLO = getSeatsDLO(seatList);
        StringBuilder stadium = new StringBuilder();
        stadium.append(
                "                <img src=\"" + request.getContextPath() + "/img/StadiumV1.png\" alt=\"stadium\">\n" +
                        "                <div class=\"top__side__outler\">\n" +
                        "                    <div class=\"area__ARO\">");
        for (Seat seat : seatsARO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                    <div class=\"area__ALO\">");
        for (Seat seat : seatsALO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"down__side__outler\">\n" +
                "                    <div class=\"area__CRO\">");
        for (Seat seat : seatsCRO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                    <div class=\"area__CLO\">");
        for (Seat seat : seatsCLO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"left__side__outler\">\n" +
                "                    <div class=\"area__DLO\">");
        for (Seat seat : seatsDLO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"right__side__outler\">\n" +
                "                    <div class=\"area__BRO\">");
        for (Seat seat : seatsBRO) {
            if (seat.getSeatStatusId() == 1) {
                stadium.append("<a onclick=\"showConfirm('" + seat.getArea().areaName + "', " + seat.getSeatId() + ", " + seat.getSeatNumber() + ", " + seat.getRow() + ", " + seat.getPrice() + ")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-" + seat.getSeatId() + "\"></i></div>\n" +
                        "                                </a>\n");
            } else if (seat.getSeatStatusId() == 3) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            } else if (seat.getSeatStatusId() == 5) {
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #aaff00; cursor: default\" id=\"seat-" + seat.getSeatId() + "\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "\n" +
                "                <div class=\"top__side__inner\">");
        return stadium.toString();
    }

    public String ticket(Ticket ticket){
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        formatter.setMaximumFractionDigits(0);

        return "<div class=\"item\" onmouseover=\"hover("+ticket.getSeat().getSeatId()+")\" onmouseout=\"removeHover("+ticket.getSeat().getSeatId()+")\" id=\"item-"+ticket.getTicketId()+"\">\n" +
                "                            <div>\n" +
                "                                <div class=\"area\">Area: "+ticket.getSeat().getArea().areaName+"</div>\n" +
                "                                <div class=\"row\">Row: "+ticket.getSeat().getRow()+"</div>\n" +
                "                                <div class=\"seat\">Seat: "+ticket.getSeat().getSeatNumber()+"</div>\n" +
                "                            </div>\n" +
                "                            <div class=\"price\">\n" +
                "                                <div>\n" +
                "                                    Price: "+formatter.format(ticket.getSeat().getPrice())+" VNĐ\n" +
                "                                </div>\n" +
                "                                <i class=\"ri-delete-bin-6-line\" style=\"color: #ff4f51; font-size: large; padding-left: 5px; cursor: pointer\" onclick=\"removeTicket("+ticket.getTicketId()+","+ticket.getSeat().getSeatId()+","+ticket.getMatch().matchId+")\"></i>\n" +
                "                            </div>\n" +
                "                        </div>";
    }

    public double total(List<Ticket> tickets){
        double total = 0;
        for (Ticket ticket : tickets) {
            total += ticket.getSeat().getPrice();
        }
        return total;
    }

}
