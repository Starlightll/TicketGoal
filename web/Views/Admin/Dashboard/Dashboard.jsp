<%--
  Created by IntelliJ IDEA.
  User: mosdd
  Date: 7/16/2024
  Time: 10:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%--
    Document   : MatchManagement
    Created on : May 24, 2024, 12:43:32 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">
<head>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Dashboard</title>

    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/dashboard/modules/bootstrap-5.1.3/css/bootstrap.css">
    <!-- Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/dashboard/css/style.css">
    <!-- FontAwesome CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/dashboard/modules/fontawesome6.1.1/css/all.css">
    <!-- Boxicons CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/dashboard/modules/boxicons/css/boxicons.min.css">
    <!-- Apexcharts  CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/dashboard/modules/apexcharts/apexcharts.css">
</head>
<body>
<!--Content Start-->
<div class="content-start transition">
    <div class="container-fluid dashboard">
        <div class="content-header">
            <h1>Dashboard</h1>
            <p></p>
        </div>

        <div class="row">

            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4 d-flex align-items-center">
                                <i class="fas fa-inbox icon-home bg-primary text-light"></i>
                            </div>
                            <div class="col-8">
                                <p>Revenue</p>
                                <h5>$65</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4 d-flex align-items-center">
                                <i class="fas fa-clipboard-list icon-home bg-success text-light"></i>
                            </div>
                            <div class="col-8">
                                <p>Orders</p>
                                <h5>3000</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4 d-flex align-items-center">
                                <i class="fas fa-chart-bar  icon-home bg-info text-light"></i>
                            </div>
                            <div class="col-8">
                                <p>Sales</p>
                                <h5>5500</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4 d-flex align-items-center">
                                <i class="fas fa-id-card  icon-home bg-warning text-light"></i>
                            </div>
                            <div class="col-8">
                                <p>Employes</p>
                                <h5>256</h5>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                    </div>
                    <div class="card-body">
                        <div id="columnchart"></div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4>Recent Messages</h4>
                    </div>
                    <div class="card-body pb-4">
                        <div class="recent-message d-flex px-4 py-3">
                            <div class="avatar avatar-lg">
                                <img src="${pageContext.request.contextPath}/css/admin/dashboard/images/message/4.jpg">
                            </div>
                            <div class="name ms-4">
                                <h5 class="mb-1">Hank Schrader</h5>
                                <h6 class="text-muted mb-0">@johnducky</h6>
                            </div>
                        </div>
                        <div class="recent-message d-flex px-4 py-3">
                            <div class="avatar avatar-lg">
                                <img src="${pageContext.request.contextPath}/css/admin/dashboard/images/message/5.jpg">
                            </div>
                            <div class="name ms-4">
                                <h5 class="mb-1">Dean Winchester</h5>
                                <h6 class="text-muted mb-0">@imdean</h6>
                            </div>
                        </div>
                        <div class="recent-message d-flex px-4 py-3">
                            <div class="avatar avatar-lg">
                                <img src="${pageContext.request.contextPath}/css/admin/dashboard/images/message/1.jpg">
                            </div>
                            <div class="name ms-4">
                                <h5 class="mb-1">John Doe</h5>
                                <h6 class="text-muted mb-0">@Doejohn</h6>
                            </div>
                        </div>
                        <div class="px-4">
                            <button class='btn btn-block btn-xl btn-primary font-bold mt-3'>Start
                                Conversation</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4>Latest Transaction</h4>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th scope="col">Order Id</th>
                                    <th scope="col">Billing Name</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Total</th>
                                    <th scope="col">Payment Status</th>
                                    <th scope="col">Payment Method</th>
                                    <th scope="col">View Details</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th scope="row">#SK2548	</th>
                                    <td>Neal Matthews</td>
                                    <td>07 Oct, 2022</td>
                                    <td>$400</td>
                                    <td><span class="text-success">Paid</span></td>
                                    <td>Mastercard</td>
                                    <td><button class="btn btn-primary">View Details</button></td>
                                </tr>

                                <tr>
                                    <th scope="row">#SK2548	</th>
                                    <td>Neal Matthews</td>
                                    <td>07 Oct, 2022</td>
                                    <td>$400</td>
                                    <td><span class="text-success">Paid</span></td>
                                    <td>Visa</td>
                                    <td><button class="btn btn-primary">View Details</button></td>
                                </tr>

                                <tr>
                                    <th scope="row">#SK2548	</th>
                                    <td>Neal Matthews</td>
                                    <td>07 Oct, 2022</td>
                                    <td>$400</td>
                                    <td><span class="text-danger">Chargeback</span></td>
                                    <td>Paypal</td>
                                    <td><button class="btn btn-primary">View Details</button></td>
                                </tr>

                                <tr>
                                    <th scope="row">#SK2548	</th>
                                    <td>Neal Matthews</td>
                                    <td>07 Oct, 2022</td>
                                    <td>$400</td>
                                    <td><span class="text-warning">Refund</span></td>
                                    <td>Visa</td>
                                    <td><button class="btn btn-primary">View Details</button></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="sidebar-overlay"></div>








<!-- Preloader -->
<div class="loader">
    <div class="spinner-border text-light" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>

<!-- Loader -->
<div class="loader-overlay"></div>

<!-- General JS Scripts -->
<script src="${pageContext.request.contextPath}/css/admin/dashboard/js/atrana.js"></script>

<!-- JS Libraies -->
<script src="${pageContext.request.contextPath}/css/admin/dashboard/modules/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/css/admin/dashboard/modules/bootstrap-5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/css/admin/dashboard/modules/popper/popper.min.js"></script>

<!-- Chart Js -->
<script src="${pageContext.request.contextPath}/css/admin/dashboard/modules/apexcharts/apexcharts.js"></script>
<script src="${pageContext.request.contextPath}/css/admin/dashboard/js/ui-apexcharts.js"></script>

<!-- Template JS File -->
<script src="${pageContext.request.contextPath}/css/admin/dashboard/js/script.js"></script>
<script src="${pageContext.request.contextPath}/css/admin/dashboard/js/custom.js"></script>
</body>
</html>

