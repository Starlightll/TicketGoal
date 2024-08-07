/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Admin.PitchManagement;

import DAO.PitchDAO;
import Models.Pitch;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author mosdd
 */
public class SearchPitchServlet extends HttpServlet {
    PitchDAO pitchDAO = PitchDAO.INSTANCE;

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
        PrintWriter out = response.getWriter();
        String searchValue = request.getParameter("searchValue");
        List<Pitch> pitchList = pitchDAO.searchPitch(searchValue);
        for (Pitch pitchs : pitchList) {
            out.print("<div class=\"pitch\">\n" +
                    "                        <img name=\"pitchImage\" src=\"data:image/jpeg;base64," + pitchs.image + "\"/>\n" +
                    "                        <div class=\"pitch__manager__option\">\n" +
                    "                            <button class=\"update__button\" onclick=\"location.href = '" + request.getContextPath() + "/pitchManagementServlet?option=update&pitchId=" + pitchs.pitchId + "'\">Update</button>\n" +
                    "                            <button class=\"delete__button\" onclick=\"location.href = '" + request.getContextPath() + "/pitchManagementServlet?option=delete&pitchId=" + pitchs.pitchId + "'\">Delete</button>\n" +
                    "                        </div>\n" +
                    "                        <div class=\"pitch__name\">\n" +
                    "                            <p>" + pitchs.pitchName + "</p>\n" +
                    "                            </div>\n" +
                    "                        </div>");
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
