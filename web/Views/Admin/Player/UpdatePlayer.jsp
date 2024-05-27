<%-- 
    Document   : UpdatePlayer
    Created on : May 24, 2024, 10:32:32 PM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/player/updateplayer.css"/>
    </head>
    <body>
        <div class="update__player">
            <form method="POST" action="playerManagementServlet">
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
                                    <option value="countryId">Viet Nam</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Role: </td>
                            <td>
                                <select name="playerCountry">
                                    <option value="roleId">Defender</option>
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
                                <td class="performance"><input type="range" min="0" max="100" name="playerAtk"></td>
                            </tr>
                            <tr>
                                <td>DEF: </td>
                                <td class="performance"><input type="range" min="0" max="100" name="playerDef"></td>
                            </tr>
                            <tr>
                                <td>SPD: </td>
                                <td class="performance"><input type="range" min="0" max="100" name="playerSpd"></td>
                            </tr>
                        </table>
                </div>
                <div class="player__image">
                    <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>
                    <input type="file" name="playerImage">
                </div>
                <div class="update__button"><button type="submit">Update</button></div>
            </form>
        </div>

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
        </script>
    </body>
</html>
