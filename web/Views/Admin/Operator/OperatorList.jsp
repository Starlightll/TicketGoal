<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Operator List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/operator/operatorManagement.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<div class="container">
    <div class="top-bar">
        <button id="add-new-employee-btn" class="add-btn">Add</button>
        <input type="text" id="search-bar-input" class="search-bar" placeholder="Search...">
    </div>
    <div class="white-bar"></div>
    <!--Table-->
    <div style="width: 100%;
                 margin-top: 40px;">
        <table id="operatorTable">
            <thead>
            <tr>
                <th onclick="sortTable(0)">ID <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(1)">Name <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(2)">Email <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(3)">Phone <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(4)">Gender <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(5)">Role <i class="fas fa-sort"></i></th>
                <th onclick="sortTable(6)">Status</th>
                <th>Action <i class="fas fa-sort"></i></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <!--pagination-->
    <div class="pagination">
        <button class="prev-page" disabled>Previous</button>
        <span class="page-numbers"></span>
        <button class="next-page">Next</button>
    </div>
</div>
<div id="modals-container">
    <!-- Modals will be appended here by JavaScript -->
</div>
<!--Add New-->
<div id="new-operator" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="document.getElementById('new-operator').style.display = 'none'">&times;</span>
        <h2>New Operator</h2>
        <div class="modal-body">
            <div class="form-group">
                <label for="operatorUsername">Username:</label>
                <input type="text" id="new-operator-user-name">
            </div>
            <div class="form-group">
                <label for="operatorEmail">Email:</label>
                <input type="email" id="new-operator-email">
            </div>
            <div class="form-group">
                <label for="operatorPhone">Phone:</label>
                <input type="tel" id="new-operator-phone">
            </div>
            <div class="form-group">
                <label for="operatorAddress">Address:</label>
                <input type="text" id="new-operator-address">
            </div>
            <div class="form-group">
                <label for="operatorGender">Gender:</label>
                <select id="new-operator-gender">
                    <option value="1" ${operator.getGender() == 1 ? "selected" : null} >Male</option>
                    <option value="2" ${operator.getGender() == 2 ? "selected" : null}>Female</option>
                    <option value="3" ${operator.getGender() == 3 ? "selected" : null}>Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="operatorRole">Role:</label>
                <select id="new-operator-role">
                    <c:forEach var="role" items="${listRole}">
                        <option value="${role.getRoleId()}">${role.getRoleName()}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="operatorStatus">Status:</label>
                <select type="text" id="new-operator-status">
                    <c:forEach var="accountStatus" items="${listAccountStatus}">
                        <option value="${accountStatus.getAccountStatusId()}">${accountStatus.getStatusName()}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="saveNewOperator()">Save</button>
                <button type="button" onclick="document.getElementById('new-operator').style.display = 'none'">Cancel
                </button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    let operators = ${operatorsAsJson};
    let listRoleJson = ${listRoleJson};
    let listAccountStatusJson = ${listAccountStatusson};
</script>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script src="${pageContext.request.contextPath}/js/admin/operator/operatorManagement.js"></script>

</html>
