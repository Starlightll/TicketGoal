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
</head>
<body>

<div id="reader" style="width: 600px"></div>

<script>
    console.log(Html5QrcodeScanner);

    function onScanSuccess(decodedText, decodedResult) {
        // handle the scanned code as you like, for example:
        console.log(`Code matched = ${decodedText}`, decodedResult);
    }

    function onScanFailure(error) {
        // handle scan failure, usually better to ignore and keep scanning.
        // for example:
        console.warn(`Code scan error = ${error}`);
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "reader",
        { fps: 6, qrbox: {width: 250, height: 250} },
        verbose=  false);
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);
</script>


</body>
</html>
