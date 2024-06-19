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
@WebServlet(name = "changeProfileServlet", urlPatterns = {"/changeProfile"})
public class changeProfileServlet extends HttpServlet {

    private final AccountDAO accDAO = AccountDAO.INSTANCE;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int gender = Integer.parseInt(request.getParameter("gender"));

        Account user = (Account) request.getSession().getAttribute("user");
        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;
        
        if (user != null) {
            Account updatedUser = accDAO.updateUserById(
                    new Account(user.getAccountId(),
                            username.trim(),
                            null,
                            email.trim(),
                            phone.trim(),
                            gender,
                            address.trim(),
                            -1,
                            -1));
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            if (updatedUser != null) {
                request.getSession().setAttribute("user", updatedUser);
                jsonResponse = new Common.JsonResponse(true, "Update successful");
            } else {
                jsonResponse = new Common.JsonResponse(false, "Update fail");
            }
        } else {
            jsonResponse = new Common.JsonResponse(false, "Unauthorized");
        }

        String json = gson.toJson(jsonResponse);
        response.getWriter().write(json);
    }

}
