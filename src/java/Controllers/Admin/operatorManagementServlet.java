package Controllers.Admin;

import DAO.AccountDAO;
import DAO.AccountStatusDAO;
import DAO.RoleDAO;
import Models.Account;
import Models.AccountStatus;
import Models.Role;
import Utils.Common;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "operatorManagementServlet", urlPatterns = {"/operatorManagementServlet"})
public class operatorManagementServlet extends HttpServlet {

    private final AccountDAO accDAO = AccountDAO.INSTANCE;
    private final RoleDAO roleDAO = new RoleDAO();
    private final AccountStatusDAO accountstatusDAO = new AccountStatusDAO();
    private final int operatorRole = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Account> listOperater = accDAO.getAccountByRole(operatorRole);
        List<Role> listRole = roleDAO.getAllRole();
        List<AccountStatus> listAccountStatus = accountstatusDAO.getAllAccountStatus();

        request.setAttribute("operators", listOperater);
        request.setAttribute("listRole", listRole);
        request.setAttribute("listAccountStatus", listAccountStatus);
        String operatorsAsJson = new Gson().toJson(listOperater);

        request.setAttribute("operatorsAsJson", operatorsAsJson);
        request.setAttribute("listRoleJson", new Gson().toJson(listRole));
        request.setAttribute("listAccountStatusson", new Gson().toJson(listAccountStatus));
        
        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("operatorManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");
        
        request.setAttribute("page", "/Views/Admin/Operator/OperatorList.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        if (type != null) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            String address = request.getParameter("address");

            switch (type) {
                case "create":
                    Account newAcc = accDAO.createNewAccount(new Account(0, username, phone, email, phone, Integer.parseInt(gender),
                            address, Integer.parseInt(role), Integer.parseInt(status)));
                    jsonResponse = new Common.JsonResponse(true, "Create successful", newAcc);
                    break;

                case "update":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Account acc = accDAO.updateUserById(new Account(id, username, null, null,
                            phone, Integer.parseInt(gender), address, Integer.parseInt(role),
                            Integer.parseInt(status)));
                    jsonResponse = new Common.JsonResponse(true, "Update successful", acc);
                    break;

                default:
                    jsonResponse = new Common.JsonResponse(false, "Not Valid Type");

                    throw new AssertionError();
            }
        } else {
            jsonResponse = new Common.JsonResponse(false, "Something's Wrong");
        }
        String json = gson.toJson(jsonResponse);
        response.getWriter().write(json);
    }

}
