<%-- 
    Document   : MatchManagement
    Created on : May 24, 2024, 12:43:32 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                <a class="update__button" href="${pageContext.request.contextPath}/matchManagementServlet?option=updateMatch&matchId=${match.matchId}">Update</a>
                                <button class="delete__button" type="button" onclick="deleteMatch(${match.matchId})">Delete</button>
                            </div>
                        </div>
                    </form>
                </c:forEach>
            </div>

        </div>
        <!-- Add Match Form -->
        <form name="addMatchForm" class="add__match" id="add-form" method="post" action="${pageContext.request.contextPath}/matchManagementServlet?option=addMatch">
            <div class="add__match__header">
                <h2>Add Match</h2>
                <i class="ri-close-large-fill" id="btn-close"></i>
            </div>
            <div class="match">
                <div class="match__content">
                    <div class="club__section">
                        <div class="club">
                            <img src="./img/clubLogos/AustriaVienna.png" alt="">
                            <h2 id="club-name">Name 1</h2>
                            <label>
                                <select name="club1">
                                    <option value="0">Select Club</option>
                                    <c:forEach var="club" items="${clubs}">
                                        <option value="${club.clubId}">${club.clubName}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <div class="vs"><p>VS</p></div>
                        <div class="club">
                            <img src="./img/clubLogos/AustriaVienna.png" alt="">
                            <h2>Name 1</h2>
                            <label>
                                <select name="club2">
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
                    <button class="add__button" onclick="addMatch()" type="button" id="add-submit">Add</button>
                </div>
            </div>
        </form>
        <div id="toastBox"></div>
    </body>
    <script src="${pageContext.request.contextPath}/js/admin/match/matchmanagement.js"></script>
    <script>

        function addMatch() {
            var club1Id = document.forms["addMatchForm"]["club1"].value;
            var club2Id = document.forms["addMatchForm"]["club2"].value;
            var pitchId = document.forms["addMatchForm"]["pitchId"].value;
            var schedule = document.forms["addMatchForm"]["schedule"].value;
            var status = document.forms["addMatchForm"]["status"].value;
            if(club1Id === "0" || club2Id === "0" || pitchId === "0" || schedule === ""){
                showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Please fill all fields!");
                return false;
            }else if(club1Id === club2Id){
                showToast("<i class=\"ri-error-warning-fill\"></i>Invalid: Club 1 and Club 2 must be different!");
                return false;
            }else{
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
