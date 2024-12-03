<%-- 
    Document   : ManagerAccount
    Created on : 10 thg 10, 2024, 19:05:07
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
        <!-- inject:css -->
        <link rel="stylesheet" href="assets/css/style.css" />
        <!-- End layout styles -->
        <link rel="shortcut icon" href="assets/images/favicon.png" />
        <style>
            .form-section {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .form-section button {
                width: 100%;
                text-align: center;
                background-color: #007bff;
                color: white;
                padding: 15px;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                transition: background-color 0.3s, transform 0.3s;
            }

            .form-section button:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            .form-header {
                margin-bottom: 15px;
                font-size: 1.5rem;
                font-weight: bold;
                color: #333;
                text-align: center;
            }

            .form-group label {
                font-weight: bold;
                color: #555;
            }

            .form-group input,
            .form-group select {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                width: 100%;
                transition: border-color 0.3s;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .btn-success {
                width: 100%;
                background-color: #28a745;
                border: none;
            }

            .btn-success:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }
        </style>
    </head>

    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div style="height: 86px"></div>
            <div class="container-scroller">
                <div class="container-fluid page-body-wrapper">
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
                            <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
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
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="page-header">
                            <h3 class="page-title">Account</h3>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">Manager</a></li>
                                    <li class="breadcrumb-item active" aria-current="page"> Account </li>
                                </ol>
                            </nav>
                        </div>
                        <div class="container mt-5">
                            <h2 class="text-center mb-4">Create Account</h2>
                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="form-section">
                                        <button type="button" onclick="toggleForm('accountForm')">Create Account</button>
                                        <form id="accountForm" class="mt-3" action="createAccount" method="post">
                                            <div class="form-header">Account Information</div>
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="Phone">Phone:</label>
                                                    <input type="text" class="form-control" id="Phone" name="phone" placeholder="Enter phone" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="email">Email:</label>
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="name">Name:</label>
                                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="address">Address:</label>
                                                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter address" required>
                                                </div>
                                            </div>
                                            <label id="showPasswordLabel" for="showPassword"
                                                   style="display: flex; align-items: center; margin: -20px 0 -20px 85%;">
                                                <input id="showPassword" type="checkbox" style="margin-right: 5px;" />
                                                Show
                                                <div class="indicator"></div>
                                            </label>
                                            <div class="form-group">
                                                <label for="password">Password:</label>
                                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-4">
                                                    <label for="sex">Sex:</label>
                                                    <select class="form-control" id="sex" name="sex">
                                                        <option value="1">Male</option>
                                                        <option value="2">Female</option>
                                                        <option value="0">Not Specified</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="dob">Date of Birth:</label>
                                                    <input type="date" class="form-control" id="dob" name="dob" required>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="role">Role:</label>
                                                    <select class="form-control" id="role" name="role" required>
                                                        <option value="1">Admin</option>
                                                        <option value="2">Employee</option>
                                                        <option value="3">Customer</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-success mt-2">Submit</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
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
        <script>
                                            function toggleForm(id) {
                                                const form = document.getElementById(id);
                                                form.style.display = form.style.display === "none" ? "block" : "none";
                                            }
        </script>
        <script>document.getElementById('showPassword').addEventListener('change', function () {
                var passwordInput = document.getElementById('password');
                if (this.checked) {
                    passwordInput.type = 'text'; // Hiện mật khẩu
                } else {
                    passwordInput.type = 'password'; // Ẩn mật khẩu
                }
            });</script>

        <jsp:include page="Footer.jsp"></jsp:include>
    </body>

</html>
