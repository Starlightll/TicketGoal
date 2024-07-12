<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 7/8/2024
  Time: 4:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ticketchecking.css"/>
</head>
<body>
<div class="container">
    <h1>Ticket checking</h1>
    <p>Scan the QR code on the ticket to check</p>
    <div id="reader" style="width: 600px"></div>
    <div class="status" id="status">
        <p id="message"></p>
    </div>
</div>


<script>
    console.log(Html5QrcodeScanner);
    let readerElement = document.getElementById('reader');
    let statusElement = document.getElementById('status');
    let messageElement = document.getElementById('message');
    function onScanSuccess(decodedText) {
        $.ajax({
            url: `${pageContext.request.contextPath}/TicketChecking`,
            type: "POST",
            data: {
                code: decodedText
            },
            dataType: "json",
            success: function (data) {
                if(data.valid === true){
                    statusElement.style.display = "block";
                    readerElement.style.border = "5px solid #28a745";
                    statusElement.style.backgroundColor = "#28a745";
                    messageElement.innerHTML = "PASS";
                } else {
                    statusElement.style.display = "block";
                    readerElement.style.border = "5px solid #dc3545";
                    statusElement.style.backgroundColor = "#dc3545";
                    messageElement.innerHTML = "FAIL";
                }
            },
            error: function (data) {
                alert("Error");
            }
        });
    }

    function onScanFailure(error) {
        statusElement.style.display = "none";
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "reader",
        {fps: 20,
            qrbox: 250,
            aspectRatio: 1.0,
            disableFlip: false,
            disableAutoFocus: false,
            videoConstraints: {
                facingMode: "environment"
            }
        },
   );
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);
</script>


</body>
</html>
