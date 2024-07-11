package Utils;

import DAO.AccountDAO;
import Models.Account;
import Models.Ticket;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class EmailSender {

    private final AccountDAO accDAO = AccountDAO.INSTANCE;
    private final ExecutorService executorService = Executors.newFixedThreadPool(10); // Tạo một pool với 10 threads

    public void sendEmailForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        int timeout = 60000;
        String mess2 = "123";

        String email = (String) req.getParameter("email");
        String to = email.trim();
        if (accDAO.getAccountByEmail(to) == null) {
            jsonResponse = new Common.JsonResponse(false, "Email was not exist in the system");
            String json = gson.toJson(jsonResponse);
            resp.getWriter().write(json);
            return;
        }

        String token = JwtUtil.generateToken(email);
        String BASE_URL = "http://localhost:8080/TicketGoal/";
        String resetUrl = BASE_URL + "forgotPassword?token=" + token;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.timeout", timeout);

        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("lytieulong2j2@gmail.com", "ngmm pgqt gknn ldbk");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("lytieulong2j2@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Dear MyFriend, ");
            String htmlContent = "<h1>Change your password in <a href=\"" + resetUrl + "\">Ticket Goal Reset Password</a></h1> <h2>Note: The email can only exist in 10 minute from the time it started sending!!!!!</h2>";
            message.setContent(htmlContent, "text/html");
            Transport.send(message);
            jsonResponse = new Common.JsonResponse(true, "Message sent successful");
            System.out.println("Message sent successfully");
            mess2 += " Check your email!";
            req.setAttribute("mess2", mess2);
        } catch (MessagingException e) {
            jsonResponse = new Common.JsonResponse(true, "Something's wrong sent successful");
            throw new RuntimeException(e);
        }

        String json = gson.toJson(jsonResponse);
        resp.getWriter().write(json);
    }

    public void sendEmailQRCode(Account account, List<Ticket> tickets, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        int timeout = 8000;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.timeout", timeout);

        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("lytieulong2j2@gmail.com", "ngmm pgqt gknn ldbk");
            }
        });

        executorService.submit(() -> {
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("lytieulong2j2@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(account.getEmail()));
                message.setSubject("Dear MyFriend, ");
                String htmlContent = "<!DOCTYPE html>\n" +
                        "<html>\n" +
                        "<head>\n" +
                        "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
                        "    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css\" integrity=\"sha512-UuQ/zJlbMVAw/UU8vVBhnI4op+/tFOpQZVT+FormmIEhRSCnJWyHiBbEVgM4Uztsht41f3FzVWgLuwzUqOObKw==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\" />\n" +
                        "    <title>TicketGoal</title>\n" +
                        "</head>\n" +
                        "<body>\n" +
                        "<main style=\"font-family: 'Inter', sans-serif;\">\n" +
                        "    <h1>QR Code Backup</h1>\n" +
                        "    <p>Here is your backup QRCode, this code used due to networking problem in event, when you can't generate code directly from our website.</p>\n" +
                        "    <p>Remember to keep this code safe and don't share it with anyone else.</p>\n" +
                        "    <div class=\"QRCodeList\" style=\"width: 500px; padding: 10px\">\n";
                for (Ticket ticket : tickets) {
                    htmlContent += "<div style=\"display: flex;justify-content: start;text-align: center;align-items: center;border: 2px solid #1B1B1C\">\n" +
                            "            <div style=\"width: 120px; height: 120px; background-color: #1A1A1A; margin-right: 10px\">\n" +
                            "                <img style=\"width:100%;height:100%; border: 2px solid black\" src=\"https://quickchart.io/qr?text=" + ticket.getCode() + "&size=200" + "\">\n" +
                            "            </div>\n" +
                            "            <div style=\"margin: 0\">\n" +
                            "                <p style=\"font-size: 20px; font-weight: bold; margin: 0\">Area: " + ticket.getSeat().getArea().getAreaName() + "</p>\n" +
                            "                <p style=\"margin: 0\">Row: " + ticket.getSeat().getRow() + "</p>\n" +
                            "                <p style=\"margin: 0\">Seat: " + ticket.getSeat().getSeatNumber() + "</p>\n" +
                            "                <p style=\"margin: 0\">Date: " + ticket.getDate() + "</p>\n" +
                            "            </div>\n" +
                            "        </div>\n";
                }
                htmlContent +=
                        "    </div>\n" +
                                "    <p>Thank you for using our service.</p>\n" +
                                "    <p>Have a nice day!</p>\n" +
                                "\n" +
                                "    <footer>\n" +
                                "        <p>&copy; TicketGoal 2024</p>\n" +
                                "    </footer>\n" +
                                "</main>\n" +
                                "</body>\n" +
                                "</html>";

                // Create body
                MimeBodyPart messageBodyPart = new MimeBodyPart();
                messageBodyPart.setContent(htmlContent, "text/html");

                // Creates multi-part
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);

                // sets the multi-part as e-mail's content
                message.setContent(multipart);
                Transport.send(message);
                System.out.println("Message sent successfully");
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        });
    }

}
