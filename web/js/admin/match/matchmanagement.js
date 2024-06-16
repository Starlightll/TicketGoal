
const btnClose = document.getElementById("btn-close"),
btnAdd = document.getElementById("btn-add"),
addForm = document.getElementById("add-form"),
adminPanel = document.getElementById("admin-panel-body");

btnClose.addEventListener("click", () => {
    addForm.classList.remove("show-add-match");
    adminPanel.style.removeProperty("overflow");
});

btnAdd.addEventListener("click", () => {
    addForm.classList.add("show-add-match");
    adminPanel.style.overflow = "hidden";
});


