<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Operator List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/operator/operatorManagement.css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
        <style>
            /* CSS for modal overlay */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
                z-index: 1000; /* Higher z-index to ensure it's on top */
                overflow: hidden; /* Prevent scrolling */
            }

            /* CSS for QR code modal */
            .qr-modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                z-index: 1001; /* Higher z-index than overlay */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            }

            /* Styles for close button */
            .qr-modal-close {
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <!-- QR Code Modal -->
        <div id="qrModal" class="qr-modal">
            <span class="qr-modal-close" onclick="hideQRCode()">&times;</span>
            <div id="qrcode"></div>
        </div>

        <!-- Modal Overlay -->
        <div id="overlay" class="modal-overlay"></div>
        <div class="container">
            <div class="top-bar">
                <form method="GET" action="./ticketManagement">
                    <input type="hidden" name="type" value="scanned"/>
                    <button  class="add-btn" >Scanned</button>
                </form>
                <form method="GET" action="./ticketManagement">
                    <input type="hidden" name="type" value="marked"/>
                    <button  class="add-btn" >Marked</button>
                </form>
            </div>
            <div class="white-bar"></div>
            <!--Table-->
            <div style="width: 100%;
                 margin-top: 40px;">
                <table id="operatorTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Ticket ID <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable(1)">Code <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable(2)">Date <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable(3)">Seat ID <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable(4)">Ticket Status ID <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable(5)">Match <i class="fas fa-sort" ></i></th>
                            <th>Action <i class="fas fa-sort" ></i></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ticket" items="${tickets}">
                            <tr>
                                <td>${ticket.ticketId}</td>
                                <td onclick="showQRCode('${ticket.code}')">${ticket.code}</td>
                                <td>${ticket.date}</td>
                                <td>${ticket.seatId}</td>
                                <td>${ticket.ticketStatusId}</td>
                                <td>${ticket.matchId}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
       
    </body>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script>
          function showQRCode(textContent) {

        // Generate QR code
        const qrContainer = document.getElementById('qrcode');
        const qrcode = new QRCode(qrContainer, {
            text: textContent,
            width: 256,
            height: 256,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H,
        });

        // Show modal and overlay
        document.getElementById('qrModal').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    // Function to hide QR code modal
    function hideQRCode() {
        // Hide modal and overlay
        document.getElementById('qrModal').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';

        // Clear QR code when closing modal (optional)
        const qrContainer = document.getElementById('qrcode');
        qrContainer.innerHTML = ''; // Clear previous QR code
    }
    </script>
</html>
