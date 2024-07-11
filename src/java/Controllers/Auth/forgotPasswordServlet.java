package Controllers.Auth;

import Utils.EmailSender;
import Utils.JwtUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
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
        String token = request.getParameter("token");
        if (token != null) {
            try {
                String userEmail = JwtUtil.getUserIdFromToken(token);
                request.setAttribute("email", userEmail);
            } catch (Exception e) {
                response.sendRedirect("./");
                return;
            }
        }

        request.getRequestDispatcher("/Views/Auth/ForgotPassword.jsp").forward(request, response);
//        doPost(request, response);
    }

}
