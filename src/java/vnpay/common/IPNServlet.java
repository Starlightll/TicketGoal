package vnpay.common;

import DAO.OrderDAO;
import Models.Account;
import Models.Order;
import Models.Ticket;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import Utils.EmailSender;
import org.apache.http.impl.io.EmptyInputStream;

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
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
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
            if (checkOrderId) {
                if (checkAmount) {
                    if (checkOrderStatus) {
                        if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                            //Xử lý/Cập nhật tình trạng giao dịch thanh toán "Thành công"
                            HttpSession session = request.getSession();
                            Account account = (Account) session.getAttribute("user");
                            int orderId = 0;
                            try{
                                orderId = (int) session.getAttribute("orderId");
                            }
                            catch (Exception e){
                                response.sendRedirect(request.getContextPath()+ "/VNPAY_RETURN.jsp");
                                return;
                            }
                            //Cập nhật trạng thái đơn hàng
                            Order order = OrderDAO.INSTANCE.getOrderById(orderId);
                            OrderDAO.INSTANCE.updateOrderStatus(orderId, 1, order.getTickets());
                            order = OrderDAO.INSTANCE.getOrderById(orderId);
                            List<Ticket> tickets = order.getTickets();
                            //Gửi mail thông báo đơn hàng
                            EmailSender emailSender = new EmailSender();
                            emailSender.sendEmailQRCode(account, tickets, request, response);
                            request.getRequestDispatcher("/VNPAY/VNPAY_RETURN.jsp").forward(request, response);
                        } else {
                            //Xử lý/Cập nhật tình trạng giao dịch thanh toán "Không thành công"
                        }
                    } else {
                        //Trạng thái giao dịch đã được cập nhật trước đó

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
