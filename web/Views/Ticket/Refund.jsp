

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Refund Processing</title>
    </head>
    <body onload="document.refundForm.submit();">
        <form name="refundForm" action="./refundServlet" method="post">
            <input type="hidden" name="trantype" value="${trantype}">
            <input type="hidden" name="order_id" value="${order_id}">
            <input type="hidden" name="amount" value="${amount}">
            <input type="hidden" name="user" value="${user}">
             <input type="hidden" name="returnPage" value="./my-ticket">
            <input type="hidden" name="ticketId" value="${ticketId}">
        </form>
    </body>
</html>
