/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.PitchManagement;

import DAO.AreaDAO;
import Models.Area;
import Models.Pitch;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author mosdd
 */
public class AreaServlet extends HttpServlet {

    private static final AreaDAO areaDao = AreaDAO.INSTANCE;
    boolean status = false;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            List<Area> areaList = areaDao.getAllArea(request.getParameter("pitchId"));
            for (Area area : areaList) {
                out.println("<div class=\"area\"><input style=\"display: none\"id=\"areaId\" value=\""+area.id+"\">"+"\n"
                        + "                            <p class=\"area__name\">\n"
                        + "                                " + area.areaName + "\n"
                        + "                            </p>\n"
                        + "                            <div class=\"area__management\">\n"
                        + "                                <button type=\"button\" class=\"seat__management\" id=\"seat-management-button\">Seat</button>\n"
                        + "                                <button onclick=\"deleteArea()\" type=\"button\" class=\"delete__button\">Delete</button>\n"
                        + "                            </div>\n"
                        + "                        </div>");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "add":
                String areaName = request.getParameter("areaName");
                String pitchId = request.getParameter("pitchId");
                status = areaDao.addArea(areaName, pitchId);
                break;
            case "delete":
                String areaId = request.getParameter("areaId");
                areaDao.deleteArea(areaId);
                break;
            default:
                throw new AssertionError();
        }
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

}
