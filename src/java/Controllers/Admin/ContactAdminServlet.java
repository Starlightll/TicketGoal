/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin;

import DAO.ContactDAO;
import DAO.MessageDAO;
import Models.Contact;
import Models.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author pc
 */
public class ContactAdminServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ContactAdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ContactAdminServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pagenum = 1;
        String page = request.getParameter("pagenum");
        if (page != null) {
            pagenum = Integer.parseInt(page);
        }
        String cate = request.getParameter("cate");
        String search = request.getParameter("search");
        request.setAttribute("search", search);
        if ("2".equals(cate)) {
            MessageDAO messageDAO = new MessageDAO();
            List<Message> messages = messageDAO.getMessages();
            if (search != null && !search.trim().isEmpty()) {
                messages = messages.stream().filter(n -> n.getEmail().equalsIgnoreCase(search.trim())).toList();
            }
            int totalPage = messages.size() % 5 == 0 ? messages.size() / 5 : (messages.size() / 5 + 1);
            if (!messages.isEmpty()) {
                request.setAttribute("list", messages.subList((pagenum - 1) * 5, Math.min(messages.size(), pagenum * 5)));
            } else {
                request.setAttribute("list", messages);
            }
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("pagenum", pagenum);
            request.setAttribute("page", "/Views/Admin/Contacts/AdminSent.jsp");
            request.setAttribute("category", "2");
            if (cate != null) {
                request.setAttribute("category", cate);
            } else {
                request.setAttribute("category", "1");
            }
            String url = "ContactAdminServlet?temp=abc";
            if (cate != null && !cate.trim().isEmpty()) {
                url += "&cate=" + cate;
            }
            if (search != null && !search.trim().isEmpty()) {
                url += "&search=" + search;
            }
            request.setAttribute("url", url);
            request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
            return;
        }
        ContactDAO contactDAO = new ContactDAO();
        List<Contact> list = contactDAO.getContactList(cate);
        if (search != null && !search.trim().isEmpty()) {
            list = list.stream().filter(n -> n.getEmail().equalsIgnoreCase(search.trim())).toList();
        }
        int totalPage = list.size() % 5 == 0 ? list.size() / 5 : (list.size() / 5 + 1);
        if (!list.isEmpty()) {
            request.setAttribute("list", list.subList((pagenum - 1) * 5, Math.min(list.size(), pagenum * 5)));
        } else {
            request.setAttribute("list", list);
        }
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("pagenum", pagenum);
        if (cate != null) {
            request.setAttribute("category", cate);
        } else {
            request.setAttribute("category", "1");
        }
        String url = "ContactAdminServlet?temp=abc";
        if (cate != null && !cate.trim().isEmpty()) {
            url += "&cate=" + cate;
        }
        if (search != null && !search.trim().isEmpty()) {
            url += "&search=" + search;
        }
        request.setAttribute("url", url);
        request.setAttribute("page", "/Views/Admin/Contacts/AdminContact.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
