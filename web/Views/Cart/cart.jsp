
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cart Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="stylesheet" href="./css/cart.css"/>
    </head>
    <body>
        <div class="header-container">
            <%@include file="/Views/include/header.jsp" %>
        </div>
        <main>
            <div class="cart-summary">
                <form action="cart">
                    <div class="search-bar" style="display: flex; gap: 5px; align-items: center ">
                        <div style="display: flex; flex: 1; gap: 5px;">
                            <input type="text" name="clubInput" id="clubInput" placeholder="Search...">
                            <button class="btn btn-primary" onclick="searchTickets(event)">Search</button>
                        </div>
                        <div> 
                            <select style="padding: 9px; width: 100px" onchange="sortByPrice(event, this.value)">
                                <option value="false">Sort by price</option>
                                <option value="true">Sort asc by price</option>
                                <option value="false">Sort desc by price</option>
                            </select>
                        </div>
                    </div>
                    <div class="selected-ticket-info">
                        <h4>Information ticket:</h4>
                        <div id="selected-ticket-info"></div>
                        <p id="total-price-selected">No have product: 0</p>
                    </div>
                    <button type="button" class="purchase-button" onclick="checkout('')">Purchase</button>
                    <a href="history-payment" class="btn btn-primary" style="text-decoration: none; color: #000; font-size: 14px">History-payment</a>
                </form>
            </div>
            <div class="cart-items" id="cart-items">
                <c:forEach var="ticket" items="${listTickets}">
                    <div class="cart-item" id="cart-item">
                        <div class="ticket-info">
                            <div class="image-placeholder">
                                <div class="box-clubname">
                                    <p class="club1">${ticket.match.club1.clubName}</p>
                                    <p class="divider"></p>
                                    <p class="club2">${ticket.match.club2.clubName}</p>
                                </div>
                            </div>
                            <div class="ticket-details">
                                <p>Area: ${ticket.seat.area.areaName}</p>
                                <p>Seat number: ${ticket.seat.seatNumber}</p>
                                <p>Price: ${ticket.seat.price}</p>
                                <p>Date: ${ticket.match.schedule}</p>
                            </div>
                        </div>
                        <div class="delete-icon">
                            <input type="checkbox" class="ticket-checkbox"
                                   data-price="${ticket.seat.price}"
                                   data-area="${ticket.seat.area.areaName}"
                                   data-seat="${ticket.seat.seatNumber}"
                                   data-date="${ticket.match.schedule}"
                                   onClick="handleChoose(this)"
                                   name="selectedTickets"
                                   value="${ticket.ticketId}"
                                   >
                            <span onClick="deleteTicket(${ticket.ticketId}, ${ticket.cartId})"><i class="fas fa-trash"></i></span>
                        </div>
                    </div>
                </c:forEach>
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
                        <button type="button" onclick="purchase('')">CHECKOUT</button>
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
        </main>     
        <script src="./js/cart.js"></script>
    <script>
        function checkPromotion(){
            const cartItem = document.getElementById("cart-items");
            const selectedTickets = [];
            const checkboxes = cartItem.querySelectorAll("input[name='selectedTickets']:checked");

            checkboxes.forEach((checkbox) => {
                selectedTickets.push(checkbox.value);
            });

            if (selectedTickets.length === 0) {
                showNotification("Please select at least one ticket to checkout")
                return;
            }
            const promotionCode = document.getElementById("promotion-code").value;
            const checkPromoMsg = document.getElementById("check-promo-msg");
            $.ajax({
                url: `${pageContext.request.contextPath}/checkout`,
                method: "POST",
                data: {
                    promotionCode: promotionCode,
                    selectedTickets: JSON.stringify(selectedTickets)
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
            const cartItem = document.getElementById("cart-items");
            const selectedTickets = [];
            const checkboxes = cartItem.querySelectorAll("input[name='selectedTickets']:checked");

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
            const cartItem = document.getElementById("cart-items");
            const selectedTickets = [];
            const checkboxes = cartItem.querySelectorAll("input[name='selectedTickets']:checked");
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
    </script>
    </body>
</html>
