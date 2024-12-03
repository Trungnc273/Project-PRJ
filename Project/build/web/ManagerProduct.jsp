<%-- 
    Document   : ManagerProduct
    Created on : 10 thg 10, 2024, 19:04:40
    Author     : TRUNG
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="model.Account"%>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Lấy session và kiểm tra xem có Admin đã đăng nhập không
    Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Purple Admin</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="assets/vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css">
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <!-- End Plugin css for this page -->
        <!-- inject:css -->
        <!-- endinject -->
        <!-- Layout styles -->
        <link rel="stylesheet" href="assets/css/style.css" />
        <!-- End layout styles -->
        <link rel="shortcut icon" href="assets/images/favicon.png" />
    </head>

    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div style="height: 86px"></div>
            <div class="container-scroller">
                <!-- partial:partials/_navbar.html -->
                <!-- partial -->
                <div class="container-fluid page-body-wrapper">
                    <!-- partial:partials/_sidebar.html -->
                    <nav class="sidebar sidebar-offcanvas" id="sidebar">
                        <ul class="nav">
                            <li class="nav-item nav-profile">
                                <div class="nav-link">
                                    <div class="nav-profile-image">
                                        <img src="assets/images/faces/face1.jpg" alt="profile" />
                                        <span class="login-status online"></span>
                                        <!--change to offline or busy as needed-->
                                    </div>
                                    <div class="nav-profile-text d-flex flex-column">
                                        <span class="font-weight-bold mb-2"><%= account.getName() %></span>
                                    <a href="UpdateAccount.jsp"class="text-secondary text-small">Edit profile</a>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard">
                                <span class="menu-title">Dashboard</span>
                                <i class="mdi mdi-home menu-icon"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic" aria-expanded="false"
                               aria-controls="ui-basic">
                                <span class="menu-title">Manager</span>
                                <i class="menu-arrow"></i>
                                <i class="mdi mdi-crosshairs-gps menu-icon"></i>
                            </a>
                            <div class="collapse" id="ui-basic">
                                <ul class="nav flex-column sub-menu">
                                    <li class="nav-item">
                                        <a class="nav-link" href="productcrud">Product</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="ManagerAccount.jsp">Account</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="ordercrud?role=<%= account.getRole() %>">Order</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout">
                                <span class="menu-title">Log out</span>
                                <i class="mdi mdi-file-document-box menu-icon"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="page-header">
                            <h3 class="page-title"> Product </h3>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Manager</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Product</li>
                                </ol>
                            </nav>
                        </div>
                        <jsp:include page="ProductCRUD.jsp"></jsp:include>
                        </div>
                        <!-- content-wrapper ends -->
                        <!-- partial -->
                    </div>
                    <!-- main-panel ends -->
                </div>
                <!-- page-body-wrapper ends -->
            </div>
            <!-- container-scroller -->
            <!-- plugins:js -->
            <script src="assets/vendors/js/vendor.bundle.base.js"></script>
            <!-- endinject -->
            <!-- Plugin js for this page -->
            <!-- End plugin js for this page -->
            <!-- inject:js -->
            <script src="assets/js/off-canvas.js"></script>
            <script src="assets/js/misc.js"></script>
            <script src="assets/js/settings.js"></script>
            <script src="assets/js/todolist.js"></script>
            <script src="assets/js/jquery.cookie.js"></script>
            <!-- endinject -->
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>

</html>

