/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.Admin;

import DAO.PitchDAO;
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
public class pitchManagementServlet extends HttpServlet {
   
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
            out.println("<title>Servlet pitchManagementServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet pitchManagementServlet at " + request.getContextPath () + "</h1>");
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
        PitchDAO pitchDAO = PitchDAO.INSTANCE;
        try{
            String option = request.getParameter("option");
            if(option.equalsIgnoreCase("update")){
                String pitchId = request.getParameter("pitchId");
                Pitch pitch = pitchDAO.getPitch(pitchId);
                request.setAttribute("pitchId", pitch.getPitchId());
                request.setAttribute("pitchName", pitch.getPitchName());
                request.setAttribute("pitchAddressName", pitch.getAddressName());
                request.setAttribute("pitchAddressURL", pitch.getAddressURL());
                request.setAttribute("pitchStructure", pitch.getPitchStructure());
                request.setAttribute("pitchImage", pitch.getImage());
                request.setAttribute("page", "/Views/Admin/Pitch/UpdatePitch.jsp");
            } else if (option.equalsIgnoreCase("add")){
                request.setAttribute("page", "/Views/Admin/Pitch/AddPitch.jsp");
            } else if (option.equalsIgnoreCase("delete")) {
                pitchDAO.deletePitch(request.getParameter("pitchId"));
                request.setAttribute("page", "/Views/Admin/Pitch/PitchManagement.jsp");
            } else {
                request.setAttribute("page", "/Views/Admin/Pitch/PitchManagement.jsp");
            }
        }catch(Exception e){
            request.setAttribute("page", "/Views/Admin/Pitch/PitchManagement.jsp");
        }
        String pitchName = "";
        List<Pitch> pitchList = PitchDAO.INSTANCE.getPitchList();
        request.setAttribute("pitchList", pitchList);
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
