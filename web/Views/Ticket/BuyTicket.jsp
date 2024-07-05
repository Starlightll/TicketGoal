<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 6/18/2024
  Time: 6:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    <button class="back__button" onclick="location.href='matchServlet'">Back</button>
    <div class="buyticket__main">
        <input class="zoom__bar" type="range" min="0" max="2" value="0.9" step="0.1"
               oninput="this.value > currentZoom ? zoomIn() : zoomOut()">
        <div class="stadium" id="stadium">
            <div class="stadium__UI" id="stadiumUI">
                <img src="${pageContext.request.contextPath}/img/StadiumV1.png" alt="stadium">
                <%--top side outler--%>
                <div class="top__side__outler">
                    <div class="area__ARO">
                        <c:forEach var="seat" items="${seatsARO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__ALO">
                        <c:forEach var="seat" items="${seatsALO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
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
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__CLO">
                        <c:forEach var="seat" items="${seatsCLO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm('${seat.area.areaName}', ${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
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
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
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
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""
                                                         id="seat-${seat.seatId}"></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ff4747; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 5}">
                                <div class="seat"><i class="ri-layout-top-2-fill"
                                                     style="color: #ffa600; cursor: default"
                                                     id="seat-${seat.seatId}"></i></div>
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
                    <c:forEach var="ticket" items="${ticketInCart}">
                        <div class="item">
                            <div>${ticket.seat.seatNumber}</div>
                            <div>${ticket.seat.row}</div>
                        </div>
                    </c:forEach>
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
                    <button id="btn-buy" type="button" onclick="purchase(${matchId})">Buy</button>
                    <button id="btn-add-to-cart" type="button" onclick="addToCart(${matchId})">Add to cart</button>
                </div>
            </form>
        </div>
        <div class="notification__background" id="notification-background">
            <div class="notification" id="buyticket-notification">
                <div class="notification__item__icon__close"><i class="ri-close-large-fill"
                                                                id="btn-close-notification"></i></div>
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
                <input type="text" name="seatId" value="">
                <input type="text" name="seatNumber" value="">
                <input type="text" name="row" value="">
                <input type="text" name="price" value="">
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
                <button id="btn-buy-one" type="button" onclick="purchaseOne()">Buy</button>
                <button class="add__list_btn" onclick="addToCart()" type="button"><i class="ri-add-line"></i></button>
            </div>
        </form>
    </div>
</main>
<script>
    attachStadiumDragEvent();
    //Drag for stadium
    function attachStadiumDragEvent() {
        let newX = 0, newY = 0, startX = 0, startY = 0;
        let stadiumUI = document.getElementById("stadiumUI");
        stadiumUI.addEventListener('mousedown', mouseDown);

        function mouseDown(e) {
            e.preventDefault();
            startX = e.clientX;
            startY = e.clientY;
            document.addEventListener('mousemove', mouseMove);
            document.addEventListener('mouseup', mouseUp);
        }

        function mouseMove(e) {
            e.preventDefault();
            newX = e.clientX - startX;
            newY = e.clientY - startY;

            startX = e.clientX;
            startY = e.clientY;

            // Move the stadium element
            stadiumUI.style.top = (stadiumUI.offsetTop + newY) + "px";
            stadiumUI.style.left = (stadiumUI.offsetLeft + newX) + "px";
        }

        function mouseUp(e) {
            document.removeEventListener('mousemove', mouseMove);
            document.removeEventListener('mouseup', mouseUp);
        }
    }

    function showConfirm(areaName, seatId, seatNumber, row, price) {
        document.getElementById("confirm-box-background").style.display = "block";
        document.getElementById("area-name").innerHTML = "Area: " + areaName;
        document.getElementById("seat-number-value").innerHTML = seatNumber;
        document.getElementById("row-value").innerHTML = row;
        document.getElementById("price-value").innerHTML = price + " VNĐ";
        document.getElementById("seat-id").innerHTML = seatId;
        const confirmBox = document.getElementById("confirm-box");
        confirmBox["seatId"].value = seatId;
        confirmBox["seatNumber"].value = seatNumber;
        confirmBox["row"].value = row;
        confirmBox["price"].value = price;
    }

    function addToList() {
        const confirmBox = document.getElementById("confirm-box");
        const seatId = confirmBox["seatId"].value;
        const seatNumber = confirmBox["seatNumber"].value;
        const price = confirmBox["price"].value;
        const row = confirmBox["row"].value;
        const orderList = document.getElementById("order-list");
        const totalValue = document.getElementById("total-value");
        const newOrder = document.createElement("div");
        if (tickets.includes(seatId)) {
            showNotification("This seat is already in the list");
        } else if (seatId !== null || seatId !== "") {
            newOrder.className = "order";
            newOrder.innerHTML = "<div style='background-color: #ff0044; width: 100%; height: 50px; margin-bottom: 4px; border-radius: 10px; color: white'>" + "<div>" + seatNumber + "</div>" + "<div>" + row + "</div>" + "</div>";
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

    function addToCart() {
        const confirmBox = document.getElementById("confirm-box");
        const seatIds = confirmBox["seatId"].value;
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                action: "addToCart",
                seatId: seatIds,
            },
            dataType: 'JSON',
            success: function (response) {
                if (response.loginRequired === 'true') {
                    const loginBox = document.getElementById('login');
                    loginBox.classList.add('show-login');
                } else if (response.notAvailable === 'true') {
                    showNotification("This match is not longer available for purchases ticket");
                } else if (response.isPurchased === 'true') {
                    showNotification("This seat is already purchased!");
                } else if (response.isInCart === 'true') {
                    showNotification("This seat is already in the cart");
                } else if (response.isSuccess === 'true') {
                    const orderList = document.getElementById("order-list");
                    const newOrder = document.createElement("div");
                    newOrder.className = "item";
                    newOrder.innerHTML = response.addedSeat;
                    orderList.appendChild(newOrder);
                    const stadiumUI = document.getElementById("stadiumUI");
                    stadiumUI.innerHTML = response.stadium;
                    showNotification("Add to cart successfully");
                }
            },
            error: function () {
                alert("Error");
            }
        });
        document.getElementById("confirm-box-background").style.display = "none";
        confirmBox.reset();
        attachStadiumDragEvent();
    }

    function purchaseOne() {
        const confirmBox = document.getElementById("confirm-box");
        const seatId = confirmBox["seatId"].value;
        const orderList = document.getElementById("order-list");
        const newOrder = document.createElement("div");
        $.ajax({
           url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                action: "buyOneTicket",
                seatId: seatId
            },
            dataType: 'JSON',
            success: function (response) {

            },
            error: function () {
                alert("Error");
            }
        });
        //close confirm box
        document.getElementById("confirm-box-background").style.display = "none";
        confirmBox.reset();
    }


    function purchase(matchId) {
        if (tickets.length === 0) {
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
                if (response.loginRequired === 'true') {
                    const loginBox = document.getElementById('login');
                    loginBox.classList.add('show-login');
                } else if (response.notAvailable === 'true') {
                    showNotification("This match is not longer available for purchases ticket");
                } else if (response.isPurchased === 'true') {
                    showNotification("This seat is already purchased!");
                } else if (response.isSuccess === 'true') {
                    showNotification("Buy ticket successfully");
                    const stadiumUI = document.getElementById("stadiumUI");
                    let orderList = document.getElementById("order-list");
                    tickets = [];
                    orderList.innerText = "";
                    stadiumUI.innerHTML = response.stadium;
                    attachStadiumDragEvent();
                }
                if (response.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = response.data;
                    }
                    return false;
                } else {
                    alert(response.Message);
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
        setTimeout(function () {
            notificationBackground.style.opacity = "1";
        }, 300);
        setTimeout(function () {
            notification.style.transform = "translate(-50%, -50%) scale(1)";
        }, 300);
    }

    let currentZoom = 0.9;

    function zoomOut() {
        if (currentZoom > 0) {
            currentZoom -= 0.1;
            const stadium = document.getElementById("stadiumUI");
            stadium.style.transform = `scale(` + currentZoom + `)`;
        }
    }

    function zoomIn() {
        if (currentZoom < 2) {
            currentZoom += 0.1;
            const stadium = document.getElementById("stadiumUI");
            stadium.style.transform = `scale(` + currentZoom + `)`;
        }
    }



</script>
<script src="${pageContext.request.contextPath}/js/buyticket.js"></script>
</body>
</html>
