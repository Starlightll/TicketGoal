/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Ticket;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import DAO.SeatDAO;
import Models.Seat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BuyTicketServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuyTicketServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


}
