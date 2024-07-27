<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 6/18/2024
  Time: 6:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buyticket.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/TicketGoalfavicon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/fontawesome.min.css"
          integrity="sha512-UuQ/zJlbMVAw/UU8vVBhnI4op+/tFOpQZVT+FormmIEhRSCnJWyHiBbEVgM4Uztsht41f3FzVWgLuwzUqOObKw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
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
                                                     style="color: #aaff00; cursor: default"
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
                                                     style="color: #aaff00; cursor: default"
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
                                                     style="color: #aaff00; cursor: default"
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
                                                     style="color: #aaff00; cursor: default"
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
                                                     style="color: #aaff00; cursor: default"
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
                                                     style="color: #aaff00; cursor: default"
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
            <form id="order-detail">
                <div class="order__detail__header">
                    <div>Order Detail</div>
                </div>
                <div class="order__list" id="order-list">
                    <c:forEach var="ticket" items="${ticketInCart}">
                        <div class="item" onmouseover="hover(${ticket.seat.seatId})"
                        onmouseout="removeHover(${ticket.seat.seatId})" id="item-${ticket.ticketId}">
                            <div>
                                <div class="area">Area: ${ticket.seat.area.areaName}</div>
                                <div class="row">Row: ${ticket.seat.row}</div>
                                <div class="seat">Seat: ${ticket.seat.seatNumber}</div>
                            </div>
                            <div style="display: flex; flex-direction: column; justify-content: space-between; align-items: end;">
                                <label>
                                    <input type="checkbox" name="selectedTickets" value="${ticket.ticketId}">
                                </label>
                                <div class="price">
                                    <div>
                                        Price: <fmt:setLocale value="vi_VN"/>
                                        <fmt:formatNumber value="${ticket.seat.price}" type="currency"/>
                                    </div>
                                    <i class="ri-delete-bin-6-line"
                                       style="color: #ff4f51; font-size: large; padding-left: 5px; cursor: pointer"
                                       onclick="removeTicket(${ticket.ticketId}, ${ticket.seat.seatId}, ${ticket.match.matchId})"></i>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="checkout">
                    <div style="width: 100%; height: 4px; background-color: #999aa5; margin: 0 auto"></div>
                    <div class="total">
                        <div>Total:</div>
                        <div id="total-value"><fmt:setLocale value="vi_VN"/>
                            <fmt:formatNumber value="${requestScope.total}" type="currency"/></div>
                    </div>
                    <div style="width: 100%; height: 4px; background-color: #999aa5; margin: 0 auto"></div>
                </div>
                <div class="action">
                    <button id="btn-buy" type="button" onclick="checkout('')">Buy</button>
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
<%--                <button id="btn-buy-one" type="button" onclick="purchaseOne()">Buy</button>--%>
                <button class="add__list_btn" onclick="addToCart()" type="button"><i class="ri-add-line"></i></button>
            </div>
        </form>
    </div>
    <div class="checkout__box__background" id="checkout-box-background">
        <form class="checkout__box" id="checkout-box">
            <i class="ri-close-large-fill close__btn" id="btn-close-checkout"></i>
            <div class="checkout__detail">
                <p>Tickets</p>
                <div class="item__list" id="item-list">

                </div>
                <p>Order summary</p>
                <div class="checkout__amount">
                    <div class="amount__detail">
                        <div class="total__item">
                            <div id="total-item"></div>
                            <div id="item-total-price">0</div>
                        </div>
                        <div class="service__fee">
                            <div>service fee</div>
                            <div id="service-fee">0</div>
                        </div>
                        <div class="discount">
                            <div>discount</div>
                            <div id="discount-amount">0</div>
                        </div>
                    </div>
                    <div class="total__amount">
                        <div>Total</div>
                        <div id="total-amount"></div>
                    </div>
                </div>
                <p id="check-promo-msg" style="font-size: 14px; margin: 0; font-weight: normal; width: 300px"></p>
                <div class="promotion__box">
                    <label>
                        <input type="text" placeholder="Promotion code" name="promotionCode" id="promotion-code">
                    </label>
                    <button type="button" onclick="checkPromotion()">Apply</button>
                </div>
            </div>
            <div class="checkout__action">
                <button type="button" onclick="purchase('${matchId}')">CHECKOUT</button>
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

        // Mouse events
        stadiumUI.addEventListener('mousedown', mouseDown);
        // Touch events
        stadiumUI.addEventListener('touchstart', touchStart);

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

            moveStadium(newX, newY);
        }

        function mouseUp(e) {
            document.removeEventListener('mousemove', mouseMove);
            document.removeEventListener('mouseup', mouseUp);
        }

        function touchStart(e) {
            e.preventDefault();
            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;
            document.addEventListener('touchmove', touchMove);
            document.addEventListener('touchend', touchEnd);
        }

        function touchMove(e) {
            e.preventDefault();
            newX = e.touches[0].clientX - startX;
            newY = e.touches[0].clientY - startY;

            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;

            moveStadium(newX, newY);
        }

        function touchEnd(e) {
            document.removeEventListener('touchmove', touchMove);
            document.removeEventListener('touchend', touchEnd);
        }

        function moveStadium(deltaX, deltaY) {
            stadiumUI.style.top = (stadiumUI.offsetTop + deltaY) + "px";
            stadiumUI.style.left = (stadiumUI.offsetLeft + deltaX) + "px";
        }
    }

    function showConfirm(areaName, seatId, seatNumber, row, price) {
        document.getElementById("confirm-box-background").style.display = "block";
        document.getElementById("area-name").innerHTML = "Area: " + areaName;
        document.getElementById("seat-number-value").innerHTML = seatNumber;
        document.getElementById("row-value").innerHTML = row;
        document.getElementById("price-value").innerHTML = Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(price);
        document.getElementById("seat-id").innerHTML = seatId;
        const confirmBox = document.getElementById("confirm-box");
        confirmBox["seatId"].value = seatId;
        confirmBox["seatNumber"].value = seatNumber;
        confirmBox["row"].value = row;
        confirmBox["price"].value = price;
    }

    let tickets = [];

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
                    const totalValue = document.getElementById("total-value");
                    const newOrder = document.createElement("div");
                    newOrder.innerHTML = response.addedTicket;
                    orderList.appendChild(newOrder);
                    const stadiumUI = document.getElementById("stadiumUI");
                    stadiumUI.innerHTML = response.stadium;
                    totalValue.innerHTML = Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(response.total);
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
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                action: "buyOneTicket",
                seatId: seatId
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
                } else if (response.code === '00') {
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
        //close confirm box
        document.getElementById("confirm-box-background").style.display = "none";
        confirmBox.reset();
    }

    function checkPromotion(){
        const promotionCode = document.getElementById("promotion-code").value;
        const checkPromoMsg = document.getElementById("check-promo-msg");
        $.ajax({
            url: `${pageContext.request.contextPath}/checkout`,
            method: "POST",
            data: {
                promotionCode: promotionCode
            },
            dataType: 'JSON',
            success: function (response) {
                if(response.valid === true){
                    checkPromoMsg.innerHTML = response.message;
                    checkPromoMsg.style.color = "#40ff67";
                    checkout(promotionCode);
                } else {
                    checkPromoMsg.innerHTML = response.message;
                    checkPromoMsg.style.color = "#ff4f51";
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }

    function checkout(promotionCode) {
        const orderDetail = document.getElementById("order-detail");
        const selectedTickets = [];
        const checkboxes = orderDetail.querySelectorAll("input[name='selectedTickets']:checked");

        checkboxes.forEach((checkbox) => {
            selectedTickets.push(checkbox.value);
        });

        if (selectedTickets.length === 0) {
            showNotification("Please select at least one ticket to checkout")
            return;
        }

        $.ajax({
            url: `${pageContext.request.contextPath}/checkout`,
            method: "GET",
            data: {
                selectedTickets: JSON.stringify(selectedTickets),
                promotionCode: promotionCode
            },
            dataType: 'JSON',
            success: function (response) {
                // Clear current list
                const itemList = document.getElementById("item-list");
                const totalItem = document.getElementById("total-item");
                const itemTotalPrice = document.getElementById("item-total-price");
                const serviceFee = document.getElementById("service-fee");
                const discountAmount = document.getElementById("discount-amount");
                const totalAmount = document.getElementById("total-amount");
                itemList.innerHTML = "";
                const ticket = document.createElement("div");
                ticket.innerHTML = response.tickets;
                itemList.appendChild(ticket);
                totalItem.innerHTML = "Tickets("+ response.totalItem + ")";
                itemTotalPrice.innerHTML = Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(response.totalPrice);
                serviceFee.innerHTML = Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(response.serviceFee);
                discountAmount.innerHTML = Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(response.discount) + " (" + response.discountPercent +")";
                totalAmount.innerHTML = Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(response.finalPrice);
                let checkoutBox = document.getElementById("checkout-box-background");
                checkoutBox.style.display = "block";
            },
            error: function () {
                let checkoutBox = document.getElementById("checkout-box-background");
                checkoutBox.style.display = "block";
            }
        });
    }



    function purchase(matchId) {
        const orderDetail = document.getElementById("order-detail");
        const selectedTickets = [];
        const checkboxes = orderDetail.querySelectorAll("input[name='selectedTickets']:checked");
        checkboxes.forEach((checkbox) => {
            selectedTickets.push(checkbox.value);
        });
        if (selectedTickets.length === 0) {
            showNotification("Please select at least one ticket to checkout")
            return;
        }
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                action: "buyTicket",
                matchId: matchId,
                tickets: JSON.stringify(selectedTickets)
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
                } else if (response.code === '00') {
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
                alert("123");
            }
        });
    }

    function removeTicket(ticketId, seatId, matchId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/BuyTicket',
            method: "POST",
            data: {
                action: "removeFromCart",
                ticketId: ticketId,
                matchId: matchId
            },
            dataType: 'JSON',
            success: function (response) {
                if (response.isSuccess === 'true') {
                    const ticket = document.getElementById("item-" + ticketId);
                    const totalValue = document.getElementById("total-value");
                    ticket.remove();
                    const stadiumUI = document.getElementById("stadiumUI");
                    stadiumUI.innerHTML = response.stadium;
                    totalValue.innerHTML = Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(response.total);
                    showNotification("Remove ticket successfully");
                }
            },
            error: function () {
                alert("Error");
            }
        })
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

    function hover(seatId) {
        const seat = document.getElementById("seat-" + seatId);
        seat.style.color = '#56c6ff';
    }

    function removeHover(seatId) {
        const seat = document.getElementById("seat-" + seatId);
        seat.style.color = '#aaff00';
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
