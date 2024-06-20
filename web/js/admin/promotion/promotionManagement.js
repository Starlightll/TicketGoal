// toggle add modal
const addModal = document.getElementById("new-promotion");
const addBtn = document.getElementById("add-new-promotion-btn");
if (addBtn) {
    addBtn.onclick = () => {
        addModal.style.display = (addModal.style.display === "block") ? "none" : "block";
    };
}

//toggle add and edit modal
function viewPromotion(id) {
    document.getElementById("viewPromotionModal" + id).style.display = "block";
}

function editPromotion(id) {
    document.getElementById("editPromotionModal" + id).style.display = "block";
}