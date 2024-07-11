<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Simple email inbox page - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body {
            background: #eee;
        }

        /* EMAIL */
        .email {
            padding: 20px 10px 15px 10px;
            font-size: 1em;
        }

        .email .btn.search {
            font-size: 0.9em;
        }

        .email h2 {
            margin-top: 0;
            padding-bottom: 8px;
        }

        .email .nav.nav-pills > li > a {
            border-top: 3px solid transparent;
        }

        .email .nav.nav-pills > li > a > .fa {
            margin-right: 5px;
        }

        .email .nav.nav-pills > li.active > a,
        .email .nav.nav-pills > li.active > a:hover {
            background-color: #f6f6f6;
            border-top-color: #3c8dbc;
        }

        .email .nav.nav-pills > li.active > a {
            font-weight: 600;
        }

        .email .nav.nav-pills > li > a:hover {
            background-color: #f6f6f6;
        }

        .email .nav.nav-pills.nav-stacked > li > a {
            color: #666;
            border-top: 0;
            border-left: 3px solid transparent;
            border-radius: 0px;
        }

        .email .nav.nav-pills.nav-stacked > li.active > a,
        .email .nav.nav-pills.nav-stacked > li.active > a:hover {
            background-color: #f6f6f6;
            border-left-color: #3c8dbc;
            color: #444;
        }

        .email .nav.nav-pills.nav-stacked > li.header {
            color: #777;
            text-transform: uppercase;
            position: relative;
            padding: 0px 0 10px 0;
        }

        .email table {
            font-weight: 600;
        }

        .email table a {
            color: #666;
        }

        .email table tr.read > td {
            background-color: #f6f6f6;
        }

        .email table tr.read > td {
            font-weight: 400;
        }

        .email table tr td > i.fa {
            font-size: 1.2em;
            line-height: 1.5em;
            text-align: center;
        }

        .email table tr td > i.fa-star {
            color: #f39c12;
        }

        .email table tr td > i.fa-bookmark {
            color: #e74c3c;
        }

        .email table tr > td.action {
            padding-left: 0px;
            padding-right: 2px;
        }

        .grid {
            position: relative;
            width: 100%;
            background: #fff;
            color: #666666;
            border-radius: 2px;
            margin-bottom: 25px;
            box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
        }


        .grid .grid-header:after {
            clear: both;
        }

        .grid .grid-header span,
        .grid .grid-header > .fa {
            display: inline-block;
            margin: 0;
            font-weight: 300;
            font-size: 1.5em;
            float: left;
        }

        .grid .grid-header span {
            padding: 0 5px;
        }

        .grid .grid-header > .fa {
            padding: 5px 10px 0 0;
        }

        .grid .grid-header > .grid-tools {
            padding: 4px 10px;
        }

        .grid .grid-header > .grid-tools a {
            color: #999999;
            padding-left: 10px;
            cursor: pointer;
        }

        .grid .grid-header > .grid-tools a:hover {
            color: #666666;
        }

        .grid .grid-body {
            padding: 15px 20px 15px 20px;
            font-size: 0.9em;
            line-height: 1.9em;
        }

        .grid .full {
            padding: 0 !important;
        }

        .grid .transparent {
            box-shadow: none !important;
            margin: 0px !important;
            border-radius: 0px !important;
        }

        .grid.top.black > .grid-header {
            border-top-color: #000000 !important;
        }

        .grid.bottom.black > .grid-body {
            border-bottom-color: #000000 !important;
        }

        .grid.top.blue > .grid-header {
            border-top-color: #007be9 !important;
        }

        .grid.bottom.blue > .grid-body {
            border-bottom-color: #007be9 !important;
        }

        .grid.top.green > .grid-header {
            border-top-color: #00c273 !important;
        }

        .grid.bottom.green > .grid-body {
            border-bottom-color: #00c273 !important;
        }

        .grid.top.purple > .grid-header {
            border-top-color: #a700d3 !important;
        }

        .grid.bottom.purple > .grid-body {
            border-bottom-color: #a700d3 !important;
        }

        .grid.top.red > .grid-header {
            border-top-color: #dc1200 !important;
        }

        .grid.bottom.red > .grid-body {
            border-bottom-color: #dc1200 !important;
        }

        .grid.top.orange > .grid-header {
            border-top-color: #f46100 !important;
        }

        .grid.bottom.orange > .grid-body {
            border-bottom-color: #f46100 !important;
        }

        .grid.no-border > .grid-header {
            border-bottom: 0px !important;
        }

        .grid.top > .grid-header {
            border-top-width: 4px !important;
            border-top-style: solid !important;
        }

        .grid.bottom > .grid-body {
            border-bottom-width: 4px !important;
            border-bottom-style: solid !important;
        }
    </style>
</head>
<body>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container">
    <div class="row">

        <div class="col-md-12">
            <div class="grid email">
                <div class="grid-body">
                    <div class="row">

                        <div class="col-md-3">
                            <h2 class="grid-title"><i class="fa fa-inbox"></i> Inbox</h2>
                            <a class="btn btn-block btn-primary" data-toggle="modal" data-target="#compose-modal"><i
                                    class="fa fa-pencil"></i>&nbsp;&nbsp;NEW MESSAGE</a>
                            <hr>
                            <div>
                                <ul class="nav nav-pills nav-stacked">
                                    <li class="header">Folders</li>
                                    <li ${requestScope.category == '1' ? 'class="active"' : ''}><a
                                            href="ContactAdminServlet"><i class="fa fa-inbox"></i> Inbox</a></li>
                                    <li ${requestScope.category == '4' ? 'class="active"' : ''}><a
                                            href="ContactAdminServlet?cate=4"><i class="fa fa-star"></i> Starred</a>
                                    </li>
                                    <li ${requestScope.category == '3' ? 'class="active"' : ''}><a
                                            href="ContactAdminServlet?cate=3"><i class="fa fa-bookmark"></i>
                                        Important</a></li>
                                    <li ${requestScope.category == '2' ? 'class="active"' : ''}><a
                                            href="ContactAdminServlet?cate=2"><i class="fa fa-mail-forward"></i>
                                        Sent</a></li>
                                </ul>
                            </div>
                        </div>


                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label style="margin-right: 8px;" class>
                                        <div class="icheckbox_square-blue" style="position: relative;"><input
                                                type="checkbox" id="check-all" class="icheck"
                                                style="position: absolute; top: -20%; left: -20%; display: block; width: 140%; height: 140%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);">
                                            <ins
                                                    class="iCheck-helper"
                                                    style="position: absolute; top: -20%; left: -20%; display: block; width: 140%; height: 140%; margin: 0px; padding: 0px; border: 0px; opacity: 0; background: rgb(255, 255, 255);"></ins>
                                        </div>
                                    </label>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-default dropdown-toggle"
                                                data-toggle="dropdown">
                                            Action <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a onclick="UpdateContact(1)" href="#">Mark as read</a></li>
                                            <li><a onclick="UpdateContact(2)" href="#">Mark as unread</a></li>
                                            <li><a onclick="UpdateContact(3)" href="#">Mark as important</a></li>
                                            <li><a onclick="UpdateContact(4)" href="#">Mark as Starred</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-6 search-form">
                                    <form action="ContactAdminServlet" class="text-right">
                                        <div class="input-group">
                                            <input name="search" type="text" class="form-control input-sm"
                                                   placeholder="Search" value="${requestScope.search}">
                                            <span class="input-group-btn">
                                                        <button type="submit" name="search"
                                                                class="btn_ btn-primary btn-sm search"><i
                                                                class="fa fa-search"></i></button></span>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="padding"></div>
                            <div class="table-responsive">
                                <table class="table">
                                    <tbody>
                                    <c:forEach items="${requestScope.list}" var="item">
                                        <tr ${item.checkRead() eq true ? 'class="read"' : ''}>
                                            <td class="action"><input class="" name="options" type="checkbox"
                                                                      value="${item.id}"/></td>
                                            <td class="action">
                                                <i ${item.checkStarred() eq true ? 'class="fa fa-star"' : 'class="fa fa-star-o"'}></i>
                                            </td>
                                            <td class="action">
                                                <i ${item.checkImportant() eq true ? 'class="fa fa-bookmark"' : 'class="fa fa-bookmark-o"'}></i>
                                            </td>
                                            <td class="name"><a href="#">${item.email}</a></td>
                                            <td class="subject"><a
                                                    href="MessageDetailServlet?id=${item.id}">${item.title}</a></td>
                                            <td class="time">
                                                <fmt:formatDate value="${item.createdDate}" var="formattedDate"
                                                                type="date" pattern="MM-dd-yyyy"/>
                                                    ${formattedDate}
                                            </td>
                                            <td class="delete"><a href="DeleteMessageServlet?id=${item.id}"><i
                                                    class="fa fa-trash-o"></i></a></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <ul class="pagination">
                                <c:if test="${requestScope.pagenum > 1}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/ContactAdminServlet?pagenum=${requestScope.pagenum - 1}">«</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1"
                                           end="${requestScope.totalPage > requestScope.pagenum + 2 ? (requestScope.pagenum + 2) : requestScope.totalPage}"
                                           var="item">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/ContactAdminServlet?pagenum=${item}">${item}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${requestScope.pagenum < requestScope.totalPage}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/ContactAdminServlet?pagenum=${requestScope.pagenum + 1}">»</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>


                        <div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-wrapper">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header bg-blue">
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-hidden="true">×
                                            </button>
                                            <h4 class="modal-title"><i class="fa fa-envelope"></i> Compose New
                                                Message</h4>
                                        </div>
                                        <form action="SendMessageServlet" method="post">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <input name="to" type="email" class="form-control"
                                                           placeholder="To" required="">
                                                </div>
                                                <div class="form-group">
                                                    <input name="subject" type="text" class="form-control"
                                                           placeholder="Subject" required="">
                                                </div>
                                                <div class="form-group">
                                                            <textarea name="message" id="email_message"
                                                                      class="form-control"
                                                                      placeholder="Message" style="height: 120px;"
                                                                      required=""></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default"
                                                        data-dismiss="modal"><i class="fa fa-times"></i>
                                                    Discard
                                                </button>
                                                <button type="submit" class="btn btn-primary pull-right"><i
                                                        class="fa fa-envelope"></i> Send Message
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function UpdateContact(i) {
        var checkboxes = document.querySelectorAll('input[name="options"]:checked');
        var checkedValues = [];
        checkboxes.forEach(function (checkbox) {
            checkedValues.push(checkbox.value);
        });
        var queryParams = checkedValues.map(function (value) {
            return encodeURIComponent("option") + "=" + encodeURIComponent(value);
        }).join("&");
        window.location.href = '${pageContext.request.contextPath}/UpdateContact?cate=' + i + '&' + queryParams;
    }
</script>
</body>
</html>
