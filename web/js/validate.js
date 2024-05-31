// validation.js
function validateField(value, type) {
    let isValid = true;
    let errorMessage = "";

    switch (type) {
        case "string":
            if (value.trim() === "") {
                isValid = false;
                errorMessage = "This field is required.";
            } else if (value.length > 50) {
                isValid = false;
                errorMessage = "This string is too long.";
            }
            break;
        case "email":
            const emailPattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (!emailPattern.test(value)) {
                isValid = false;
                errorMessage = "Invalid email format.";
            }
            break;
        case "phone":
            const phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(value)) {
                isValid = false;
                errorMessage = "Phone number must be 10 digits.";
            }
            break;
        case "address":
            const addressPattern = /^[a-zA-Z0-9\s,'-]*$/;
            if (value.trim() === "") {
                isValid = false;
                errorMessage = "Address is required.";
            } else if (!addressPattern.test(value)) {
                isValid = false;
                errorMessage = "Invalid address format.";
            }
            break;
        case "number":
            const numberPattern = /^[0-9]+$/;
            if (value.trim() === "") {
                isValid = false;
                errorMessage = "This field is required.";
            } else if (!numberPattern.test(value)) {
                isValid = false;
                errorMessage = "Invalid number format.";
            }
            break;
        default:
            isValid = false;
            errorMessage = "Invalid validation type.";
    }
    errorMessage && alert(errorMessage);
    return isValid;
}
