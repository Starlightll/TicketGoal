/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Ticket;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import DAO.AccountDAO;
import DAO.MatchDAO;
import DAO.SeatDAO;
import DAO.TicketDAO;
import Models.Match;
import Models.Seat;
import Models.Ticket;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.Account;

/**
 *
 * @author mosdd
 */
@WebServlet(name="BuyTicketServlet", urlPatterns={"/BuyTicket"})
public class BuyTicketServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           out.println("loginRequired");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
            List<Seat> seatList = SeatDAO.INSTANCE.getAllSeatOfMatch(matchId);
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
        if(account == null){
            processRequest(request, response);
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
        String[] seatIds = new ObjectMapper().readValue(request.getParameter("seatIds"), String[].class);
        int matchId = Integer.parseInt(request.getParameter("matchId"));
        Match match = MatchDAO.INSTANCE.getMatch(matchId);
        TicketDAO ticketDAO = new TicketDAO();
        int accountId = account.getAccountId();
        int cartId = 0;
        if(AccountDAO.INSTANCE.getCartIdByAccountId(accountId) > 0){
            cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
        }else{
            AccountDAO.INSTANCE.createCart(accountId);
            cartId = AccountDAO.INSTANCE.getCartIdByAccountId(accountId);
        }
        if(seatIds != null){
            for(String seatId : seatIds){
                Ticket ticket = new Ticket();
                ticket.setCode(null);
                ticket.setDate(match.schedule);
                ticket.setSeatId(Integer.parseInt(seatId));
                ticket.setCartId(cartId);
                ticket.setMatchId(matchId);
                if(ticketStatus == 1) {
                    ticketDAO.buyTicket(ticket);
                }else if(ticketStatus == 2){
                    ticket.setTicketStatusId(2);
                    List<Ticket> ticketInCart = new TicketDAO().selectTicketsByAccountId(accountId);
                    if(!ticketInCart.contains(ticket)){
                        ticketDAO.addToCart(ticket);
                    }
                }
            }
            return true;
        }
        return false;
    }

    private List<Seat> getSeatsDLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 141){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCLO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 132){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsCRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 131){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsBRO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 121){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsALO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 112){
                seats.add(seat);
            }
        }
        return seats;
    }

    private List<Seat> getSeatsARO(List<Seat> seatList) {
        List<Seat> seats = new ArrayList<Seat>();
        for(Seat seat : seatList){
            if(seat.getAreaId() == 111){
                seats.add(seat);
            }
        }
        return seats;
    }

}
