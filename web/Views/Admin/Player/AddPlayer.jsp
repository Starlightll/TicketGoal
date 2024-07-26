<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
            var requiredFields = ["playerName", "playerNumber", "playerCountry", "playerRoleId", "playerBirth", "playerHeight", "playerWeight", "playerBio", "playerImage"];
            var valid = true;
            var errorMessages = [];

            var nameField = form["playerName"];
            var nameValue = nameField.value.trim();
            var nameRegex = /^[a-zA-Z\s]*$/; // Only letters and spaces

            if (!nameRegex.test(nameValue)) {
                valid = false;
                errorMessages.push("Player name must not contain special characters.");
                nameField.style.border = "2px solid red";
            } else {
                nameField.style.border = "";
            }

            requiredFields.forEach(function (field) {
                var fieldElement = form[field];
                var trimmedValue = fieldElement.value.trim();
                if (trimmedValue === "") {
                    valid = false;
                    errorMessages.push(fieldElement.name + " is required.");
                    fieldElement.style.border = "2px solid red";
                } else {
                    fieldElement.style.border = "";
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
                    <td>Name:</td>
                    <td><input type="text" name="playerName" required></td>
                </tr>
                <tr>
                    <td>Number:</td>
                    <td><input type="text" name="playerNumber" required></td>
                </tr>
                <tr>
                    <td>Country:</td>
                    <td>
                        <select name="playerCountry" required>
                            <option value="1">Viet Nam</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Role:</td>
                    <td>
                        <select name="playerRoleId" required>
                            <option value="1">Goalkeeper</option>
                            <option value="2">Defender</option>
                            <option value="3">Midfielder</option>
                            <option value="4">Forward</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Birth:</td>
                    <td><input type="date" id="playerBirth" name="playerBirth" required></td>
                </tr>
                <tr>
                    <td>Height:</td>
                    <td><input type="number" min="150" name="playerHeight" required></td>
                </tr>
                <tr>
                    <td>Weight:</td>
                    <td><input type="number" min="50" name="playerWeight" required></td>
                </tr>
                <tr>
                    <td>Biography:</td>
                    <td><textarea name="playerBio" required></textarea></td>
                </tr>
            </table>
        </div>
        <div class="player__performance">
            <table border="0">
                <tr>
                    <td>ATK:</td>
                    <td class="performance"><input type="range" min="0" max="100" name="ATK" required></td>
                </tr>
                <tr>
                    <td>DEF:</td>
                    <td class="performance"><input type="range" min="0" max="100" name="DEF" required></td>
                </tr>
                <tr>
                    <td>SPD:</td>
                    <td class="performance"><input type="range" min="0" max="100" name="SPD" required></td>
                </tr>
            </table>
        </div>
        <div class="player__image">
            <input type="file" name="playerImage" accept="image/*" required>
        </div>
        <div class="add__button">
            <button type="submit">Add</button>
        </div>
    </form>
</div>
</body>
</html>
