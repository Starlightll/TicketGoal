<%-- 
    Document   : MyTicket
    Created on : Jul 8, 2024, 1:01:40 PM
    Author     : HP
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My ticket</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="./css/cart.css"/>
        <link rel="stylesheet" href="./css/myticket.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="my-ticket-container">
                <h2>My Tickets</h2>

                <div class="search-sort-container">
                    <form action="my-ticket" method="get" class="search-sort-form">
                        <input type="text" name="search" placeholder="Search by club or area" value="${param.search}" class="search-input">
                        <select name="sort" class="sort-select">
                            <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Sort by Price (Low to High)</option>
                            <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Sort by Price (High to Low)</option>
                            <option value="date_asc" ${param.sort == 'date_asc' ? 'selected' : ''}>Sort by Date (Earliest to Latest)</option>
                            <option value="date_desc" ${param.sort == 'date_desc' ? 'selected' : ''}>Sort by Date (Latest to Earliest)</option>
                        </select>
                        <button type="submit" class="search-sort-button">Search & Sort</button>
                    </form>
                    <c:if test="${param.error != null}">
                        <div class="custom-alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            <strong>Error:</strong> ${param.error}
                        </div>
                    </c:if>
                    <c:if test="${param.success != null}">
                        <div class="custom-alert success">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            <strong>Success: </strong> ${param.success}
                        </div>
                    </c:if>
                </div>

                <div class="ticket-list">
                    <c:forEach var="ticket" items="${tickets}">
                        <div class="ticket-item">
                            <div class="ticket-header">
                                <span class="ticket-code">${ticket.code}</span>
                                <span class="ticket-status">${ticket.status}</span>
                            </div>
                            <div class="ticket-details">
                                <div class="club-names">
                                    <span class="club-name">${ticket.match.club1.clubName}</span>
                                    <span class="divider-customer"> vs </span>
                                    <span class="club-name">${ticket.match.club2.clubName}</span>
                                </div>
                                <div class="ticket-info">
                                    <div class="ticket-column">
                                        <p><strong>Area:</strong> ${ticket.seat.area.areaName}</p>
                                        <p><strong>Seat number:</strong> ${ticket.seat.seatNumber}</p>
                                        <p><strong>Price:</strong> ${ticket.seat.price}</p>
                                    </div>
                                    <div class="ticket-column">
                                        <p><strong>Date ticket:</strong> ${ticket.date}</p>
                                        <p><strong>Date match:</strong> ${ticket.match.schedule}</p>
                                    </div>
                                </div>
                                <c:if test="${ticket.status == 'Paid'}">
                                    <form action="./my-ticket" method="post">
                                        <input type="hidden" name="ticketId" value="${ticket.ticketId}">
                                        <button onclick="return  confirm('Are you sure to refund this ticket?')" type="submit">Refund</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${tickets.size() == 0}">
                        <div class="ticket-item">
                            No have ticket here
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <script>
            document.getElementsByClassName("closebtn")[0].onclick = function () {
                this.parentElement.style.display = 'none';
            }
        </script>
    </body>
</html>
