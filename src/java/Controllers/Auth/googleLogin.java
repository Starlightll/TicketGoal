/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Auth;

import DAO.AccountDAO;
import Models.Account;
import Models.Google;
import Utils.GoogleUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "googleLogin", urlPatterns = {"/googleLogin"})
public class googleLogin extends HttpServlet {

    private final String HOMEPAGE = "Homepage.jsp";
    private AccountDAO accDAO = AccountDAO.INSTANCE;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null) {
            String accessToken = GoogleUtils.getToken(code);
            Google googlePojo = GoogleUtils.getUserInfo(accessToken);
            Account user = accDAO.getAccountByEmail(googlePojo.getEmail());
            handleControlUser(request, response, user);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void handleControlUser(HttpServletRequest request, HttpServletResponse response, Account user) throws ServletException, IOException {
        if (user == null) {
            String message = "Incorrect email or password";
            request.setAttribute("message", message);
            request.getRequestDispatcher(HOMEPAGE).forward(request, response);
            return;
        }

        HttpSession session = (HttpSession) request.getSession();
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(6000);
        
        response.sendRedirect("./homepageServlet");

    }
}
