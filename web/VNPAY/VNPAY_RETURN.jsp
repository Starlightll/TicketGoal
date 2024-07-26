<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 7/9/2024
  Time: 2:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.nio.charset.StandardCharsets" %>
<%@page import="vnpay.common.Config" %>
<%@page import="java.util.Enumeration" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TicketGoal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css"
          integrity="sha512-UuQ/zJlbMVAw/UU8vVBhnI4op+/tFOpQZVT+FormmIEhRSCnJWyHiBbEVgM4Uztsht41f3FzVWgLuwzUqOObKw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vnpay_return.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
    <link rel="icon" type="image/png" href="img/TicketGoalfavicon.png">
</head>
<body>
<div class="header-container">
    <%@include file="/Views/include/header.jsp" %>
</div>
<main>
    <%
        //Begin process return from VNPAY
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

    %>
    <!--Begin display -->
    <div class="payment__detail_box">
        <label>
            <%
                if (signValue.equals(vnp_SecureHash)) {
                    if ("00".equals(request.getParameter("vnp_TransactionStatus")) && !"true".equals(request.getParameter("isSold"))) {
            %>
            <div class="success"><i class="ri-check-line"></i></div>
            <div class="table-responsive">
                <div class="Header">
                    <h3 class="text-muted">AWSOME!</h3>
                </div>
                <div class="payment__information">

                    <div class="message">
                        <p>Your purchase are successful. Check your email for details.</p>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold; color: #373737">Payment code:</label>
                        <label><%=request.getParameter("vnp_TxnRef")%>
                        </label>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold; color: #373737">Amount:</label>
                        <label>
                            <%
                                long amount = Long.parseLong(request.getParameter("vnp_Amount")) / 100; // Nếu số tiền từ VNPAY có hai chữ số thập phân
                                NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
                                formatter.setMaximumFractionDigits(0); // Không hiển thị số thập phân
                                String formattedAmount = formatter.format(amount) + " VNĐ";
                            %>
                            <label><%= formattedAmount %>
                            </label>
                        </label>
                    </div>
                    <div class="form-group">
                        <label style="font-weight: bold; color: #373737">Transaction code at VNPAY-QR:</label>
                        <label><%=request.getParameter("vnp_TransactionNo")%>
                        </label>
                    </div>
                    <div class="form-group">
                        <%
                            String paymentDate = request.getParameter("vnp_PayDate");
                            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                            SimpleDateFormat targetFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            String formattedDate = "";
                            try {
                                Date date = originalFormat.parse(paymentDate);
                                formattedDate = targetFormat.format(date);
                            } catch (ParseException e) {
                                e.printStackTrace();
                                formattedDate = "Invalid date format";
                            }
                        %>
                        <label style="font-weight: bold; color: #373737">Payment date:</label>
                        <label><%= formattedDate %>
                        </label>
                    </div>
                </div>
                <div class="action">
                    <button onclick="location.href='Homepage'">Home</button>
                    <button onclick="location.href='my-ticket'">My Ticket</button>
                </div>
            </div>
            <%
            } else if("true".equals(request.getParameter("isSold"))) {
            %>
            <div class="fail"><i class="ri-close-line"></i></div>
            <%
                    }

                } else {
                    out.print("invalid signature");
                }
            %>
        </label>

    </div>
</main>
<div class="footer-container">
    <%@include file="/Views/include/footer.jsp" %>
</div>
</body>
</html>
