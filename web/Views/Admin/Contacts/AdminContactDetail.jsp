<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .header {
                padding: 15px 0;
            }
                       .header .nav__link {
                font-size: 2rem;
            }
            
            .header .join__button {
                font-size: 19px;
            }
            
            .header .nav__cart {
                font-size: 2.5rem;
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

            .email .nav.nav-pills>li>a {
                border-top: 3px solid transparent;
            }

            .email .nav.nav-pills>li>a>.fa {
                margin-right: 5px;
            }

            .email .nav.nav-pills>li.active>a,
            .email .nav.nav-pills>li.active>a:hover {
                background-color: #f6f6f6;
                border-top-color: #3c8dbc;
            }

            .email .nav.nav-pills>li.active>a {
                font-weight: 600;
            }

            .email .nav.nav-pills>li>a:hover {
                background-color: #f6f6f6;
            }

            .email .nav.nav-pills.nav-stacked>li>a {
                color: #666;
                border-top: 0;
                border-left: 3px solid transparent;
                border-radius: 0px;
            }

            .email .nav.nav-pills.nav-stacked>li.active>a,
            .email .nav.nav-pills.nav-stacked>li.active>a:hover {
                background-color: #f6f6f6;
                border-left-color: #3c8dbc;
                color: #444;
            }

            .email .nav.nav-pills.nav-stacked>li.header {
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

            .email table tr.read>td {
                background-color: #f6f6f6;
            }

            .email table tr.read>td {
                font-weight: 400;
            }

            .email table tr td>i.fa {
                font-size: 1.2em;
                line-height: 1.5em;
                text-align: center;
            }

            .email table tr td>i.fa-star {
                color: #f39c12;
            }

            .email table tr td>i.fa-bookmark {
                color: #e74c3c;
            }

            .email table tr>td.action {
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
            .grid .grid-header>.fa {
                display: inline-block;
                margin: 0;
                font-weight: 300;
                font-size: 1.5em;
                float: left;
            }

            .grid .grid-header span {
                padding: 0 5px;
            }

            .grid .grid-header>.fa {
                padding: 5px 10px 0 0;
            }

            .grid .grid-header>.grid-tools {
                padding: 4px 10px;
            }

            .grid .grid-header>.grid-tools a {
                color: #999999;
                padding-left: 10px;
                cursor: pointer;
            }

            .grid .grid-header>.grid-tools a:hover {
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

            .grid.top.black>.grid-header {
                border-top-color: #000000 !important;
            }

            .grid.bottom.black>.grid-body {
                border-bottom-color: #000000 !important;
            }

            .grid.top.blue>.grid-header {
                border-top-color: #007be9 !important;
            }

            .grid.bottom.blue>.grid-body {
                border-bottom-color: #007be9 !important;
            }

            .grid.top.green>.grid-header {
                border-top-color: #00c273 !important;
            }

            .grid.bottom.green>.grid-body {
                border-bottom-color: #00c273 !important;
            }

            .grid.top.purple>.grid-header {
                border-top-color: #a700d3 !important;
            }

            .grid.bottom.purple>.grid-body {
                border-bottom-color: #a700d3 !important;
            }

            .grid.top.red>.grid-header {
                border-top-color: #dc1200 !important;
            }

            .grid.bottom.red>.grid-body {
                border-bottom-color: #dc1200 !important;
            }

            .grid.top.orange>.grid-header {
                border-top-color: #f46100 !important;
            }

            .grid.bottom.orange>.grid-body {
                border-bottom-color: #f46100 !important;
            }

            .grid.no-border>.grid-header {
                border-bottom: 0px !important;
            }

            .grid.top>.grid-header {
                border-top-width: 4px !important;
                border-top-style: solid !important;
            }

            .grid.bottom>.grid-body {
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
                                            <li ${requestScope.category == '1' ? 'class="active"' : ''}><a href="ContactAdminServlet"><i class="fa fa-inbox"></i> Inbox</a></li>
                                            <li ${requestScope.category == '4' ? 'class="active"' : ''}><a href="ContactAdminServlet?cate=4"><i class="fa fa-star"></i> Starred</a></li>
                                            <li ${requestScope.category == '3' ? 'class="active"' : ''}><a href="ContactAdminServlet?cate=3"><i class="fa fa-bookmark"></i> Important</a></li>
                                            <li ${requestScope.category == '2' ? 'class="active"' : ''}><a href="ContactAdminServlet?cate=2"><i class="fa fa-mail-forward"></i> Sent</a></li>
                                        </ul>
                                    </div>
                                    <a class="btn btn-block btn-primary" data-toggle="modal" data-target="#reply"><i
                                            class="fa fa-pencil"></i>&nbsp;&nbsp;REPLY</a>
                                    <hr>
                                </div>


                                <div class="col-md-9">
                                    <div class="row">
                                        <h2>Name : ${contact.name}</h2>
                                        <h3>Email : ${contact.email}</h3>
                                        <h3>Created Date : <fmt:formatDate value="${contact.createdDate}" var="formattedDate" 
                                                        type="date" pattern="MM-dd-yyyy"/>
                                            ${formattedDate}</h3>
                                        <p>${contact.message}</p>
                                    </div>
                                </div>


                                <div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-wrapper">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header bg-blue">
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-hidden="true">×</button>
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
                                                            <textarea name="message" id="email_message" class="form-control"
                                                                      placeholder="Message" style="height: 120px;"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default"
                                                                data-dismiss="modal"><i class="fa fa-times"></i>
                                                            Discard</button>
                                                        <button type="submit" class="btn btn-primary pull-right"><i
                                                                class="fa fa-envelope"></i> Send Message</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="reply" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-wrapper">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header bg-blue">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    <h4 class="modal-title"><i class="fa fa-envelope"></i> REPLY MESSAGE</h4>
                                                </div>
                                                <form id="replyForm" action="SendMessageServlet" method="post" onsubmit="return validateReplyForm()">
                                                    <div class="modal-body">
                                                        <div class="form-group">
                                                            <input name="to" type="email" class="form-control" placeholder="To" required="" value="${contact.email}" readonly="">
                                                        </div>
                                                        <div class="form-group">
                                                            <input name="subject" type="text" class="form-control" placeholder="Subject" required="" value="${contact.message}" readonly="">
                                                        </div>
                                                        <div class="form-group">
                                                            <textarea name="message" id="reply_message" class="form-control" placeholder="Message" style="height: 120px;" required=""></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>
                                                        <button type="submit" class="btn btn-primary pull-right"><i class="fa fa-envelope"></i> Send Message</button>
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
function validateReplyForm() {
                var message = document.getElementById('reply_message').value.trim();
                if (message === "") {
                    alert("Message field cannot be empty.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
