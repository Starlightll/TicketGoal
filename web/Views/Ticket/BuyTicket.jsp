<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 6/18/2024
  Time: 6:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buyticket.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<main>
    <button onclick="location.href='matchServlet'">Back</button>
    <div class="buyticket__main">
        <div class="stadium" id="stadium">
            <div>
                <img src="${pageContext.request.contextPath}/img/StadiumV1.png" alt="stadium">
                <%--top side outler--%>
                <div class="top__side__outler">
                    <div class="area__ARO">
                        <c:forEach var="seat" items="${seatsARO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__ALO">
                        <c:forEach var="seat" items="${seatsALO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--down side--%>
                <div class="down__side__outler">
                    <div class="area__CRO">
                        <c:forEach var="seat" items="${seatsCRO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__CLO">
                        <c:forEach var="seat" items="${seatsCLO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--left side--%>
                <div class="left__side__outler">
                    <div class="area__DLO">
                        <c:forEach var="seat" items="${seatsDLO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--right side--%>
                <div class="right__side__outler">
                    <div class="area__BRO">
                        <c:forEach var="seat" items="${seatsBRO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style="" id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ffa600; cursor: default" id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <%-- top side inner --%>
                <div class="top__side__inner"></div>
            </div>
        </div>
        <div class="order__detail">
            <form>
                <div class="order__detail__header">
                    <div>Order Detail</div>
                </div>
                <div class="order__list" id="order-list">

                </div>
                <div class="checkout">
                    <div style="width: 100%; height: 4px; background-color: #999aa5; margin: 0 auto"></div>
                    <div class="total">
                        <div>Total:</div>
                        <div id="total-value">0 VNĐ</div>
                    </div>
                    <div style="width: 100%; height: 4px; background-color: #999aa5; margin: 0 auto"></div>
                </div>
                <div class="action">
                    <button id="btn-buy" type="button" onclick="checkout(${matchId})">Buy</button>
                    <button id="btn-add-to-cart" type="button" onclick="addToCart(${matchId})">Add to cart</button>
                </div>
            </form>
        </div>
        <div class="notification__background" id="notification-background">
            <div class="notification" id="buyticket-notification">
                <div class="notification__item__icon__close"><i class="ri-close-large-fill" id="btn-close-notification"></i></div>
                <div class="notification__item__icon"><i class="ri-error-warning-fill"></i></div>
                <div class="notification__content">
                    <div class="notification__item__content" id="notification-message"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="confirm__box__background" id="confirm-box-background">
        <form class="confirm__box" id="confirm-box">
            <div hidden>
                <input type="text" name="seatId">
                <input type="text" name="seatNumber">
                <input type="text" name="row">
                <input type="text" name="price">
                <input type="text" name="matchId" value="${matchId}">
            </div>
            <i class="ri-close-large-fill close__btn" id="btn-close"></i>
            <table>
                <p hidden id="seat-id"></p>
                <tr>
                    <td id="area-name" style="font-weight: bold; color: #272629"></td>
                </tr>
                <tr>
                    <td>Seat number:</td>
                    <td id="seat-number-value"></td>
                </tr>
                <tr>
                    <td>Row:</td>
                    <td id="row-value"></td>
                </tr>
                <tr>
                    <td>Price:</td>
                    <td id="price-value"></td>
                </tr>
            </table>
            <div class="action">
                <button class="add__list_btn" onclick="addToList()" type="button"><i class="ri-add-line"></i></button>
            </div>
        </form>
    </div>
</main>
<script>
    let tickets = [];

    function showConfirm(areaName, seatId, seatNumber, row, price) {
        document.getElementById("confirm-box-background").style.display = "block";
        document.getElementById("area-name").innerHTML = "Area: " + areaName;
        document.getElementById("seat-number-value").innerHTML = seatNumber;
        document.getElementById("row-value").innerHTML = row;
        document.getElementById("price-value").innerHTML = price + " VNĐ";
        document.getElementById("seat-id").innerHTML = seatId;
        document.forms["confirm-box"]["seatId"].value = seatId;
        document.forms["confirm-box"]["seatNumber"].value = seatNumber;
        document.forms["confirm-box"]["row"].value = row;
        document.forms["confirm-box"]["price"].value = price;
    }

    function addToList(){
        const confirmBox = document.getElementById("confirm-box");
        const seatId = confirmBox["seatId"].value;
        const seatNumber = confirmBox["seatNumber"].value;
        const price = confirmBox["price"].value;
        const row = confirmBox["row"].value;
        const orderList = document.getElementById("order-list");
        const totalValue = document.getElementById("total-value");
        const newOrder = document.createElement("div");
        if(tickets.includes(seatId)){
            showNotification("This seat is already in the list");
        }else if(seatId !== null || seatId !== ""){
            newOrder.className = "order";
            newOrder.innerHTML = "<div style='background-color: #ff0044; width: 100%; height: 50px; margin-bottom: 4px; border-radius: 10px; color: white'>"+"<div>"+seatNumber+"</div>"+"<div>"+row+"</div>"+"</div>";
            orderList.appendChild(newOrder);
            let totalValueNumber = parseInt(totalValue.innerHTML.split(" ")[0]);
            let priceNumber = parseInt(price.split(" ")[0]);
            totalValue.innerHTML = (totalValueNumber + priceNumber) + " VNĐ";
            const seat = document.getElementById("seat-" + seatId);
            seat.style.color = '#1fffa2';
            tickets.push(seatId);
        }
        //close confirm box
        document.getElementById("confirm-box-background").style.display = "none";
        confirmBox.reset();
    }

    function addToCart(matchId){
        if(tickets.length === 0){
            showNotification("Please select at least one seat");
            return;
        }
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                matchId: matchId,
                action: "addToCart",
                seatIds: JSON.stringify(tickets)
            },
            dataType: 'JSON',
            success: function (response) {
                if(response.loginRequired === 'true'){
                    const loginBox = document.getElementById('login');
                    loginBox.classList.add('show-login');
                }else if(response.notAvailable === 'true'){
                    showNotification("This match is not longer available for purchases ticket");
                }else if(response.isPurchased === 'true'){
                    showNotification("This seat is already purchased!");
                }else if(response.isInCart === 'true'){
                    showNotification("This seat is already in the cart");
                }else if(response.isSuccess === 'true'){
                    showNotification("Add to cart successfully");
                    const stadium = document.getElementById("stadium");
                    let orderList = document.getElementById("order-list");
                    tickets = [];
                    orderList.innerText = "";
                    stadium.innerHTML = response.stadium;
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }


    function checkout(matchId) {
        if(tickets.length === 0){
            showNotification("Please select at least one seat");
            return;
        }
        var matchIds = matchId;
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                matchId: matchIds,
                action: "buyTicket",
                seatIds: JSON.stringify(tickets)
            },
            dataType: 'JSON',
            success: function (response) {
                if(response.loginRequired === 'true'){
                    const loginBox = document.getElementById('login');
                    loginBox.classList.add('show-login');
                }else if(response.notAvailable === 'true'){
                    showNotification("This match is not longer available for purchases ticket");
                }else if(response.isPurchased === 'true'){
                    showNotification("This seat is already purchased!");
                }else if(response.isSuccess === 'true'){
                    showNotification("Buy ticket successfully");
                    const stadium = document.getElementById("stadium");
                    let orderList = document.getElementById("order-list");
                    tickets = [];
                    orderList.innerText = "";
                    stadium.innerHTML = response.stadium;
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }

    function showNotification(message) {
        const notificationBackground = document.getElementById('notification-background');
        const notification = document.getElementById('buyticket-notification');
        const notificationMessage = document.getElementById('notification-message');
        notificationMessage.innerHTML = message;
        notificationBackground.style.display = "block";
        setTimeout(function(){
            notificationBackground.style.opacity = "1";
        }, 300);
        setTimeout(function(){
            notification.style.transform = "translate(-50%, -50%) scale(1)";
        }, 300);
    }


</script>
<script src="${pageContext.request.contextPath}/js/buyticket.js"></script>
</body>
</html>
