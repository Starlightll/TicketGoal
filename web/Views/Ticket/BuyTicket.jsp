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
        <div class="stadium">
            <div>
                <img src="${pageContext.request.contextPath}/img/StadiumV1.png" alt="stadium">
                <%--top side outler--%>
                <div class="top__side__outler">
                    <div class="area__ARO">
                        <c:forEach var="seat" items="${seatsARO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__ALO">
                        <c:forEach var="seat" items="${seatsALO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--down side--%>
                <div class="down__side__outler">
                    <div class="area__CRO">
                        <c:forEach var="seat" items="${seatsCRO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="area__CLO">
                        <c:forEach var="seat" items="${seatsCLO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--left side--%>
                <div class="left__side__outler">
                    <div class="area__DLO">
                        <c:forEach var="seat" items="${seatsDLO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default"></i></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <%--right side--%>
                <div class="right__side__outler">
                    <div class="area__BRO">
                        <c:forEach var="seat" items="${seatsBRO}">
                            <c:if test="${seat.seatStatusId == 1}">
                                <a onclick="showConfirm(${seat.seatId}, ${seat.seatNumber}, ${seat.row}, ${seat.price})">
                                    <div class="seat"><i class="ri-layout-top-2-fill" style=""></i></div>
                                </a>
                            </c:if>
                            <c:if test="${seat.seatStatusId == 3}">
                                <div class="seat"><i class="ri-layout-top-2-fill" style="color: #ff4747; cursor: default;"></i></div>
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
                        <div id="total-value">0 $</div>
                    </div>
                    <div style="width: 100%; height: 4px; background-color: #999aa5; margin: 0 auto"></div>
                </div>
                <div class="action">
                    <button id="btn-buy" type="button" onclick="checkout(${matchId})">Buy</button>
                    <button id="btn-add-to-cart">Add to cart</button>
                </div>
            </form>
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
                <button>Purchase</button>
                <button class="add__list_btn" onclick="addToList()" type="button"><i class="ri-add-line"></i></button>
            </div>
        </form>
    </div>
</main>
<script>
    const tickets = [];

    function showConfirm(seatId, seatNumber, row, price) {
        document.getElementById("confirm-box-background").style.display = "block";
        document.getElementById("seat-number-value").innerHTML = seatNumber;
        document.getElementById("row-value").innerHTML = row;
        document.getElementById("price-value").innerHTML = price + " $";
        document.getElementById("seat-id").innerHTML = seatId;
        document.forms["confirm-box"]["seatId"].value = seatId;
        document.forms["confirm-box"]["seatNumber"].value = seatNumber;
        document.forms["confirm-box"]["row"].value = row;
        document.forms["confirm-box"]["price"].value = price;
    }

    function addToList(){
        const confirmBox = document.getElementById("confirm-box");
        let seatId = confirmBox["seatId"].value;
        let seatNumber = confirmBox["seatNumber"].value;
        let price = confirmBox["price"].value;
        let row = confirmBox["row"].value;
        let orderList = document.getElementById("order-list");
        let totalValue = document.getElementById("total-value");
        let newOrder = document.createElement("div");
        if(tickets.includes(seatId)){
            alert("This seat is already in the list");
            confirmBox.reset();
            return;
        }else{
            tickets.push(seatId);
            newOrder.className = "order";
            newOrder.innerHTML = "<div style='background-color: #ff0044; width: 100%; height: 50px; margin-bottom: 4px; border-radius: 10px'>"+seatNumber+"</div>";
            orderList.appendChild(newOrder);
            let totalValueNumber = parseInt(totalValue.innerHTML.split(" ")[0]);
            let priceNumber = parseInt(price.split(" ")[0]);
            totalValue.innerHTML = (totalValueNumber + priceNumber) + " $";
            confirmBox.reset();
        }
        //close confirm box
        document.getElementById("confirm-box-background").style.display = "none";
    }


    function checkout(matchId) {
        var matchIds = matchId;
        $.ajax({
            url: `${pageContext.request.contextPath}/BuyTicket`,
            method: "POST",
            data: {
                matchId: matchIds,
                seatIds: JSON.stringify(tickets)
            },
            success: function (response) {
                location.reload();
            },
            error: function () {
                alert("Error");
            }
        });
    }


</script>
<script src="${pageContext.request.contextPath}/js/buyticket.js"></script>
</body>
</html>
