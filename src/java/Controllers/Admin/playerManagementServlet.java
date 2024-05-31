/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import DAO.PlayerDAO;
import Models.Player;
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
public class playerManagementServlet extends HttpServlet {

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
    private void setListPlayer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PlayerDAO p = new PlayerDAO();
        List<Player> list = p.getAllPlayer();
        request.setAttribute("listP", list);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PlayerDAO p = new PlayerDAO();
        try {
            String option = request.getParameter("option");
            if (option.equalsIgnoreCase("update")) {
                Player player = p.getPlayer(request.getParameter("playerId"));
                
                request.setAttribute("Player", player);
                request.setAttribute("page", "/Views/Admin/Player/UpdatePlayer.jsp");
            }else if(option.equalsIgnoreCase("playerdetail")){
                Player player = p.getPlayer(request.getParameter("playerId"));
                request.setAttribute("Player", player);
                request.setAttribute("page", "/Views/Admin/Player/AdminDetailPlayer.jsp");
            }           
            else if (option.equalsIgnoreCase("add")) {
                request.setAttribute("page", "/Views/Admin/Player/AddPlayer.jsp");
            } else if (option.equalsIgnoreCase("delete")) {
                String idPlayer = request.getParameter("playerId");
                p.deletePlayer(idPlayer);
                request.setAttribute("page", "/Views/Admin/Player/PlayerManagement.jsp");
            }
        } catch (NullPointerException e) {
            request.setAttribute("page", "/Views/Admin/Player/PlayerManagement.jsp");
        }
        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("playerManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");
        setListPlayer(request, response);
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
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
