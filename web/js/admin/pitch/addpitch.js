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