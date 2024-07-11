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
 * @author mosdd
 */
@MultipartConfig(maxFileSize = 16177215)
public class addPitchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
            out.println("<title>Servlet addPitchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addPitchServlet at " + request.getContextPath() + "</h1>");
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
        PitchDAO pitchDAO = PitchDAO.INSTANCE;
        String pitchName = request.getParameter("pitchName");
        String pitchAddress = request.getParameter("pitchAddressName");
        String pitchAddressURL = request.getParameter("pitchAddressURL");

        boolean wrongFormat = false;
        if (pitchName == null || pitchName.trim().isEmpty()) {
            request.setAttribute("nameError", "Name cannot be empty or whitespace");
            wrongFormat = true;
        } else {
            request.setAttribute("pitchName", pitchName);
        }
        if (pitchAddress == null || pitchAddress.trim().isEmpty()) {
            request.setAttribute("addressError", "Address cannot be empty or whitespace");
            wrongFormat = true;
        } else {
            request.setAttribute("addressName", pitchAddress);
        }
        if (pitchAddressURL == null || pitchAddressURL.trim().isEmpty()) {
            request.setAttribute("addressURLError", "Address URL cannot be empty or whitespace");
            wrongFormat = true;
        } else {
            request.setAttribute("addressURL", pitchAddressURL);
        }

        InputStream pitchImageStream = null;
        InputStream pitchStructureStream = null;

        //Store image data
        Part pitchImage = request.getPart("pitchImage");
        if (pitchImage != null) {
            pitchImageStream = pitchImage.getInputStream();
        } else {
            request.setAttribute("pitchImageError", "Pitch Image cannot be empty");
            wrongFormat = true;
        }

        //Store structure data
        Part pitchStructure = request.getPart("pitchStructure");
        if (pitchStructure != null) {
            pitchStructureStream = pitchStructure.getInputStream();
        }

        if (wrongFormat) {
            request.setAttribute("page", "/Views/Admin/Pitch/AddPitch.jsp");
            //set css
            request.setAttribute("dropdownMenu", "block");
            request.setAttribute("pitchManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");
            request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
        } else {
            int pitchId = pitchDAO.addPitch(pitchName, pitchAddress, pitchAddressURL, pitchStructureStream, pitchImageStream);
            if (pitchId != -1) {
                request.setAttribute("msg", "Added successfully with pitch name: " + pitchName);
            } else {
                request.setAttribute("msg", "Failed to add pitch");
            }
            response.sendRedirect(request.getContextPath() + "/pitchManagementServlet");
        }

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
