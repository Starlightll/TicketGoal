package vnpay.common;

import DAO.OrderDAO;
import DAO.SeatDAO;
import DAO.TicketDAO;
import Models.Account;
import Models.Order;
import Models.Seat;
import Models.Ticket;
import Utils.EmailSender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.poi.ss.formula.functions.T;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "IPN", value = "/IPN")
public class IPNServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = Config.hashAllFields(fields);
        if (signValue.equals(vnp_SecureHash)) {
            boolean checkOrderId = true; // Giá trị của vnp_TxnRef tồn tại trong CSDL của merchant
            boolean checkAmount = true; //Kiểm tra số tiền thanh toán do VNPAY phản hồi(vnp_Amount/100) với số tiền của đơn hàng merchant tạo thanh toán: giả sử số tiền kiểm tra là đúng.
            boolean checkOrderStatus = true; // Giả sử PaymnentStatus = 0 (pending) là trạng thái thanh toán của giao dịch khởi tạo chưa có IPN.

            //Check seat status before update order status
            SeatDAO seatDao = SeatDAO.INSTANCE;
            TicketDAO ticketDao = new TicketDAO();
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("user");
            Order order = (Order) session.getAttribute("order");
            for(Ticket ticket : order.getTickets()){
                Seat seat = seatDao.getSeatById(ticket.getSeat().getSeatId());
                if(seat.getSeatStatusId() == 3){
                    checkOrderStatus = false;
                    ticketDao.updateTicketStatus(ticket.getTicketId(), 3);
                }
            }
            if (checkOrderId) {
                if (checkAmount) {
                    if (checkOrderStatus) {
                        if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                            //Xử lý/Cập nhật tình trạng giao dịch thanh toán "Thành công"
                            try {
                                if (order.getStatusId() != 1) {
                                    //Cập nhật trạng thái đơn hàng
                                    OrderDAO.INSTANCE.updateOrderStatus(order.getOrderId(), 1, order.getTickets());
                                    order = OrderDAO.INSTANCE.getOrderById(order.getOrderId());
                                    //Gửi mail thông báo đơn hàng
                                    EmailSender emailSender = new EmailSender();
                                    List<Ticket> tickets = order.getTickets();
                                    emailSender.sendEmailQRCode(account, tickets, request, response);
                                }
                            } catch (Exception e) {
                                request.getRequestDispatcher("/VNPAY/VNPAY_RETURN.jsp").forward(request, response);
                            }
                            request.getRequestDispatcher("/VNPAY/VNPAY_RETURN.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/VNPAY/VNPAY_RETURN.jsp").forward(request, response);
                        }
                    } else {
                        //Seat sold out or not available
                        request.setAttribute("isSold", "true");
                        request.getRequestDispatcher("/VNPAY/VNPAY_RETURN.jsp").forward(request, response);
                    }
                } else {
                    //Số tiền không trùng khớp

                }
            } else {
                //Mã giao dịch không tồn tại
            }

        } else {
            // Sai checksum
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
