const btnClose = document.getElementById("btn-close"),
    btnAdd = document.getElementById("btn-add"),
    addForm = document.getElementById("add-form"),
    adminPanel = document.getElementById("admin-panel-body"),
    updateForm = document.getElementById("update-form"),
    btnCloseEdit = document.getElementById("btn-close-update");

btnClose.addEventListener("click", () => {
    addForm.classList.remove("show-add-match");
    adminPanel.style.removeProperty("overflow");
});

btnAdd.addEventListener("click", () => {
    addForm.classList.add("show-add-match");
    adminPanel.style.overflow = "hidden";
});

btnCloseEdit.addEventListener("click", () => {
    updateForm.classList.remove("show-update-match");
    adminPanel.style.removeProperty("overflow");
});


const selectClub1 = document.getElementById("selectClub1");
const selectClub2 = document.getElementById("selectClub2");
const selectClub1Update = document.getElementById("selectClub1-update");
const selectClub2Update = document.getElementById("selectClub2-update");
const club1Logo = document.getElementById("club1Logo");
const club2Logo = document.getElementById("club2Logo");
const club1Name = document.getElementById("club1-name");
const club2Name = document.getElementById("club2-name");
const club1LogoUpdate = document.getElementById("club1Logo-update");
const club2LogoUpdate = document.getElementById("club2Logo-update");
const club1NameUpdate = document.getElementById("club1-name-update");
const club2NameUpdate = document.getElementById("club2-name-update");

selectClub1.addEventListener("change", function () {
    const club1Id = selectClub1.value;
    club1Logo.src = `data:image/jpeg;base64,` + clubInfoMap[club1Id].clubLogo;
    club1Name.innerText = clubInfoMap[club1Id].clubName;
});

selectClub2.addEventListener("change", function () {
    const club2Id = selectClub2.value;
    club2Logo.src = `data:image/jpeg;base64,` + clubInfoMap[club2Id].clubLogo;
    club2Name.innerText = clubInfoMap[club2Id].clubName;
});

selectClub1Update.addEventListener("change", function () {
    const club1Id = selectClub1Update.value;
    club1LogoUpdate.src = `data:image/jpeg;base64,` + clubInfoMap[club1Id].clubLogo;
    club1NameUpdate.innerText = clubInfoMap[club1Id].clubName;
});

selectClub2Update.addEventListener("change", function () {
    const club2Id = selectClub2Update.value;
    club2LogoUpdate.src = `data:image/jpeg;base64,` + clubInfoMap[club2Id].clubLogo;
    club2NameUpdate.innerText = clubInfoMap[club2Id].clubName;
});


