/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.PitchManagement;

import DAO.AreaDAO;
import DAO.PitchDAO;
import DAO.SeatDAO;
import DAO.SeatStatusDAO;
import Models.Area;
import Models.Pitch;
import Models.Seat;
import Models.SeatStatus;
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
public class pitchManagementServlet extends HttpServlet {

    private static final PitchDAO pitchDAO = PitchDAO.INSTANCE;
    private static final AreaDAO areaDAO = AreaDAO.INSTANCE;
    private static final SeatStatusDAO seatStatusDAO = SeatStatusDAO.INSTANCE;

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
            out.println("<title>Servlet pitchManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet pitchManagementServlet at " + request.getContextPath() + "</h1>");
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
        String option = request.getParameter("option") == null ? "dafault" : request.getParameter("option");
        switch (option) {
            case "add":
                request.setAttribute("page", "/Views/Admin/Pitch/AddPitch.jsp");
                break;
            case "update":
                String pitchId = request.getParameter("pitchId");
                Pitch pitch = pitchDAO.getPitch(pitchId);
                SeatDAO seatDao = SeatDAO.INSTANCE;
                request.setAttribute("pitch", pitch);
                System.out.println(pitchId);
                List<Area> areaList = areaDAO.getAllArea(pitchId);
                request.setAttribute("AreaList", areaList);
                int idSeat = 0;
                try {
                    idSeat = Integer.parseInt(request.getParameter("areaId"));
                } catch (Exception e) {
                    System.out.println("Can not areaId");
                }
                List<Seat> seatList = seatDao.findAllByAreaId(idSeat);
                List<SeatStatus> listStatus = seatStatusDAO.getSeatStatusList();
                request.setAttribute("seatStatus", listStatus);
                request.setAttribute("seatList", seatList);
                request.setAttribute("page", "/Views/Admin/Pitch/UpdatePitch.jsp");
                break;
            case "delete":
                pitchDAO.deletePitch(request.getParameter("pitchId"));
                request.setAttribute("page", "/Views/Admin/Pitch/PitchManagement.jsp");
                break;
            case "dafault":
                request.setAttribute("page", "/Views/Admin/Pitch/PitchManagement.jsp");
                break;
            default:
                throw new AssertionError();
        }
        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("pitchManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");
        List<Pitch> pitchList = pitchDAO.getPitchList();
        request.setAttribute("pitchList", pitchList);
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
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
