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

    private final AccountDAO accDAO = AccountDAO.INSTANCE;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //handle change password when user forgot
        String type = request.getParameter("type");
        if ("forgotToChange".equals(type)) {
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");

            request.setAttribute("email", email);
            //Update user password
            if (newPassword == null || newPassword.length() < 8) {
                request.setAttribute("message", "Password must be at least 8 characters long.");
            } else {
                Account updatedAcc = accDAO.updateUserByEmail(new Account(email, newPassword, -1, -1));
                if (updatedAcc == null) {
                    request.setAttribute("message", "Incorrect Email, Please try again !!");
                } else {
                    request.setAttribute("message", "Password updated successfull !!.Click sign in to continue");
                }
            }
            request.setAttribute("email", email);
            request.getRequestDispatcher("/Views/Auth/ForgotPassword.jsp").forward(request, response);
            return;
        }

        //hanle change password when user change in profile
        String oldPass = request.getParameter("oldPass").trim();
        String newPass = request.getParameter("newPass").trim();

        Account user = (Account) request.getSession().getAttribute("user");
        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
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
