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
@WebServlet(name = "signUpServlet", urlPatterns = {"/signUp"})
public class signUpServlet extends HttpServlet {

    private final AccountDAO accDAO = AccountDAO.INSTANCE;
    private final int customerRole = 2;
    private final int enableStatus = 1;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String rePassword = request.getParameter("rePassword").trim();

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;
        System.out.println(password + rePassword);
        if (!password.equals(rePassword)) {
            jsonResponse = new Common.JsonResponse(false, "password is not the same as rePassword");
            String json = gson.toJson(jsonResponse);
            response.getWriter().write(json);
            return;
        }

        Account newAcc = accDAO.createNewAccount(
                new Account(0, "user", password, email, null, null, null, customerRole, enableStatus));
        System.out.println(newAcc);
        if (newAcc != null) {
            jsonResponse = new Common.JsonResponse(true, "Create new account success", newAcc);
        } else {
            jsonResponse = new Common.JsonResponse(false, "Something's wrong");
        }
        String json = gson.toJson(jsonResponse);
        response.getWriter().write(json);
    }

}
