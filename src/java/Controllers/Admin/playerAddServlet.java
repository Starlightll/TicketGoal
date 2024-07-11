/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Admin;

import DAO.PlayerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 * @author pc
 */
@MultipartConfig(maxFileSize = 16177215)
public class playerAddServlet extends HttpServlet {

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
            out.println("<title>Servlet playerAddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet playerAddServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String playerName = request.getParameter("playerName");
        String playerNumber = request.getParameter("playerNumber");
        String dateOfBirth = request.getParameter("playerBirth");
        String height = request.getParameter("playerHeight");
        String weight = request.getParameter("playerWeight");
        String biography = request.getParameter("playerBio");
        String countryId = request.getParameter("playerCountry");
        String playerRoleId = request.getParameter("playerRoleId");

        //Get player image InputStream
        InputStream playerImageInputStream = null;
        Part playerImage = request.getPart("playerImage");
        if (playerImage != null) {
            playerImageInputStream = playerImage.getInputStream();
        }

        String atk = request.getParameter("ATK");
        String def = request.getParameter("DEF");
        String spd = request.getParameter("SPD");
        PlayerDAO pl = new PlayerDAO();
        pl.addPlayer(playerName, playerNumber, dateOfBirth, height, weight, biography, playerImageInputStream, countryId, playerRoleId, atk, def, spd);
        response.sendRedirect("playerManagementServlet");
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

}
