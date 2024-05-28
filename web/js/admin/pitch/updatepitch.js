document.addEventListener('DOMContentLoaded', (event) => {
    const seatAddBox = document.getElementById("seat-add-box"),
          seatAddBtn = document.getElementById("seat-add-button"),
          seatAddForm = document.getElementById("seat-add-form"),
          seatAddCancelBtn = document.getElementById("seat-add-cancel-button"),
          mainForm = document.querySelector(".update__pitch form");

//    // Ngăn chặn việc submit form ngoài cùng
//    mainForm.addEventListener('submit', (e) => {
//        e.preventDefault();
//    });

    // Mở form pop-up để thêm ghế
    seatAddBtn.addEventListener('click', () => {
        seatAddBox.style.display = 'block';
    });

    // Đóng form pop-up khi nhấn cancel
    seatAddCancelBtn.addEventListener('click', () => {
        seatAddBox.style.display = 'none';
    });

});

let uploadImage = document.getElementById("upload-image");
let uploadedImage = document.getElementById("uploaded-image");
uploadImage.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadImage.files[0]);
    console.log(uploadImage.files[0]);
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

const areaAddBtn = document.getElementById("area-add-button"),
        areaCloseBtn = document.getElementById("area-add-close-button"),
        areaAddBox = document.getElementById("area-add-box"),
        areaAddSubmitBtn = document.getElementById("area-add-submit-button");
areaAddBtn.addEventListener('click', () => {
    areaAddBox.classList.add("show-area-add-box");
});

areaAddSubmitBtn.addEventListener('click', () => {
    areaAddBox.classList.remove("show-area-add-box");
});

areaCloseBtn.addEventListener('click', () => {
    areaAddBox.classList.remove("show-area-add-box");
});


const seatManagementBox = document.getElementById("seat-management-box"),
        seatManagementBtn = document.getElementById("seat-management-button"),
        seatManagementSubmitBtn = document.getElementById("seat-management-submit-button"),
        seatManagementCancelBtn = document.getElementById("seat-management-cancel-button");

if (seatManagementBtn) {
    seatManagementBtn.addEventListener('click', () => {
        seatManagementBox.classList.add('show-seat-management-box');
    });
}
seatManagementSubmitBtn.addEventListener('click', () => {
    seatManagementBox.classList.remove("show-seat-management-box");
});
seatManagementCancelBtn.addEventListener('click', () => {
    seatManagementBox.classList.remove("show-seat-management-box");
});
