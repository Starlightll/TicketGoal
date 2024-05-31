/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Account;

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
@WebServlet(name = "changePasswordServlet", urlPatterns = {"/changePassword"})
public class changePasswordServlet extends HttpServlet {

    private final AccountDAO accDAO = new AccountDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPass = request.getParameter("oldPass").trim();
        String newPass = request.getParameter("newPass").trim();

        Account user = (Account) request.getSession().getAttribute("user");
        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println(user);
        System.out.println(oldPass + newPass);
        if (user == null) {
            jsonResponse = new Common.JsonResponse(false, "Unauthorized");
            System.out.println("Unauthorized");
            String json = gson.toJson(jsonResponse);
            response.getWriter().write(json);
            return;
        }
        if (!user.getPassword().equals(oldPass)) {
            jsonResponse = new Common.JsonResponse(false, "Old password wrong");
            System.out.println("Old password wrong");
            String json = gson.toJson(jsonResponse);
            response.getWriter().write(json);
            return;
        }
        System.out.println("update");
        Account updatedUser = accDAO.updateUserById(
                new Account(user.getAccountId(),
                        null,
                        newPass,
                        user.getEmail(),
                        null,
                        null,
                        null,
                        -1,
                        -1));
        System.out.println(updatedUser);
        if (updatedUser != null) {
            request.getSession().setAttribute("user", updatedUser);
            jsonResponse = new Common.JsonResponse(true, "Update successful");
        } else {
            jsonResponse = new Common.JsonResponse(false, "Update fail");
        }

        String json = gson.toJson(jsonResponse);
        response.getWriter().write(json);

    }
}
