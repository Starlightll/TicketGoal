<%-- 
    Document   : AddPitch
    Created on : May 25, 2024, 9:42:46 AM
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/pitch/addpitch.css">
    </head>
    <body>
        <div class="add__pitch">
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
            </form>
            <form>
                <div class="area__add__box" id="area-add-box">
                    <div class="box">
                        Name: <input type="text" name="areaName">
                        <button type="button" class="add__button" id="area-add-submit-button">Add</button>
                    </div>
                </div>
            </form>
            <form>
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
                            <button class="import__excel">Import</button>
                            <button class="add__button">Add</button>
                            <button class="update__all">Update All</button>
                            <button class="delete__all">Delete All</button>
                        </div>
                    </div>
                    <div class="seat__table">
                    <table>
                        <thead>
                            <tr>
                                <th>Seat Number</th>
                                <th>Price</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>220</td>
                                <td>Available</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>210</td>
                                <td>Available</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                    <button type="button" id="seat-management-submit-button">Submit</button>
                </div>
            </form>
        </div>
       <script src="${pageContext.request.contextPath}/js/admin/pitch/addpitch.js"></script>
    </body>
</html>
