<%-- 
    Document   : AddPitch
    Created on : May 25, 2024, 9:42:46 AM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/pitch/addpitch.css">
</head>
<body>
<div class="add__pitch">
    <form name="addPitchForm" method="POST" action="addPitchServlet" onsubmit="return validateForm()"
          enctype="multipart/form-data">
        <div class="pitch__container">
            <div class="pitch__info">
                <table>
                    <tr class="pitch__name">
                        <td>Name:</td>
                        <td>
                            <input type="text" name="pitchName" placeholder="Pitch Name" value="${pitchName}"
                                   id="pitchNameInput" required><br>
                            <span id="nameError" class="error"></span>
                        </td>
                    </tr>
                    <tr class="pitch__address">
                        <td>Address:</td>
                        <td>
                            <input type="text" name="pitchAddressName" placeholder="Address Name" value="${addressName}"
                                   id="pitchAddressInput" required>
                            <input type="url" name="pitchAddressURL" placeholder="Pitch Address URL"
                                   value="${addressURL}" required><br>
                            <span id="addressNameError" class="error"></span>

                        </td>
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
                <input type="file" id="upload-button" name="pitchImage" accept="image/*">
                <label for="upload-button"><i class="ri-upload-2-line"></i>Upload Image</label>
            </div>
        </div>
        <span id="formError" class="error"></span><br>
        <button type="submit">Add Pitch</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/js/admin/pitch/addpitch.js"></script>
<script type="text/javascript">
    function validateName() {
        var pitchName = document.forms["addPitchForm"]["pitchName"].value.trim();
        var nameError = document.getElementById("nameError");

        if (pitchName === "") {
            nameError.innerText = "Name must be filled out";
            return false;
        } else {
            nameError.innerText = "";
            return true;
        }
    }

    function validateAddressName() {
        var addressName = document.forms["addPitchForm"]["pitchAddressName"].value.trim();
        var nameError = document.getElementById("addressNameError");

        if (addressName === "") {
            nameError.innerText = "Address name must be filled out";
            return false;
        } else {
            nameError.innerText = "";
            return true;
        }

    }

    function validateForm() {
        var isNameValid = validateName();
        var isAddressNameValid = validateAddressName();
        var formError = document.getElementById("formError");
        if (!isNameValid || !isAddressNameValid) {
            formError.innerText = "Please fill all field";
        }
        return isNameValid && isAddressNameValid;
    }

    window.onload = function () {
        document.getElementById("pitchNameInput").addEventListener("input", validateName);
        document.getElementById("pitchAddressInput").addEventListener("input", validateAddressName);
    }
</script>
</body>
</html>
