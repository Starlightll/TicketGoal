/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Account;

import DAO.MatchDAO;
import DAO.TicketDAO;
import Models.Account;
import Models.Match;
import Models.Ticket;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;


@WebServlet(name = "MyTicketController", urlPatterns = {"/my-ticket"})
public class MyTicketController extends HttpServlet {

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
            out.println("<title>Servlet MyTicketController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyTicketController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Account accountLogin = (Account) session.getAttribute("user");

        if (accountLogin != null) {
            TicketDAO ticketDao = new TicketDAO();
            List<Ticket> tickets = ticketDao.getTicketListByUser(accountLogin.getAccountId());
            String search = request.getParameter("search");
            String sort = request.getParameter("sort");

            if (search != null && !search.isEmpty()) {
                tickets = searchTickets(tickets, search);
            }

            if ("price_asc".equals(sort)) {
                tickets.sort(Comparator.comparingDouble(t -> t.getSeat().getPrice()));
            } else if ("price_desc".equals(sort)) {
                tickets.sort((t1, t2) -> Double.compare(t2.getSeat().getPrice(), t1.getSeat().getPrice()));
            } else if ("date_asc".equals(sort)) {
                tickets.sort(Comparator.comparing(t -> t.getDate()));
            } else if ("date_desc".equals(sort)) {
                tickets.sort((t1, t2) -> t2.getDate().compareTo(t1.getDate()));
            }

            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("./Views/Ticket/MyTicket.jsp").forward(request, response);
        } else {
            response.sendRedirect("matchServlet");
        }
    }

    private List<Ticket> searchTickets(List<Ticket> tickets, String search) {
        return tickets.stream()
                .filter(ticket
                        -> ticket.getCode().contains(search)
                || ticket.getMatch().getClub1().getClubName().contains(search)
                || ticket.getMatch().getClub2().getClubName().contains(search)
                || ticket.getSeat().getArea().getAreaName().contains(search))
                .collect(Collectors.toList());
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
        HttpSession session = request.getSession();
        Account accountLogin = (Account) session.getAttribute("user");

        if (accountLogin != null) {
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));

            MatchDAO matchDao = MatchDAO.INSTANCE;
            TicketDAO ticketDao = new TicketDAO();

            Ticket ticket = ticketDao.getTicketByIdQR(ticketId);
            Match match = matchDao.getMatchById(ticket.getMatch().matchId);

            if (match.getMatchStatusId() >= 2) {
                response.sendRedirect("my-ticket?error=Cannot refund. Match is ongoing for finish.");
            } else {
                LocalDate matchDate = match.getSchedule().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                LocalDate currentDate = LocalDate.now();
                long daysUntilMatch = ChronoUnit.DAYS.between(currentDate, matchDate);
                if (daysUntilMatch >= 2) {
                    ticketDao.updateTicketStatusHistory(ticketId, 4);
                    ticketDao.updateSeatStatusAvailable(ticket.getSeat().getSeatId());
                    int orderId = ticketDao.getPendingOrderIds(ticketId);
                    int totalAmout = ticketDao.getTotalOrderIds(ticketId);
                    request.setAttribute("trantype", "refund");
                    request.setAttribute("order_id", orderId);
                    request.setAttribute("amount", totalAmout);
                    request.setAttribute("user", accountLogin.getAccountId());
                    request.setAttribute("ticketId", ticketId);
                    request.getRequestDispatcher("./Views/Ticket/Refund.jsp").forward(request, response);
                } else {
                    response.sendRedirect("my-ticket?error=Cannot refund. Match is too close.");
                }
            }
        }
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
