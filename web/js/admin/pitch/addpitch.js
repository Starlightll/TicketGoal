/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let uploadBtn = document.getElementById("upload-button");
let uploadedImage = document.getElementById("uploaded-image");

uploadBtn.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadBtn.files[0]);
    console.log(uploadBtn.files[0]);
    reader.onload = () => {
        uploadedImage.setAttribute("src", reader.result);
    }
}

let uploadStructure = document.getElementById("upload-structure");
let uploadedStructure = document.getElementById("uploaded-structure");

uploadStructure.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadStructure.files[0]);
    console.log(uploadStructure.files[0]);
    reader.onload = () => {
        uploadedStructure.setAttribute("src", reader.result);
    }
}

const seatManagementBox = document.getElementById("seat-management-box"),
seatManagementBtn = document.getElementById("seat-management-button"),
seatManagementSubmitBtn = document.getElementById("seat-management-submit-button"),
seatManagementCancelBtn = document.getElementById("seat-management-cancel-button");

seatManagementBtn.addEventListener('click',() => {
    seatManagementBox.classList.add('show-seat-management-box');
});

seatManagementSubmitBtn.addEventListener('click', () => {
   seatManagementBox.classList.remove("show-seat-management-box") 
});

seatManagementCancelBtn.addEventListener('click', () => {
   seatManagementBox.classList.remove("show-seat-management-box") 
});

const areaAddBtn = document.getElementById("area-add-button"),
areaAddBox = document.getElementById("area-add-box"),
areaAddSubmitBtn = document.getElementById("area-add-submit-button");

areaAddBtn.addEventListener('click', () => {
    areaAddBox.classList.add("show-area-add-box");
})

areaAddSubmitBtn.addEventListener('click', () => {
    areaAddBox.classList.remove("show-area-add-box");
})