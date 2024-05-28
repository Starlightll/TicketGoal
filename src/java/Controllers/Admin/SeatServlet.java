/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import Models.Seat;
import DAO.SeatDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class SeatServlet extends HttpServlet {

    private static final SeatDAO seatDAO = new SeatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get all seats
        List<Seat> listSeats = seatDAO.findAll();
        //set to request
        request.setAttribute("listSeats", listSeats);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get action
        String action = request.getParameter("action") == null
                ? "default"
                : request.getParameter("action");
        switch (action) {
            case "add":
                addSeat(request);
                response.sendRedirect("pitchManagement?option=update");
                break;
            case "edit":
                editSeat(request);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void addSeat(HttpServletRequest request) {
        //get information seatNumber, price, areaId, seatStatusId
        try {
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));

            Seat seat = new Seat();
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setAreaId(areaId);
            seat.setSeatStatusId(seatStatusId);

            //add to database
            seatDAO.insert(seat);

        } catch (Exception e) {

        }
    }

    private void editSeat(HttpServletRequest request) {
        try {
            int seatId = Integer.parseInt(request.getParameter("seatId"));
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));

            Seat seat = new Seat();
            seat.setSeatId(seatId);
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setAreaId(areaId);
            seat.setSeatStatusId(seatStatusId);

            //edit database
            seatDAO.edit(seat);
        } catch (Exception e) {
        }
    }

}
