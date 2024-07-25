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
        <style>
            .current-index {

                border: 1px solid blue;
                border-radius: 1px;
            }
        </style>
    </head>
    <c:set var="searchQuery" value="${param.q}" />
    <body>
        <div class="container">
            <h2 style="color:red">${message}</h2>
            <div class="top-bar">
                <button id="add-new-promotion-btn" class="add-btn" >Add</button>
                <a href="./promotionManagement" class="add-btn" style='background-color:green'>Reload</a>
                <form action="./promotionManagement" method="GET">
                    <input type="text" id="search-bar-input" class="search-bar" placeholder="Search..." name='q' value="${searchParam}">
                    <button type="submit" style="display: none"/>
                </form>
            </div>
            <div class="white-bar"></div>
            <!--Table-->
            <div style="width: 100%;
                 margin-top: 40px;">
                <table id="operatorTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable('promotionId')">ID <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable('promotionCode')">Code <i class="fas fa-sort" ></i></th>
                            <th>Match </th>
                            <th onclick="sortTable('promotionStartDate')">Start Date <i class="fas fa-sort" ></i></th>
                            <th onclick="sortTable('promotionEndDate')">End Date <i class="fas fa-sort" ></i></th>
                            <th >Discount</th>
                            <th>Action <i class="fas fa-sort" ></i></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${promotions}" var="promotion">
                            <tr>
                                <td>${promotion.promotionId}</td>
                                <td>${promotion.promotionCode}</td>
                                <td> ${MatchDAO.getMatch(promotion.promotionMatchId).getClub1().getClubName()} vs ${MatchDAO.getMatch(promotion.promotionMatchId).getClub2().getClubName()}</td>
                                <td>${promotion.promotionStartDate}</td>
                                <td>${promotion.promotionEndDate}</td>
                                <td>${promotion.promotionDiscount}</td>
                                <td class="action-buttons" style="display: flex">
                                    <button onclick="viewPromotion(${promotion.promotionId})">👁️</button>
                                    <button onclick="editPromotion(${promotion.promotionId})">✏️</button>
                                    <form action="./promotionManagement" method="POST">
                                        <input type="hidden" name="type" value="delete"/>
                                        <input type="hidden" name="id" value="${promotion.promotionId}"/>
                                        <button type="submit"><i class="fas fa-trash"></i></button>
                                    </form>

                                </td>
                            </tr>
                            <!-- View Modal -->
                        <div id="viewPromotionModal${promotion.promotionId}" class="modal">
                            <div class="modal-content">
                                <span class="close-btn" onclick="document.getElementById('viewPromotionModal${promotion.promotionId}').style.display = 'none'">&times;</span>
                                <h2>Promotion ${promotion.promotionId} Detail</h2>
                                <div class="modal-body">
                                    <p>ID: <span id="modalOperatorId">${promotion.promotionId}</span></p>
                                    <p>Code: <span id="modalOperatorUsername">${promotion.promotionCode}</span></p>
                                    <p>Description : <span id="modalOperatorEmail">${promotion.promotionDescription}</span></p>
                                    <p>Start Date: <span id="modalOperatorPhone">${promotion.promotionStartDate}</span></p>
                                    <p>End Date <span id="modalOperatorGender">${promotion.promotionEndDate}</span></p>
                                    <p>Discount <span id="modalOperatorGender">${promotion.promotionDiscount}</span></p>
                                    <p>Match :  <span id="modalOperatorGender">
                                            ${MatchDAO.getMatch(promotion.promotionMatchId).getClub1().getClubName()} vs ${MatchDAO.getMatch(promotion.promotionMatchId).getClub2().getClubName()}</span></p>
                                </div>
                            </div>
                        </div>
                        <!-- Edit Modal -->
                        <div id="editPromotionModal${promotion.promotionId}" class="modal">
                            <div class="modal-content">
                                <span class="close-btn" onclick="document.getElementById('editPromotionModal${promotion.promotionId}').style.display = 'none'">&times;</span>
                                <h2>Edit Promotion ${promotion.promotionId}</h2>
                                <div class="modal-body">
                                    <form method="POST" action="./promotionManagement" onsubmit="">
                                        <input type="hidden" name="type" value="update" />
                                        <input type="hidden" name="id" value="${promotion.promotionId}" />
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="code">Code : </label>
                                                <input type="text" name='code' required value="${promotion.promotionCode}">
                                            </div>
                                            <div class="form-group">
                                                <label for="operatorDescription">Description:</label>
                                                <textarea  rows="4" cols="50" name='description' required value="${promotion.promotionDescription}">${promotion.promotionDescription}</textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="startDate">Start Date:</label>
                                                <input type="datetime-local" id="startDate" name="startDate" required value="${promotion.promotionStartDate}">
                                            </div>
                                            <div class="form-group">
                                                <label for="endDate">End Date:</label>
                                                <input type="datetime-local" id="endDate" name="endDate" required value="${promotion.promotionEndDate}">
                                            </div>
                                            <div class="form-group">
                                                <label for="code">Discount : </label>
                                                  <input type="number"  required value="${promotion.promotionDiscount}" class="create-discount" name='promotionDiscount' required min="1" max="100">
                                            </div>
                                            <div class="form-group">
                                                <label for="promotionMatch">Promotion Match: </label>
                                                <select id="promotionMatch" name="promotionMatch" required>
                                                    <c:forEach items="${listMatch}" var="match">
                                                        <option value="${match.matchId}"  ${match.matchId == promotion.promotionMatchId ? "selected" : ""}>
                                                            ${match.club1.getClubName()} vs ${match.club2.getClubName()}
                                                        </option>
                                                    </c:forEach>
                                                </select>

                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit">Save</button>
                                                <button type="button" onclick="document.getElementById('editPromotionModal${promotion.promotionId}').style.display = 'none'">Cancel</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!--pagination-->
            <div class="pagination">
                <button  class="prev-page" onclick="window.location.href = './promotionManagement?index=${pageIndex -1}'"  ${pageIndex <= 1 ? "disabled" : ""}>Previous</button> 
                <c:forEach begin="1" end="${totalPage}" var="i">
                    <span class="page-numbers ${pageIndex == i ? "current-index" : ""}">${i}</span>
                </c:forEach>
                <button class="next-page"  onclick="window.location.href = './promotionManagement?index=${pageIndex + 1}'"  ${pageIndex < totalPage ? "" : "disabled"} >Next</a></button>
            </div>
        </div>
        <div id="modals-container">
            <!-- Modals will be appended here by JavaScript -->
        </div>
        <!--Add New-->
        <div id="new-promotion" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="document.getElementById('new-promotion').style.display = 'none'">&times;</span>
                <h2>New Promotion</h2>
                <form method="POST" action="./promotionManagement">
                    <input type="hidden" name="type" value="create" />
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="code">Code : </label>
                            <input type="text" name='code' required>
                        </div>
                        <div class="form-group">
                            <label for="operatorDescription">Description:</label>
                            <textarea  rows="4" cols="50" name='description' required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="startDate">Start Date:</label>
                            <input type="datetime-local" id="startDate" name="startDate" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">End Date:</label>
                            <input type="datetime-local" id="endDate" name="endDate" required>
                        </div>
                        <div class="form-group">
                            <label for="code">Discount : </label>
                            <input type="number"  class="create-discount" name='promotionDiscount' required min="1" max="100">
                        </div>
                        <div class="form-group">
                            <label for="promotionMatch">Promotion Match: </label>
                            <select id="promotionMatch" name="promotionMatch" required>
                                <c:choose>
                                    <c:when test="${empty listMatch}">
                                        <option value="">No available match</option>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${listMatch}" var="match">
                                            <option value="${match.matchId}">${match.club1.getClubName()} vs ${match.club2.getClubName()}</option>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="submit">Save</button>
                            <button type="button" onclick="document.getElementById('new-promotion').style.display = 'none'">Cancel</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function sortTable(sortParam) {
            const url = new URL(window.location.href);
            url.searchParams.set('sort', sortParam);
            window.location.href = url.toString();
        }
     document.querySelectorAll('.create-discount').forEach(function(element) {
        element.oninput = function() {
            if (this.value < 0) {
                this.value = 0;
            } else if (this.value > 100) {
                this.value = 100;
            }
        };
    });
    </script>
    <script src="${pageContext.request.contextPath}/js/validate.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin/promotion/promotionManagement.js"></script>

</html>