/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Auth;

import DAO.AccountDAO;
import Models.Account;
import Utils.Common;
import com.google.gson.Gson;
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
@WebServlet(name = "signInServlet", urlPatterns = {"/signIn"})
public class signInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.signIn(email.toLowerCase(), password);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        if (account != null) {
            request.getSession().setAttribute("user", account);
            jsonResponse = new Common.JsonResponse(true, "Login successful");
        } else {
            jsonResponse = new Common.JsonResponse(false, "Invalid email or password");
        }

        String json = gson.toJson(jsonResponse);
        response.getWriter().write(json);
    }

  

}
