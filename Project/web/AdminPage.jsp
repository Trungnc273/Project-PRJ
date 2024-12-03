<%-- 
    Document   : AdminPage
    Created on : 10 thg 10, 2024, 19:02:05
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin Manager</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
        <link rel="stylesheet" href="assets/vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
        <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css">
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <link rel="stylesheet" href="assets/vendors/font-awesome/css/font-awesome.min.css" />
        <link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <!-- endinject -->
        <!-- Layout styles -->
        <link rel="stylesheet" href="assets/css/style.css">
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
                            <h3 class="page-title">
                                <span class="page-title-icon bg-gradient-primary text-white me-2">
                                    <i class="mdi mdi-home"></i>
                                </span> Dashboard
                            </h3>
                            <nav aria-label="breadcrumb">
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item active" aria-current="page">
                                        <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="row">
                            <div class="col-md-4 stretch-card grid-margin">
                                <div class="card bg-gradient-danger card-img-holder text-white">
                                    <div class="card-body">
                                        <img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                                        <h4 class="font-weight-normal mb-3">Month Income <i class="mdi mdi-chart-line mdi-24px float-end"></i>
                                        </h4>
                                        <h2 class="mb-5 price">${monthlysell}</h2>
                                        <h6 class="card-text">${salepercent}</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 stretch-card grid-margin">
                                <div class="card bg-gradient-info card-img-holder text-white">
                                    <div class="card-body">
                                        <img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                                        <h4 class="font-weight-normal mb-3">Month Orders <i
                                                class="mdi mdi-bookmark-outline mdi-24px float-end"></i>
                                        </h4>
                                        <h2 class="mb-5">${monthlyorder}</h2>
                                        <h6 class="card-text">${orderpercent}</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 stretch-card grid-margin">
                                <div class="card bg-gradient-success card-img-holder text-white">
                                    <div class="card-body">
                                        <img src="assets/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                                        <h4 class="font-weight-normal mb-3">Month Customer Active <i class="mdi mdi-diamond mdi-24px float-end"></i>
                                        </h4>
                                        <h2 class="mb-5">${monthlycustomer}</h2>
                                        <h6 class="card-text">${customerpercent}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <label for="yearSelect">Year:</label>
                        <select style="width: 100px;" name="series" id="yearSelect" class="form-control">
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                        </select>

                        <div class="card">
                            <div class="card-body">
                                <div class="clearfix">
                                    <h4 class="card-title float-start">Income Statistics</h4>
                                    <div id="visit-sale-chart-legend"
                                         class="rounded-legend legend-horizontal legend-top-right float-end"></div>
                                </div>
                                <canvas id="salesChart" width="400" height="200"></canvas>
                                <canvas id="salesChartLastYear" width="400" height="200" style="display: none;"></canvas>
                                <canvas id="salesChartTwoYearAgo" width="400" height="200" style="display: none;"></canvas>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="clearfix">
                                    <h4 class="card-title float-start">Orders Statistics</h4>
                                    <div id="visit-sale-chart-legend"
                                         class="rounded-legend legend-horizontal legend-top-right float-end"></div>
                                </div>
                                <canvas id="orderChart" width="400" height="200"></canvas>
                                <canvas id="orderChartLastYear" width="400" height="200" style="display: none;"></canvas>
                                <canvas id="orderChartTwoYearAgo" width="400" height="200" style="display: none;"></canvas>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="clearfix">
                                    <h4 class="card-title float-start">Customer Active Statistics</h4>
                                    <div id="visit-sale-chart-legend"
                                         class="rounded-legend legend-horizontal legend-top-right float-end"></div>
                                </div>
                                <canvas id="customerChart" width="400" height="200"></canvas>
                                <canvas id="customerChartLastYear" width="400" height="200" style="display: none;"></canvas>
                                <canvas id="customerChartTwoYearAgo" width="400" height="200" style="display: none;"></canvas>
                            </div>
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
            <script src="assets/vendors/chart.js/chart.umd.js"></script>
            <script src="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
            <!-- End plugin js for this page -->
            <!-- inject:js -->
            <script src="assets/js/off-canvas.js"></script>
            <script src="assets/js/misc.js"></script>
            <script src="assets/js/settings.js"></script>
            <script src="assets/js/todolist.js"></script>
            <script src="assets/js/jquery.cookie.js"></script>
            <!-- endinject -->
            <!-- Custom js for this page -->
            <script src="assets/js/dashboard.js"></script>
            <!-- End custom js for this page -->
            <!--            sale chart-->
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Hiển thị biểu đồ cho năm 2024 theo mặc định
                    document.getElementById("salesChart").style.display = 'block';
                    document.getElementById("orderChart").style.display = 'block';
                    document.getElementById("customerChart").style.display = 'block';

                    // Ẩn các biểu đồ khác
                    document.getElementById("salesChartLastYear").style.display = 'none';
                    document.getElementById("salesChartTwoYearAgo").style.display = 'none';

                    document.getElementById("orderChartLastYear").style.display = 'none';
                    document.getElementById("orderChartTwoYearAgo").style.display = 'none';

                    document.getElementById("customerChartLastYear").style.display = 'none';
                    document.getElementById("customerChartTwoYearAgo").style.display = 'none';
                });

                document.getElementById("yearSelect").addEventListener("change", function () {
                    var selectedYear = this.value;

                    // Ẩn tất cả các biểu đồ
                    document.querySelectorAll("canvas").forEach(function (canvas) {
                        canvas.style.display = 'none';
                    });

                    // Hiển thị biểu đồ tương ứng với năm đã chọn
                    if (selectedYear === "2024") {
                        document.getElementById("salesChart").style.display = 'block';
                        document.getElementById("orderChart").style.display = 'block';
                        document.getElementById("customerChart").style.display = 'block';
                    } else if (selectedYear === "2023") {
                        document.getElementById("salesChartLastYear").style.display = 'block';
                        document.getElementById("orderChartLastYear").style.display = 'block';
                        document.getElementById("customerChartLastYear").style.display = 'block';
                    } else if (selectedYear === "2022") {
                        document.getElementById("salesChartTwoYearAgo").style.display = 'block';
                        document.getElementById("orderChartTwoYearAgo").style.display = 'block';
                        document.getElementById("customerChartTwoYearAgo").style.display = 'block';
                    }
                });

                // Lấy dữ liệu doanh thu từ server qua AJAX
                fetch('getSalesData')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            var ctx = document.getElementById('salesChart').getContext('2d');
                            var salesChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                                    datasets: [{
                                            label: 'Income (₫)',
                                            data: data,
                                            backgroundColor: 'rgba(255, 99, 132, 0.2 )',
                                            borderColor: 'rgba(255, 99, 132, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                callback: function (value) {
                                                    return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                }
                                            }
                                        }
                                    },
                                    responsive: true
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <script>
                // Lấy dữ liệu doanh thu từ server qua AJAX
                fetch('getSaleDataLastYear')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            var ctx = document.getElementById('salesChartLastYear').getContext('2d');
                            var salesChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                                    datasets: [{
                                            label: 'Income (₫)',
                                            data: data,
                                            backgroundColor: 'rgba(255, 99, 132, 0.2 )',
                                            borderColor: 'rgba(255, 99, 132, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                callback: function (value) {
                                                    return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                }
                                            }
                                        }
                                    },
                                    responsive: true
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <script>
                // Lấy dữ liệu doanh thu từ server qua AJAX
                fetch('getSaleDataTwoYearAgo')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            var ctx = document.getElementById('salesChartTwoYearAgo').getContext('2d');
                            var salesChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                                    datasets: [{
                                            label: 'Income (₫)',
                                            data: data,
                                            backgroundColor: 'rgba(255, 99, 132, 0.2 )',
                                            borderColor: 'rgba(255, 99, 132, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                callback: function (value) {
                                                    return value.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                }
                                            }
                                        }
                                    },
                                    responsive: true
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <!--OrderChart-->

            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng Order
                fetch('orderChartData')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(orderData => {
                            var ctx = document.getElementById('orderChart').getContext('2d');
                            var orderChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Number of Orders',
                                            data: orderData,
                                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                            borderColor: 'rgba(54, 162, 235, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));

            </script>
            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng Order
                fetch('orderChartDataLastYear')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(orderData => {
                            var ctx = document.getElementById('orderChartLastYear').getContext('2d');
                            var orderChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Number of Orders',
                                            data: orderData,
                                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                            borderColor: 'rgba(54, 162, 235, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));

            </script>
            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng Order
                fetch('orderChartDataTwoYearAgo')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(orderData => {
                            var ctx = document.getElementById('orderChartTwoYearAgo').getContext('2d');
                            var orderChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Number of Orders',
                                            data: orderData,
                                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                            borderColor: 'rgba(54, 162, 235, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));

            </script>
            <!--customer Chart-->
            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng khách hàng
                fetch('customerChartData')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(customerData => {
                            var ctx = document.getElementById('customerChart').getContext('2d');
                            var customerChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Numer Customer Active',
                                            data: customerData,
                                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                            borderColor: 'rgba(75, 192, 192, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng khách hàng
                fetch('customerChartDataLastYear')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(customerData => {
                            var ctx = document.getElementById('customerChartLastYear').getContext('2d');
                            var customerChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Numer Customer Active',
                                            data: customerData,
                                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                            borderColor: 'rgba(75, 192, 192, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <script>
                // Gửi yêu cầu AJAX tới servlet để lấy dữ liệu số lượng khách hàng
                fetch('customerChartDataTwoYearAgo')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(customerData => {
                            var ctx = document.getElementById('customerChartTwoYearAgo').getContext('2d');
                            var customerChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                    datasets: [{
                                            label: 'Numer Customer Active',
                                            data: customerData,
                                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                            borderColor: 'rgba(75, 192, 192, 1)',
                                            borderWidth: 1
                                        }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        })
                        .catch(error => console.error('Error:', error));
            </script>
            <jsp:include page="Footer.jsp"></jsp:include>
    </body>

</html>
