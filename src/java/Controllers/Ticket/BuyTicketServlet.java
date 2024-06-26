/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Ticket;

import DAO.AccountDAO;
import DAO.MatchDAO;
import DAO.SeatDAO;
import DAO.TicketDAO;
import Models.Account;
import Models.Match;
import Models.Seat;
import Models.Ticket;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 *
 * @author mosdd
 */
@WebServlet(name="BuyTicketServlet", urlPatterns={"/BuyTicket"})
public class BuyTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        if(account == null){
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("loginRequired");
            request.setAttribute("showLogin", "show-login");
            request.getRequestDispatcher("matchServlet").forward(request, response);
        }else{
            int matchId = 0;
            try{
                matchId = Integer.parseInt(request.getParameter("matchId"));
            }catch(Exception e){
                System.out.println("Error: " + e);
            }
            Match match = MatchDAO.INSTANCE.getMatch(matchId);
            if(match.matchStatusId != 2){
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
            request.getRequestDispatcher("/Views/Ticket/BuyTicket.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        if(account == null){
            json.addProperty("loginRequired", "true");
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(json));
        }else{
            String action = request.getParameter("action");
            switch (action) {
                case "buyTicket":
                    addTicket(account, 1,request, response);
                    break;
                case "addToCart":
                    addTicket(account, 2,request, response);
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

    private boolean addTicket(Account account, int ticketStatus,HttpServletRequest request, HttpServletResponse response) throws IOException{
        int matchId = Integer.parseInt(request.getParameter("matchId"));
        Match match = MatchDAO.INSTANCE.getMatch(matchId);
        com.google.gson.JsonObject json = new com.google.gson.JsonObject();
        if(match.schedule.after(new java.util.Date())){
            String[] seatIds = new ObjectMapper().readValue(request.getParameter("seatIds"), String[].class);
            TicketDAO ticketDAO = new TicketDAO();
            int accountId = account.getAccountId();
            int cartId = 0;
            if(AccountDAO.INSTANCE.getCartIdByAccountId(accountId) > 0){
                cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
            }else{
                AccountDAO.INSTANCE.createCart(accountId);
                cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
            }
            List<Ticket> ticketInCart = new TicketDAO().getTicketInCart(accountId);
            List<Ticket> paidTickets = new TicketDAO().getPaidTicket();
            //Hash map of paid seat id
            Map<Integer, Integer> paidSeatIds = new HashMap<>();
            for(Ticket ticket : paidTickets){
                paidSeatIds.put(ticket.getSeatId(), ticket.getSeatId());
            }
            //Hash map of in cart seat id
            Map<Integer, Integer> inCartSeatIds = new HashMap<>();
            for(Ticket ticket : ticketInCart){
                inCartSeatIds.put(ticket.getSeatId(), ticket.getSeatId());
            }

            if(seatIds != null){
                for(String seatId : seatIds){
                    if(paidSeatIds.containsKey(Integer.parseInt(seatId))){
                        Gson gson = new Gson();
                        json.addProperty("isPurchased", "true");
                        json.addProperty("stadium", stadium(request, response, account, matchId));
                        response.getWriter().write(gson.toJson(json));
                        return false;
                    }
                    Ticket ticket = new Ticket();
                    ticket.setCode(null);
                    ticket.setDate(match.schedule);
                    ticket.setSeatId(Integer.parseInt(seatId));
                    ticket.setCartId(cartId);
                    ticket.setMatchId(matchId);

                    if(ticketStatus == 1) {
                        ticketDAO.buyTicket(ticket);
                    }else if(ticketStatus == 2){
                        if(!inCartSeatIds.containsKey(ticket.getSeatId())){
                            ticketDAO.addToCart(ticket);
                        }
                    }
                }
                Gson gson = new Gson();
                json.addProperty("isSuccess", "true");
                json.addProperty("stadium", stadium(request, response, account, matchId));
                response.getWriter().write(gson.toJson(json));
                return true;
            }
            return false;
        }else{
            Gson gson = new Gson();
            json.addProperty("notAvailable", "true");
            response.getWriter().write(gson.toJson(json));
            return false;
        }
    }

    private List<Seat> getSeatListWithAccount(Account account, int matchId){
        List<Seat> seatList = SeatDAO.INSTANCE.getAllSeatOfMatch(matchId);
        List<Ticket> ticketInCart = new TicketDAO().getTicketInCartByMatchAndAccount(account, matchId);
        List<Ticket> paidTickets = new TicketDAO().getPaidTicketByMatch(matchId);
        //Hash map of paid seat id
        Map<Integer, Integer> paidSeatIds = new HashMap<>();
        for(Ticket ticket : paidTickets){
            paidSeatIds.put(ticket.getSeatId(), ticket.getSeatId());
        }
        //Hash map of in cart seat id
        Map<Integer, Integer> inCartSeatIds = new HashMap<>();
        for(Ticket ticket : ticketInCart){
            inCartSeatIds.put(ticket.getSeatId(), ticket.getSeatId());
        }
        for(Seat seat: seatList){
            if(paidSeatIds.containsKey(seat.getSeatId())){
                seat.setSeatStatusId(3);
            }else if(inCartSeatIds.containsKey(seat.getSeatId())){
                seat.setSeatStatusId(5);
            }
        }
        return seatList;
    }

    private List<Seat> getSeatsDLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 141){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 132){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 131){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsBRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 121){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsALO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 112){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsARO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getArea().id == 111){
                seats.add(seat);
            }
        }
        return seats;
    }

    private String stadium(HttpServletRequest request, HttpServletResponse response, Account account, int matchId){
        List<Seat> seatList = getSeatListWithAccount(account, matchId);
        List<Seat> seatsARO = getSeatsARO(seatList);
        List<Seat> seatsALO = getSeatsALO(seatList);
        List<Seat> seatsBRO = getSeatsBRO(seatList);
        List<Seat> seatsCRO = getSeatsCRO(seatList);
        List<Seat> seatsCLO = getSeatsCLO(seatList);
        List<Seat> seatsDLO = getSeatsDLO(seatList);
        StringBuilder stadium = new StringBuilder();
        stadium.append(
                "            <div>\n" +
                "                <img src=\""+request.getContextPath()+"/img/StadiumV1.png\" alt=\"stadium\">\n" +
                "                <div class=\"top__side__outler\">\n" +
                "                    <div class=\"area__ARO\">");
        for(Seat seat : seatsARO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                    <div class=\"area__ALO\">");
        for(Seat seat : seatsALO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"down__side__outler\">\n" +
                "                    <div class=\"area__CRO\">");
        for(Seat seat : seatsCRO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                    <div class=\"area__CLO\">");
        for(Seat seat : seatsCLO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"left__side__outler\">\n" +
                "                    <div class=\"area__DLO\">");
        for(Seat seat : seatsDLO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "                <div class=\"right__side__outler\">\n" +
                "                    <div class=\"area__BRO\">");
        for(Seat seat : seatsBRO){
            if(seat.getSeatStatusId()==1){
                stadium.append("<a onclick=\"showConfirm('"+seat.getArea().areaName+"', "+seat.getSeatId()+", "+seat.getSeatNumber()+", "+seat.getRow()+", "+seat.getPrice()+")\">\n" +
                        "                                    <div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"\" id=\"seat-"+seat.getSeatId()+"\"></i></div>\n" +
                        "                                </a>\n");
            }else if(seat.getSeatStatusId()==3){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ff4747; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }else if(seat.getSeatStatusId()==5){
                stadium.append("<div class=\"seat\"><i class=\"ri-layout-top-2-fill\" style=\"color: #ffa600; cursor: default\" id=\"seat-"+seat.getSeatId()+"\"></i></div>");
            }
        }
        stadium.append("</div>\n" +
                "                </div>\n" +
                "\n" +
                "                <div class=\"top__side__inner\"></div>\n");
        return stadium.toString();
    }

}
