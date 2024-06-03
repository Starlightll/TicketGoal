var modal = document.getElementById("viewOperatorModal");
var btn = document.getElementById("openModalBtn");
var span = document.getElementsByClassName("close-btn");
console.log(span);
function viewOperator(id) {
    document.getElementById("viewOperatorModal" + id).style.display = "block";
}

function editOperator(id) {
    document.getElementById("editOperatorModal" + id).style.display = "block";
}


btn ? btn.onclick = function () {
    modal.style.display = "block";
} : null;
window.onclick = function (event) {
    if (event.target === modal) {
        modal.style.display = "none";
    }
};
function sortTable(columnIndex) {
    // Giữ lại các dòng ứng với kết quả tìm kiếm
    const visibleRows = Array.from(document.querySelector("table").rows).slice(1).filter(row => row.style.display !== "none");
    const isAscending = document.querySelector("table").querySelectorAll("th i")[columnIndex].classList.toggle("fa-sort-up");
    visibleRows.sort((rowA, rowB) => {
        const cellA = rowA.cells[columnIndex].innerText.toLowerCase();
        const cellB = rowB.cells[columnIndex].innerText.toLowerCase();
        if (cellA < cellB)
            return isAscending ? -1 : 1;
        if (cellA > cellB)
            return isAscending ? 1 : -1;
        return 0;
    });
    visibleRows.forEach(row => document.querySelector("table").tBodies[0].appendChild(row));
    document.querySelector("table").querySelectorAll("th i").forEach((icon, index) => {
        if (index === columnIndex) {
            icon.classList.toggle("fa-sort", !isAscending);
            icon.classList.toggle("fa-sort-up", isAscending);
            icon.classList.toggle("fa-sort-down", !isAscending);
        } else {
            icon.classList.remove("fa-sort-up", "fa-sort-down");
            icon.classList.add("fa-sort");
        }
    });
}

const saveOperatorDetails = (id) => {
    const username = $("#editOperatorUsername" + id).val();
    const phone = $("#editOperatorPhone" + id).val();
    const gender = $("#editOperatorGender" + id).val();
    const role = $("#editOperatorRole" + id).val();
    const status = $("#editOperatorStatus" + id).val();
    const address = $("#editOperatorAddress" + id).val();
    if (!validateField(username, "string") || !validateField(id, "number") || !validateField(phone, "phone")
            || !validateField(address, "address") || !validateField(gender, "number")
            || !validateField(role, "number") || !validateField(status, "number")) {
        return;
    }
    $.ajax({
        url: './operatorManagementServlet',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {
            id: id,
            username: username,
            phone: phone,
            gender: gender,
            role: role,
            status: status,
            address: address,
            type: "update"
        },
        success: function (response) {
            alert(response.message);
            window.location.reload();
        },
        error: function (xhr, status, error) {
            alert("Something's wrong.Try reload page");
            console.error('Error:', error);
        }
    });
};
const saveNewOperator = () => {
    const username = $("#new-operator-user-name").val();
    const email = $("#new-operator-email").val();
    const phone = $("#new-operator-phone").val();
    const gender = $("#new-operator-gender").val();
    const role = $("#new-operator-role").val();
    const status = $("#new-operator-status").val();
    const address = $("#new-operator-address").val();
    if (!validateField(username, "string") || !validateField(email, "email") || !validateField(phone, "phone")
            || !validateField(address, "address") || !validateField(gender, "number")
            || !validateField(role, "number") || !validateField(status, "number")) {
        return;
    }
    $.ajax({
        url: './operatorManagementServlet',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {
            username: username,
            phone: phone,
            email: email,
            gender: gender,
            role: role,
            status: status,
            address: address,
            type: "create"
        },
        success: function (response) {
            alert(response.message);
            window.location.reload();
        },
        error: function (xhr, status, error) {
            alert("Something's wrong.Try reload page");
            console.error('Error:', error);
        }
    });
};
const addNewOperatorBtn = document.getElementById("add-new-employee-btn");
addNewOperatorBtn?.addEventListener("click", (e) => {
    document.getElementById("new-operator").style.display = "block";
});
$(document).ready(function () {
// Load operators data from JSP into JavaScript
    const itemsPerPage = 10;
    let currentPage = 1;
    let tempOperators = null;
    let totalPages = Math.ceil(tempOperators?.length || operators.length / itemsPerPage);
    function searchTable() {
        const searchInput = document.querySelector(".search-bar").value.toLowerCase();
        // Lọc lại mảng operators thỏa mãn điều kiện tìm kiếm
        const filteredOperators = operators.filter(operator => {
            return (
                    operator.username.toLowerCase().includes(searchInput) ||
                    operator.email.toLowerCase().includes(searchInput)
                    );
        });
        console.log(filteredOperators);
        // Cập nhật lại mảng operators và totalPages
        tempOperators = filteredOperators;
        totalPages = Math.ceil(tempOperators.length / itemsPerPage);

        // Render lại dữ liệu
        renderItems(1);
    }
    $('#search-bar-input').on("keyup", () => {
        searchTable();
    });
    console.log($('#search-bar-input'));
    function renderItems(page) {
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        const paginatedItems = tempOperators ? tempOperators.slice(start, end) : operators.slice(start, end);

        const tbody = $('#operatorTable tbody');
        const modalsContainer = $('#modals-container');
        tbody.empty();
        modalsContainer.empty();

        paginatedItems.forEach(operator => {
            const row = `<tr>
                                    <td>${operator.accountId}</td>
                                    <td>${operator.username}</td>
                                    <td>${operator.email}</td>
                                    <td>${operator.phoneNumber}</td>
                                    <td>${operator.gender}</td>
                                    <td>${operator.roleId}</td>
                                    <td>${operator.accountStatusId}</td>
                                    <td class="action-buttons">
                                        <button onclick="viewOperator(${operator.accountId})">👁️</button>
                                        <button onclick="editOperator(${operator.accountId})">✏️</button>
                                    </td>
                                </tr>`;
            tbody.append(row);
            const roleOptions = listRoleJson.map(role => {
                const selected = role.roleId === operator.roleId ? 'selected' : '';
                return `<option value="${role.roleId}" ${selected}>${role.roleName}</option>`;
            }).join('');
            const statusOptions = listAccountStatusJson.map(accountStatus => {
                const selected = accountStatus.accountStatusId === operator.accountStatusId ? 'selected' : '';
                return `<option value="${accountStatus.accountStatusId}" ${selected}>${accountStatus.statusName}</option>`;
            }).join('');
            const modals = `
                        <!-- View Modal -->
                        <div id="viewOperatorModal${operator.accountId}" class="modal">
                            <div class="modal-content">
                                <span class="close-btn" onclick="document.getElementById('viewOperatorModal${operator.accountId}').style.display = 'none'">&times;</span>
                                <h2>Operator ${operator.accountId} Detail</h2>
                                <div class="modal-body">
                                    <p>ID: <span id="modalOperatorId">${operator.accountId}</span></p>
                                    <p>Username: <span id="modalOperatorUsername">${operator.username}</span></p>
                                    <p>Email: <span id="modalOperatorEmail">${operator.email}</span></p>
                                    <p>Phone: <span id="modalOperatorPhone">${operator.phoneNumber}</span></p>
                                    <p>Gender: <span id="modalOperatorGender">${operator.gender}</span></p>
                                    <p>Role: <span id="modalOperatorRole">${operator.roleId}</span></p>
                                    <p>Status: <span id="modalOperatorStatus">${operator.accountStatusId}</span></p>
                                </div>
                            </div>
                        </div>
                        <!-- Edit Modal -->
                        <div id="editOperatorModal${operator.accountId}" class="modal">
                            <div class="modal-content">
                                <span class="close-btn" onclick="document.getElementById('editOperatorModal${operator.accountId}').style.display = 'none'">&times;</span>
                                <h2>Operator ${operator.accountId} Detail</h2>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="operatorId">ID:</label>
                                        <input class="bg-gray" type="text" id="editOperatorId${operator.accountId}" value="${operator.accountId}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="operatorUsername">Username:</label>
                                        <input type="text" id="editOperatorUsername${operator.accountId}" value="${operator.username}">
                                    </div>
                                    <div class="form-group">
                                        <label for="operatorEmail">Email:</label>
                                        <input type="email" class="bg-gray" id="editOperatorEmail${operator.accountId}" value="${operator.email}">
                                    </div>
                                    <div class="form-group">
                                        <label for="operatorPhone">Phone:</label>
                                        <input type="tel" id="editOperatorPhone${operator.accountId}" value="${operator.phoneNumber}">
                                    </div>
                                    <div class="form-group">
                                        <label for="operatorAddress">Address:</label>
                                        <input type="text" id="editOperatorAddress${operator.accountId}" value="${operator.address}">
                                    </div>
                                    <div class="form-group">
                                        <label for="operatorGender">Gender:</label>
                                        <select id="editOperatorGender${operator.accountId}">
                                            <option value="1" ${operator.gender === 1 ? "selected" : ""}>Male</option>
                                            <option value="2" ${operator.gender === 2 ? "selected" : ""}>Female</option>
                                            <option value="3" ${operator.gender === 3 ? "selected" : ""}>Other</option>
                                        </select>
                                    </div>
                                     <div class="form-group">
                                        <label for="operatorRole">Role:</label>
                                        <select id="editOperatorRole${operator.accountId}">
                                            ${roleOptions}
                                        </select>
                                    </div>
                                   <div class="form-group">
                                        <label for="operatorStatus">Status:</label>
                                        <select id="editOperatorStatus${operator.accountId}">
                                            ${statusOptions}
                                        </select>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" onclick="saveOperatorDetails(${operator.accountId})">Save</button>
                                        <button type="button" onclick="document.getElementById('editOperatorModal${operator.accountId}').style.display = 'none'">Cancel</button>
                                    </div>
            
                                </div>
                            </div>
                        </div>`;

            modalsContainer.append(modals);
        });

        renderPagination();
    }

    function renderPagination() {
        $('.page-numbers').text(`Page ${currentPage} of ${totalPages}`);
        $('.prev-page').prop('disabled', currentPage === 1);
        $('.next-page').prop('disabled', currentPage === totalPages);
    }

    $('.prev-page').click(function () {
        if (currentPage > 1) {
            currentPage--;
            renderItems(currentPage);
        }
    });
    $('.next-page').click(function () {
        if (currentPage < totalPages) {
            currentPage++;
            renderItems(currentPage);
        }
    });
    renderItems(currentPage);
});