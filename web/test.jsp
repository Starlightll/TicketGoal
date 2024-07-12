<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 7/9/2024
  Time: 9:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css"
          integrity="sha512-UuQ/zJlbMVAw/UU8vVBhnI4op+/tFOpQZVT+FormmIEhRSCnJWyHiBbEVgM4Uztsht41f3FzVWgLuwzUqOObKw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <title>TicketGoal</title>
</head>
<body>
<main style="font-family: 'Inter', sans-serif;">
    <h1>QR Code Backup</h1>
    <p>Here is your backup QRCode, this code used due to networking problem in event, when you can't generate code
        directly from our website.</p>
    <p>Remember to keep this code safe and don't share it with anyone else.</p>
    <div class="QRCodeList" style="width: 500px; padding: 10px">
        <div style="display: flex;justify-content: start;text-align: center;align-items: center;border: 2px solid #1B1B1C">
            <div style="width: 120px; height: 120px; background-color: #1A1A1A; margin-right: 10px">
                <img style="width: 100%; height: 100%" src="">
            </div>
            <div style="margin: 0">
                <p style="font-size: 20px; font-weight: bold; margin: 0">Area: </p>
                <p style="margin: 0">Row:</p>
                <p style="margin: 0">Seat:</p>
                <p style="margin: 0">Date:</p>
            </div>
        </div>
    </div>
    <p>Thank you for using our service.</p>
    <p>Have a nice day!</p>

    <footer>
        <p>&copy; TicketGoal 2024</p>
    </footer>
</main>
</body>
</html>
