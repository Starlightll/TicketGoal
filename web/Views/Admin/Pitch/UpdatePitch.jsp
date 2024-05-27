<%-- 
    Document   : UpdatePitch
    Created on : May 25, 2024, 9:42:59 AM
    Author     : mosdd
--%>

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
    </head>
    <body>
        <div class="update__pitch">
            <form method="POST" action="action">
                <div class="pitch__container">
                    <div class="pitch__info">
                        <table>
                            <tr class="pitch__name">
                                <td>Name:</td>
                                <td><input type="text" name="pitchName" placeholder="Pitch Name"></td>
                            </tr>
                            <tr class="pitch__address">
                                <td>Address:</td>
                                <td><input type="text" name="pitchAddressName" placeholder="Address Name">
                                    <input type="url" name="pitchAddressURL" placeholder="Pitch Address URL"></td>
                            </tr>
                            <tr class="pitch__structure">
                                <td>Structure:</td>
                                <td><img id="uploaded-structure" src="" alt="">
                                    <input id="upload-structure" type="file" name="pitchStructure" accept="image/*">
                                    <label for="upload-structure"><i class="ri-upload-2-line"></i>Upload Structure</label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pitch__image">
                        <img id="uploaded-image" src="" alt="">
                        <input type="file" id="upload-button" accept="image/*">
                        <label for="upload-button"><i class="ri-upload-2-line"></i>Upload Image</label>
                    </div>
                </div>
                <div class="area__container">
                    <div class="add__button">
                        <button type="button" id="area-add-button">Add</button>
                    </div>
                    <div class="area__box">
                        <div class="area">
                            <p class="area__name">
                                Area Name
                            </p>
                            <div class="area__management">
                                <button type="button" class="seat__management" id="seat-management-button">Seat</button>
                                <button class="update__button">Update</button>
                                <button class="delete__button">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="area__add__box" id="area-add-box">
                    <div class="box">
                        Name: <input type="text" name="areaName">
                        <button type="button" class="add__button" id="area-add-submit-button">Add</button>
                    </div>
                </div>
                <div class="seat__management__box" id="seat-management-box">
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
                        <div class="seat__management__import">
                            <button class="import__excel">Import</button> <!-- Import từ excel theo form cột số của ghế, cột 2 giá, Area Id tự động lấy từ phần area trong phần pitch, 
                                                                          trạng thái(status) mới thêm luôn là not available-->
                            <button type="button" class="add__button" id="seat-add-button">Add Seat</button>
                            <button class="update__all">Update All</button> <!-- Chưa cần làm-->
                            <button class="delete__all">Delete All</button> <!-- Chưa cần làm -->
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
                                <tr>
                                    <td>1</td>
                                    <td>220</td>
                                    <td>NotAvailable</td>
                                    <td>
                                        <button class="update__button">Update</button> <!-- Chỉ update giá và trạng thái(status) của ghế -->
                                        <button class="delete__button">Delete</button> <!-- Chuyển trạng thái của ghế về removed -->
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>210</td>
                                    <td>NotAvailable</td>
                                    <td>
                                        <button>Update</button> <!-- Chỉ update giá và trạng thái(status) của ghế -->
                                        <button>Delete</button> <!-- Chuyển trạng thái của ghế về removed -->
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <button type="button" id="seat-management-submit-button">Submit</button> 
                    <button type="button" id="seat-management-cancel-button">Cancel</button>
                </div>
                <button type="submit">Add Pitch</button>
            </form>
        </div>
        <div class="overlay" id="seat-add-overlay" style="display: none;"></div>
        <div class="seat__add__box" id="seat-add-box" style="display: none;">
            <div class="form__container">
                <h2>Add Seat</h2>
                <form id="seat-add-form" action="seat?action=add" method="POST">
                    <label for="seatNumber">Seat Number:</label>
                    <input type="number" id="seatNumber" name="seatNumber" required>

                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" required>

                    <label for="areaId">Area ID:</label>
                    <input type="number" id="areaId" name="areaId" required>

                    <label for="seatStatusId">Seat Status ID:</label>
                    <input type="number" id="seatStatusId" name="seatStatusId" required>

                    <button type="button" onclick="document.querySelector('#seat-add-form').submit();">Save</button>
                    <button type="button" id="seat-add-cancel-button">Cancel</button>
                </form>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/admin/pitch/updatepitch.js"></script>
    </body>
</html>
