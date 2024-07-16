package Controllers.Admin.dashboard;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "dashboard", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("dashboard", "style=\"background-color: #00C767; pointer-events: none;\"");
        request.setAttribute("page", "/Views/Admin/Dashboard/Dashboard.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
