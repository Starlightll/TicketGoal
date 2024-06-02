<%-- 
    Document   : AddPlayer
    Created on : May 25, 2024, 12:01:26 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Player</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/player/addplayer.css"/>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var today = new Date();

                var minDate = new Date(today.getFullYear() - 50, today.getMonth(), today.getDate());
                var maxDate = new Date(today.getFullYear() - 16, today.getMonth(), today.getDate());

                var minDateString = minDate.toISOString().split('T')[0];
                var maxDateString = maxDate.toISOString().split('T')[0];

                var input = document.getElementById('playerBirth');
                input.setAttribute('min', minDateString);
                input.setAttribute('max', maxDateString);
            });

            function validateForm() {
                var form = document.forms["addPlayerForm"];
                var requiredFields = ["playerName", "playerNumber", "playerCountry", "playerRoleId", "playerBirth", "playerHeight", "playerWeight", "playerImage"];
                var valid = true;
                var errorMessages = [];

                requiredFields.forEach(function(field) {
                    if (form[field].value.trim() === "") {
                        valid = false;
                        errorMessages.push(field + " is required.");
                    }
                });

                if (!valid) {
                    alert(errorMessages.join("\n"));
                }

                return valid;
            }
        </script>
    </head>
    <body>
        <div class="add__player">
            <form name="addPlayerForm" method="POST" action="playerAddServlet" onsubmit="return validateForm();" enctype="multipart/form-data">
                <div class="player__detail">
                    <table border="0">
                        <tr>
                            <td>Name: </td>
                            <td><input type="text" name="playerName"></td>
                        </tr>
                        <tr>
                            <td>Number: </td>
                            <td><input type="text" name="playerNumber"></td>
                        </tr>
                        <tr>
                            <td>Country: </td>
                            <td>
                                <select name="playerCountry">
                                    <option value="1">Viet Nam</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Role: </td>
                            <td>
                                <select name="playerRoleId">
                                    <option value="1">Goalkeeper</option>
                                    <option value="2">Defender</option>
                                    <option value="3">Midfielder</option>
                                    <option value="4">Forward</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Birth: </td>
                            <td><input type="date" id="playerBirth" name="playerBirth"></td>
                        </tr>
                        <tr>
                            <td>Height: </td>
                            <td><input type="number" min="150" name="playerHeight"></td>
                        </tr>
                        <tr>
                            <td>Weight: </td>
                            <td><input type="number" min="50" name="playerWeight"></td>
                        </tr>
                        <tr>
                            <td>Biography: </td>
                            <td><textarea name="playerBio"></textarea></td>
                        </tr>
                    </table>
                </div>
                <div class="player__performance">
                    <table border="0">
                        <tr>
                            <td>ATK: </td>
                            <td class="performance"><input type="range" min="0" max="100" name="ATK"></td>
                        </tr>
                        <tr>
                            <td>DEF: </td>
                            <td class="performance"><input type="range" min="0" max="100" name="DEF"></td>
                        </tr>
                        <tr>
                            <td>SPD: </td>
                            <td class="performance"><input type="range" min="0" max="100" name="SPD"></td>
                        </tr>
                    </table>
                </div>
                <div class="player__image">
                    <input type="file" name="playerImage" accept="image/*">
                </div>
                <div class="add__button">
                    <button type="submit">Add</button>
                </div>
            </form>
        </div>
    </body>
</html>
