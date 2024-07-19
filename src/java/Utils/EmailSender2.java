package Utils;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Properties;

public class EmailSender2 {

//    public void sendEmail(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        resp.setContentType("application/json");
//        resp.setCharacterEncoding("UTF-8");
//
//        Gson gson = new Gson();
//        Common.JsonResponse jsonResponse;
//
//        int timeout = 60000;
//        String mess2 = "123";
//        HttpSession mySession = req.getSession();
//        String email = (String) mySession.getAttribute("email");
//
//        if (mess2 != null) {
//            String to = "trinhtiendat2510@gmail.com";
//            Properties props = new Properties();
//            props.put("mail.smtp.auth", "true");
//            props.put("mail.smtp.host", "smtp.gmail.com");
//            props.put("mail.smtp.starttls.enable", "true");
//            props.put("mail.smtp.port", "587");
//            props.put("mail.smtp.timeout", timeout);
//
//            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//                protected PasswordAuthentication getPasswordAuthentication() {
//                    return new PasswordAuthentication("lytieulong2j2@gmail.com", "ngmm pgqt gknn ldbk");
//                }
//            });
//
//            try {
//                MimeMessage message = new MimeMessage(session);
//                message.setFrom(new InternetAddress("lytieulong2j2@gmail.com"));
//                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
//                message.setSubject("Dear MyFriend, ");
//                String htmlContent = "<h1>Change your password in <a href=\"http://localhost:9999/OnlineDebtBook_Project/ChangePassword?email=" + to + "\">Online Debt Reset Password</a></h1> <h2>Note: The email can only exist in 1 minute from the time it started sending!!!!!</h2>";
//                message.setContent(htmlContent, "text/html");
//                Transport.send(message);
//                jsonResponse = new Common.JsonResponse(true, "Message sent successful");
//                System.out.println("Message sent successfully");
//                mess2 += " Check your email!";
//                req.setAttribute("mess2", mess2);
//            } catch (MessagingException e) {
//                jsonResponse = new Common.JsonResponse(true, "Something's wrong sent successful");
//                throw new RuntimeException(e);
//            }
//
//            String json = gson.toJson(jsonResponse);
//            resp.getWriter().write(json);
//        }
//    }

    public void sendEmailDynamic(HttpServletRequest req, HttpServletResponse resp, String email, String subject, String content) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        Common.JsonResponse jsonResponse;

        int timeout = 60000;
        String mess2 = "123";
        HttpSession mySession = req.getSession();
        if (mess2 != null) {
            String to = email;
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
                message.setSubject(subject);
                String htmlContent = content;
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
    }
}
