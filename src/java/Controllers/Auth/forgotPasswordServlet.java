/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Auth;

import DAO.AccountDAO;
import Utils.EmailSender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author MSI VN
 */
@WebServlet(name = "forgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class forgotPasswordServlet extends HttpServlet {

    private final EmailSender emailSender = new EmailSender();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email != null) {
            emailSender.sendEmailForgotPassword(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Auth/ForgotPassword.jsp").forward(request, response);
//        doPost(request, response);
    }

}
