/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.PitchManagement;

import DAO.PitchDAO;
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
 *
 * @author mosdd
 */
@MultipartConfig(maxFileSize = 16177215)
public class updatePitchServlet extends HttpServlet {
    private static final PitchDAO pitchDAO = PitchDAO.INSTANCE;
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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updatePitchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updatePitchServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String pitchId = request.getParameter("pitchId");
        String pitchName = request.getParameter("pitchName");
        String pitchAddress = request.getParameter("pitchAddressName");
        String pitchAddressURL = request.getParameter("pitchAddressURL");
        
        //Store image data
//        Part pitchImage = request.getPart("pitchImage");
//        if (pitchImage != null) {
//            pitchImageStream = pitchImage.getInputStream();
//        }

        //Store image data
        Part newPitchImagePart = request.getPart("newPitchImage");
        InputStream newPitchImage = (newPitchImagePart != null && newPitchImagePart.getSize() > 0) ? newPitchImagePart.getInputStream() : null;

        String existingImage = request.getParameter("existingImage");

        //Store structure data
        Part newPitchStructurePart = request.getPart("newPitchImage");
        InputStream newPitchStructure = (newPitchStructurePart != null && newPitchStructurePart.getSize() > 0) ? newPitchStructurePart.getInputStream() : null;

        String existingStructure = request.getParameter("existingStructure");

        pitchDAO.updatePitch(pitchId, pitchName, pitchAddress, pitchAddressURL, newPitchStructure, existingStructure, newPitchImage, existingImage);
        response.sendRedirect(request.getContextPath()+"/pitchManagementServlet");
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
