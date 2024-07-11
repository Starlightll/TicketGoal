<%-- 
    Document   : MatchManagement
    Created on : May 24, 2024, 12:43:32 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/match/matchmanagement.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div class="match__management_container">
    <div class="match__header">
        <form>
            <div class="search__box">
                <input type="search" placeholder="Search">
            </div>
        </form>
        <button class="add__button" id="btn-add">Add</button>
    </div>
    <div class="line__decor"></div>
    <div class="match__list" id="match-list">
        <c:forEach var="match" items="${matches}">
            <form>
                <div class="match">
                    <div class="match__date">
                        <img src="./img/matches/DateBanner.png" alt="">
                        <div class="match__date__day">${match.getDay()}</div>
                        <div class="match__date__month">${match.getMonth()}</div>
                    </div>
                    <div class="match__content">
                        <div class="club__section">
                            <div class="club">
                                <img src="data:image/jpeg;base64,${match.club1.clubLogo}" alt="">
                                <p>${match.club1.clubName}</p>
                            </div>
                            <div class="vs"><p>VS</p></div>
                            <div class="club">
                                <img src="data:image/jpeg;base64,${match.club2.clubLogo}" alt="">
                                <p>${match.club2.clubName}</p>
                            </div>
                        </div>
                        <div class="match__location">
                            <i class="ri-map-pin-2-fill"></i>
                            <p>${match.address.getAddressName()} / ${match.getTime()}-</p>
                            <div class="match__status">
                                <c:if test="${match.matchStatusId == 1}">
                                    <p style="color: #ffbc3e">Upcoming</p>
                                </c:if>
                                <c:if test="${match.matchStatusId == 2}">
                                    <p style="color: #69e635">Ongoing</p>
                                </c:if>
                                <c:if test="${match.matchStatusId == 3}">
                                    <p style="color: #3269ff">Finished</p>
                                </c:if>
                                <c:if test="${match.matchStatusId == 4}">
                                    <p style="color: #e65155">Cancelled</p>
                                </c:if>
                            </div>
                        </div>

                    </div>
                    <div class="option">
                        <button class="update__button" type="button"
                                onclick="showUpdate(${match.matchId}, '${match.getDateTime()}', ${match.pitchId}, ${match.matchStatusId}, ${match.club1.clubId}, ${match.club2.clubId})">
                            Update
                        </button>
                        <button class="delete__button" type="button" onclick="deleteMatch(${match.matchId})">Delete
                        </button>
                    </div>
                </div>
            </form>
        </c:forEach>
    </div>

</div>
<!-- Add Match Form -->
<form name="addMatchForm" class="add__match" id="add-form" method="post"
      action="${pageContext.request.contextPath}/matchManagementServlet?option=addMatch">
    <div class="add__match__header">
        <h2>Add Match</h2>
    </div>
    <div class="match">
        <div>
            <i class="ri-close-large-fill close__btn" id="btn-close"></i>
        </div>
        <div class="match__content">
            <div class="club__section">
                <div class="club">
                    <img src="" alt="" id="club1Logo">
                    <h2 id="club1-name">Home team</h2>
                    <label>
                        <select name="club1" id="selectClub1">
                            <option value="0">Select Club</option>
                            <c:forEach var="club" items="${clubs}">
                                <option value="${club.clubId}">${club.clubName}</option>
                            </c:forEach>
                        </select>
                    </label>
                </div>
                <div class="vs"><p>VS</p></div>
                <div class="club">
                    <img src="" alt="" id="club2Logo">
                    <h2 id="club2-name">Against team</h2>
                    <label>
                        <select name="club2" id="selectClub2">
                            <option value="0">Select Club</option>
                            <c:forEach var="club" items="${clubs}">
                                <option value="${club.clubId}">${club.clubName}</option>
                            </c:forEach>
                        </select>
                    </label>
                </div>
            </div>
            <div class="stadium">
                <label>
                    <select name="pitchId">
                        <option value="0">Select Stadium</option>
                        <c:forEach var="stadium" items="${stadiums}">
                            <option value="${stadium.pitchId}">${stadium.pitchName}</option>
                        </c:forEach>
                    </select>
                </label>
            </div>
            <div class="match__time">
                <label>
                    <input type="datetime-local" name="schedule">
                </label>
            </div>
            <%--                    <div class="match__status">--%>
            <%--                        <label>--%>
            <%--                            <select name="status">--%>
            <%--                                <option value="0" selected>Select Status</option>--%>
            <%--                                <option value="1">Upcoming</option>--%>
            <%--                                <option value="2">Ongoing</option>--%>
            <%--                                <option value="3">Finished</option>--%>
            <%--                                <option value="4">Cancelled</option>--%>
            <%--                            </select>--%>
            <%--                        </label>--%>
            <%--                    </div>--%>
        </div>
        <div class="option">
            <button class="add__button" onclick="addMatch()" type="button" id="add-submit">Add</button>
        </div>
    </div>
</form>

<!-- Update Match Form -->
<form name="updateMatchForm" class="update__match" id="update-form" method="post"
      action="${pageContext.request.contextPath}/matchManagementServlet?option=updateMatch">
    <label>
        <input hidden name="matchId" value="0">
    </label>
    <div class="update__match__header">
        <h2>update Match</h2>
    </div>
    <div class="match">
        <div>
            <i class="ri-close-large-fill close__btn" id="btn-close-update"></i>
        </div>
        <div class="match__content">
            <div class="club__section">
                <div class="club">
                    <img src="" alt="" id="club1Logo-update">
                    <h2 id="club1-name-update">Home team</h2>
                    <label>
                        <select name="club1" id="selectClub1-update">
                            <option value="0">Select Club</option>
                            <c:forEach var="club" items="${clubs}">
                                <option value="${club.clubId}">${club.clubName}</option>
                            </c:forEach>
                        </select>
                    </label>
                </div>
                <div class="vs"><p>VS</p></div>
                <div class="club">
                    <img src="" alt="" id="club2Logo-update">
                    <h2 id="club2-name-update">Against team</h2>
                    <label>
                        <select name="club2" id="selectClub2-update">
                            <option value="0">Select Club</option>
                            <c:forEach var="club" items="${clubs}">
                                <option value="${club.clubId}">${club.clubName}</option>
                            </c:forEach>
                        </select>
                    </label>
                </div>
            </div>
            <div class="stadium">
                <label>
                    <select name="pitchId">
                        <option value="0">Select Stadium</option>
                        <c:forEach var="stadium" items="${stadiums}">
                            <option value="${stadium.pitchId}">${stadium.pitchName}</option>
                        </c:forEach>
                    </select>
                </label>
            </div>
            <div class="match__time">
                <label>
                    <input type="datetime-local" name="schedule">
                </label>
            </div>
            <div class="match__status">
                <label>
                    <select name="status">
                        <option value="0" selected>Select Status</option>
                        <option value="1">Upcoming</option>
                        <option value="2">Ongoing</option>
                        <option value="3">Finished</option>
                        <option value="4">Cancelled</option>
                    </select>
                </label>
            </div>
        </div>
        <div class="option">
            <button class="update__button" onclick="updateMatch()" type="button" id="update-submit">Update</button>
        </div>
    </div>
</form>
<div id="toastBox"></div>
</body>
<script src="${pageContext.request.contextPath}/js/admin/match/matchmanagement.js"></script>
<script>
    const clubInfoMap = {
        <c:forEach var="club" items="${clubs}">
        "${club.clubId}": {
            clubName: "${club.clubName}",
            clubLogo: "${club.clubLogo}"
        },
        </c:forEach>
    };


    function addMatch() {
        var club1Id = document.forms["addMatchForm"]["club1"].value;
        var club2Id = document.forms["addMatchForm"]["club2"].value;
        var pitchId = document.forms["addMatchForm"]["pitchId"].value;
        var schedule = document.forms["addMatchForm"]["schedule"].value;
        if (club1Id === "0" || club2Id === "0" || pitchId === "0" || schedule === "") {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Please fill all fields!");
            return false;
        } else if (club1Id === club2Id) {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Club 1 and Club 2 must be different!");
            return false;
        } else {
            $.ajax({
                url: `${pageContext.request.contextPath}/matchManagementServlet`,
                method: "post",
                data: {
                    club1Id: club1Id,
                    club2Id: club2Id,
                    pitchId: pitchId,
                    schedule: schedule,
                    status: status,
                    option: "addMatch"
                },
                success: function (response) {
                    var matchList = document.getElementById("match-list");
                    document.getElementById("add-form").classList.remove("show-add-match");
                    document.getElementById("admin-panel-body").style.removeProperty("overflow");
                    matchList.innerHTML = response;
                    var addMatchForm = document.forms["addMatchForm"];
                    addMatchForm.reset();
                    showToast('<i class="ri-checkbox-circle-fill"></i>Added match successfully');
                },
                error: function () {
                    showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Something wrong happened");
                }
            });
        }
    }

    function updateMatch() {
        var matchId = document.forms["updateMatchForm"]["matchId"].value;
        var club1Id = document.forms["updateMatchForm"]["club1"].value;
        var club2Id = document.forms["updateMatchForm"]["club2"].value;
        var pitchId = document.forms["updateMatchForm"]["pitchId"].value;
        var schedule = document.forms["updateMatchForm"]["schedule"].value;
        var status = document.forms["updateMatchForm"]["status"].value;
        if (club1Id === "0" || club2Id === "0" || pitchId === "0" || schedule === "" || status === "0") {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Please fill all fields!");
            return false;
        } else if (club1Id === club2Id) {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Club 1 and Club 2 must be different!");
            return false;
        } else if (schedule < new Date().toISOString().slice(0, 16) && status == 1) {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Schedule can't be upcoming!");
            return false;
        } else if (schedule > new Date().toISOString().slice(0, 16) && (status == 2 || status == 3)) {
            showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Schedule must be in upcoming!");
            return false;
        } else {
            $.ajax({
                url: `${pageContext.request.contextPath}/matchManagementServlet`,
                method: "post",
                data: {
                    matchId: matchId,
                    club1Id: club1Id,
                    club2Id: club2Id,
                    pitchId: pitchId,
                    schedule: schedule,
                    status: status,
                    option: "updateMatch"
                },
                success: function (response) {
                    var matchList = document.getElementById("match-list");
                    document.getElementById("update-form").classList.remove("show-update-match");
                    document.getElementById("admin-panel-body").style.removeProperty("overflow");
                    matchList.innerHTML = response;
                    var updateMatchForm = document.forms["updateMatchForm"];
                    updateMatchForm.reset();
                    showToast('<i class="ri-checkbox-circle-fill"></i>Updated match successfully');
                },
                error: function (res) {
                    showToast("<i class=\"ri-error-warning-fill\"></i>Error: " + res.responseText);
                }
            });
        }
    }

    function showUpdate(matchId, schedule, pitchId, status, club1, club2) {
        const updateForm = document.getElementById('update-form');
        const adminPanelBody = document.getElementById('admin-panel-body');
        const club1Name = clubInfoMap[club1].clubName;
        const club1Logo = clubInfoMap[club1].clubLogo;
        const club2Name = clubInfoMap[club2].clubName;
        const club2Logo = clubInfoMap[club2].clubLogo;

        document.getElementById('club1-name-update').innerText = club1Name;
        document.getElementById('club1Logo-update').src = `data:image/jpeg;base64,` + club1Logo;
        document.getElementById('club2-name-update').innerText = club2Name;
        document.getElementById('club2Logo-update').src = `data:image/jpeg;base64,` + club2Logo;
        document.getElementById('selectClub1-update').value = club1;
        document.getElementById('selectClub2-update').value = club2;
        document.forms['updateMatchForm']['schedule'].value = schedule;
        document.forms['updateMatchForm']['pitchId'].value = pitchId;
        document.forms['updateMatchForm']['status'].value = status;
        document.forms['updateMatchForm']['matchId'].value = matchId;
        updateForm.classList.add('show-update-match');
        adminPanelBody.style.overflow = 'hidden';

    }

    function deleteMatch(matchId) {
        var matchIds = matchId;
        $.ajax({
            url: `${pageContext.request.contextPath}/matchManagementServlet`,
            method: "POST",
            data: {
                matchId: matchIds,
                option: "deleteMatch"
            },
            success: function (response) {
                var matchList = document.getElementById("match-list");
                matchList.innerHTML = response;
                showToast('<i class="ri-checkbox-circle-fill"></i>Deleted match successfully');
            },
            error: function () {
                showToast("<i class=\"ri-error-warning-fill\"></i>Error!");
            }
        });
    }


    let toastBox = document.getElementById('toastBox');

    function showToast(msg) {
        let toast = document.createElement('div');
        toast.classList.add('toast');
        toast.innerHTML = msg;
        toastBox.appendChild(toast);

        if (msg.includes('Invalid:')) {
            toast.classList.add('invalid');
        }

        setTimeout(() => {
            toast.remove();
        }, 3000);
    }

</script>
</html>
