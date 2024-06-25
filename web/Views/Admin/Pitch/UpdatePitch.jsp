<%-- 
    Document   : UpdatePitch
    Created on : May 25, 2024, 9:42:59 AM
    Author     : mosdd
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/pitch/updatepitch.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <div class="update__pitch">
            <form method="POST" action="updatePitchServlet?pitchId=${pitch.pitchId}" enctype="multipart/form-data">
                <div class="pitch__container">
                    <div class="pitch__info">
                        <table>
                            <tr class="pitch__name">
                                <td>Name:</td>
                                <td><input type="text" name="pitchName" placeholder="Pitch Name" value="${pitch.pitchName}"></td>
                            </tr>
                            <tr class="pitch__address">
                                <td>Address:</td>
                                <td>
                                    <input type="text" name="pitchAddressName" placeholder="Address Name" value="${pitch.addressName}">
                                    <input type="url" name="pitchAddressURL" placeholder="Pitch Address URL" value="${pitch.addressURL}">
                                </td>
                            </tr>
                            <tr class="pitch__structure">
                                <td>Structure:</td>
                                <td>
                                    <img id="uploaded-structure" src="data:image/jpeg;base64,${pitch.pitchStructure}" alt="">
                                    <input id="upload-structure" type="file" accept="image/*" name="newPitchStructure">
                                    <input type="hidden" name="existingStructure" value="${pitch.pitchStructure}">
                                    <label for="upload-structure"><i class="ri-upload-2-line"></i>Upload Structure</label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pitch__image">
                        <img id="uploaded-image" src="data:image/jpeg;base64,${pitch.image}" alt="">
                        <input id="upload-image" type="file" accept="image/*" name="newPitchImage">
                        <input type="hidden" id="existing-image" name="existingImage" value="${pitch.image}">
                        <label for="upload-image"><i class="ri-upload-2-line"></i>Upload Image</label>
                    </div>
                </div>
                <div class="area__container">
                    <div class="add__button">
                        <button type="button" id="area-add-button">Add</button>
                    </div>
                    <div class="area__box" id="area-box">
                        <c:forEach items="${requestScope.AreaList}" var="area">
                            <div class="area">
                                <p class="area__name">
                                    ${area.areaName}
                                </p>
                                <div class="area__management">
                                    <a href="?option=update&pitchId=${pitch.pitchId}&areaId=${area.id}"  type="button" class="seat__management" id="seat-management-button">Seat</a>
                                    <button onclick="deleteArea(${area.id})" type="button" class="delete__button">Delete</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="area__add__box" id="area-add-box">
                    <input type="hidden" id="pitchId" value="${pitch.pitchId}">
                    <div class="box">
                        <i class="ri-close-line" id="area-add-close-button"></i>
                        <p>Name:<p> <input type="text" name="areaName" id="areaName" placeholder="Enter area name">
                            <button onclick="addArea()" type="button" class="add__button" id="area-add-submit-button">Add</button>
                    </div>
                </div>
                <div class="seat__management__box ${param.areaId > 0 ? "show-seat-management-box" : ""}" id="seat-management-box">
                    <div class="seat__management__header">
                        <div class="seat__management__search">
                            <input type="search" name="searchInput">
                            <select name="seatCategory">
                                <option value="1">Price Increase</option>
                                <option value="2">Price Decrease</option>
                                <option value="3">Number Increase</option>
                                <option value="4">Number Decrease</option>
                            </select>
                        </div>
                        <span style="color: #fff">${param.message}</span>
                        <div class="seat__management__import">
                            <a style="color: #fff; font-size: 16px;" href="seat?action=import&areaId=${param.areaId}&pitchId=${pitch.pitchId}" class="import__excel" type="submit">Import</a> 
                            <button style="font-size: 16px;color: #fff; background: transparent; border: none; outline: none; text-decoration: underline" type="button" class="add__button" id="seat-add-button">Add Seat</button>
                            <a style="font-size: 16px;color: #fff" href="seat?action=deleteAll&areaId=${param.areaId}&pitchId=${pitch.pitchId}" class="delete__all">Delete All</a> 
                        </div>
                    </div>
                    <div class="seat__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Seat Number</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Manager</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${seatList}" var="seat">
                                    <c:set value="${getStatus.getSeatStatusById(seat.seatStatusId)}" var="statusSeat" />
                                    <tr>
                                        <td>${seat.seatNumber}</td>
                                        <td>${seat.price}</td>
                                        <td>${statusSeat != null ? statusSeat.statusName :  "N/A"}</td>
                                        <td>
                                            <a style="color: #fff" href="seat?action=edit&pitchId=${pitch.pitchId}&seatId=${seat.seatId}" class="update__button">Update</a>  
                                            <a style="color: #fff" href="seat?action=delete&pitchId=${pitch.pitchId}&seatId=${seat.seatId}&areaId=${seat.areaId}" class="delete__button">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <button type="button" id="seat-management-submit-button">Submit</button> 
                    <button type="button" id="seat-management-cancel-button">Cancel</button>
                </div>
                <button type="submit">Update Pitch</button>
            </form>
        </div>
        <div class="overlay" id="seat-add-overlay" style="display: none;"></div>
        <div class="seat__add__box" id="seat-add-box" style="display: none;">
            <div class="form__container">
                <h2>Add Seat</h2>
                <form id="seat-add-form" action="seat?action=add" method="POST">
                    <input type="hidden" value="${pitch.pitchId}" name="pitchId" />
                    <label>Seat Number:</label>
                    <input min="1" type="number" id="seatNumber" name="seatNumber" required>

                    <label>Price:</label>
                    <input min="1" type="number" id="price" name="price" required>

                    <label>Area ID:</label>
                    <input type="number" name="areaId" required value="${param.areaId != null ? param.areaId : 0}" readonly>

                    <label>Seat Status ID:</label>
                    <select name="seatStatusId">
                        <c:forEach items="${seatStatus}" var="statusSeat">
                            <option value="${statusSeat.seatStatusId}">${statusSeat.statusName}</option>
                        </c:forEach>
                    </select>
                    <button type="button" onclick="document.querySelector('#seat-add-form').submit();">Save</button>
                    <button type="button" id="seat-add-cancel-button">Cancel</button>
                </form>
            </div>

        </div>
        <div id="toastBox"></div>
        <script src="${pageContext.request.contextPath}/js/admin/pitch/updatepitch.js"></script>
        <script>
                        function attachEventListeners() {
                            const seatManagementBox = document.getElementById("seat-management-box");
                            const seatManagementSubmitBtn = document.getElementById("seat-management-submit-button");
                            const seatManagementCancelBtn = document.getElementById("seat-management-cancel-button");

                            const seatManagementBtns = document.querySelectorAll(".seat__management");

                            seatManagementBtns.forEach(btn => {
                                btn.addEventListener('click', () => {
                                    seatManagementBox.classList.add('show-seat-management-box');
                                });
                            });

                            if (seatManagementSubmitBtn) {
                                seatManagementSubmitBtn.addEventListener('click', () => {
                                    seatManagementBox.classList.remove("show-seat-management-box");
                                });
                            }

                            if (seatManagementCancelBtn) {
                                seatManagementCancelBtn.addEventListener('click', () => {
                                    seatManagementBox.classList.remove("show-seat-management-box");
                                });
                            }
                        }

                        function addArea() {
                            var areaName = $("#areaName").val();
                            var pitchId = $("#pitchId").val();
                            $.ajax({
                                url: `${pageContext.request.contextPath}/AreaServlet`,
                                method: "POST",
                                data: {
                                    areaName: areaName,
                                    pitchId: pitchId,
                                    action: "add"
                                },
                                success: function (response) {
                                    var areaBox = document.getElementById("area-box");
                                    areaBox.innerHTML = response;
                                    attachEventListeners();
                                    showToast("<i class=\"ri-checkbox-circle-fill\"></i>added area successfully");
                                },
                                error: function () {
                                    showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Duplicated name!");
                                }
                            });
                        }

                        function deleteArea(areaId) {

                            var pitchId = $("#pitchId").val();
                            $.ajax({
                                url: `${pageContext.request.contextPath}/AreaServlet`,
                                method: "POST",
                                data: {
                                    areaId: areaId,
                                    pitchId: pitchId,
                                    action: "delete"
                                },
                                success: function (response) {
                                    var areaBox = document.getElementById("area-box");
                                    areaBox.innerHTML = response;
                                    attachEventListeners();
                                    showToast('<i class="ri-checkbox-circle-fill"></i>Deleted area successfully');
                                },
                                error: function () {
                                    showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: The area has seats!");
                                }
                            });
                        }

                        document.addEventListener('DOMContentLoaded', attachEventListeners);

                        let toastBox = document.getElementById('toastBox');

                        function showToast(msg) {
                            let toast = document.createElement('div');
                            toast.classList.add('toast');
                            toast.innerHTML = msg;
                            toastBox.appendChild(toast);

                            if (msg.includes('Invalid:')) {
                                toast.classList.add('invalid');
                            }

                            setTimeout(() => {
                                toast.remove();
                            }, 3000);
                        }
        </script>
    </body>
</html>
