
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="./css/cart.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="cart-summary">
                <form action="cart">
                    <div class="search-bar">
                        <div>
                            <input type="text" name="clubInput" id="clubInput" placeholder="Search...">
                            <button class="btn btn-primary" onclick="searchTickets(event)">Search</button>
                        </div>
                    </div>
                    <div class="selected-ticket-info">
                        <h4>Information ticket:</h4>
                        <div id="selected-ticket-info"></div>
                        <p id="total-price-selected">No have product: 0</p>
                    </div>
                    
                    <button type="submit" class="purchase-button">Purchase</button>
                </form>
            </div>
            <div class="cart-items">
                <c:forEach var="ticket" items="${listTickets}">
                    <div class="cart-item">
                        <div class="ticket-info">
                            <div class="image-placeholder">
                                <div class="box-clubname">
                                    <p class="club1">${ticket.club1}</p>
                                    <p class="divider"></p>
                                    <p class="club2">${ticket.club2}</p>
                                </div>
                            </div>
                            <div class="ticket-details">
                                <p>Area: ${ticket.areaName}</p>
                                <p>Seat number: ${ticket.seatNumber}</p>
                                <p>Price: ${ticket.price}</p>
                            </div>
                        </div>
                        <div class="delete-icon">
                            <input type="checkbox" class="ticket-checkbox"
                                   data-price="${ticket.price}"
                                   data-area="${ticket.areaName}"
                                   data-seat="${ticket.seatNumber}"
                                   value="${ticket.ticketId}"
                                   onClick="handleChoose(this)"
                                   >
                            <span onClick="deleteTicket(${ticket.ticketId}, ${ticket.cartId})"><i class="fas fa-trash"></i></span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>     
        <script src="./js/cart.js"></script>
    </body>
</html>
