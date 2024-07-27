/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DAO.ClubDAO;
import Models.Address;
import Models.Club;
import Models.Match;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Date;
import java.util.List;

/**
 * @author mosdd
 */
public class matchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet matchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet matchServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get all matches
        List<Match> matchList = getMatches();

        //set active
        request.setAttribute("matchActive", "active");
        request.setAttribute("matches", matchList);
        request.getRequestDispatcher("/Views/Matches.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


    public List<Match> getMatches() {
        ResultSet matches = DAO.MatchDAO.INSTANCE.getMatches();
        List<Match> matchList = new java.util.ArrayList<>();
        try {
            while (matches.next()) {
                Match match = new Match();
                match.setMatchId(matches.getInt("matchId"));
                match.setMatchTitle(matches.getString("matchTitle"));
                match.setSchedule(new Date(matches.getTimestamp("schedule").getTime()));
                match.setPitchId(matches.getInt("pitchId"));
                match.setMatchStatusId(matches.getInt("matchStatusId"));
                //Get club1 and club2
                Club club1 = ClubDAO.INSTANCE.getClub(matches.getInt("club1"));
                match.setClub1(club1);
                Club club2 = ClubDAO.INSTANCE.getClub(matches.getInt("club2"));
                match.setClub2(club2);
                //Get address
                Address address = new Address();
                address.setAddressName(matches.getString("addressName"));
                address.setAddressURL(matches.getString("addressURL"));
                match.setAddress(address);
                matchList.add(match);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return matchList;
    }
}
