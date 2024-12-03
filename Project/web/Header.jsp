<%-- 
    Document   : header
    Created on : 2 thg 10, 2024, 11:13:55
    Author     : TRUNG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Lấy session và kiểm tra xem có Admin đã đăng nhập không
    Account account = (Account) session.getAttribute("account");
%>
<%
    // Lấy số lượng sản phẩm từ session
    Integer cartSize = (Integer) session.getAttribute("cartSize");
    if (cartSize == null) {
        cartSize = 0; // Nếu không có giỏ hàng, đặt về 0
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <div class="header fixed-top" style="background-color: white">
            <div class="logo">
                <a href="home"><img src="./img/logo.png" alt="logo"></a>
            </div>
            <div class="navlist">
                <div id="new-feature">New & Featured</div> <!-- ID riêng cho New & Featured -->
                <div id="series">SERIES</div> <!-- ID riêng cho SERIES -->
                <div id="mega">MEGA</div> <!-- ID riêng cho MEGA -->
                <div id="types">TYPES</div> <!-- ID riêng cho TYPES -->
                <div id="accessories">ACCESSORIES</div> <!-- ID riêng cho ACCESSORIES -->
            </div>
            <div style="background-color: #d3d4d5;"class="search" id="navSearch">
                <div>search</div>
                <button class="search-icon" id="searchButton"><img src="./img/search.png" alt="search"></button>
            </div>

            <!-- Form tìm kiếm -->
            <div class="search-form-overlay" id="searchFormOverlay">
                <form action="searchbyname" method="GET" class="search-form" id="searchForm">
                    <input type="text" name="searchcontent" placeholder="Search..." class="search-input">
                    <button type="submit" class="search-submit">
                        <img src="./img/search.png" alt="search">
                    </button>
                </form>
            </div>
            <% if (account == null) { %>  <!-- Kiểm tra nếu chưa đăng nhập -->
            <div style="margin: 0 2%;">
                <a href="Login.jsp?signup=false" class="log">
                    <div>Sign in </div>
                </a>
                /
                <a href="Login.jsp?signup=true" class="log">
                    <div>Sign up</div>
                </a>
            </div>
            <% } else { %>  <!-- Nếu đã đăng nhập, hiển thị thông tin người dùng -->
            <div class="log">
                <% if (account.getRole() != 3) { %>  <!-- Kiểm tra nếu là Admin -->
                <a style="color: red;font-weight: bold" href="dashboard">Welcome, <%= account.getName() %></a> <!-- Link đến trang quản trị -->
                <% } %>
                <% if (account.getRole() == 3) { %>  <!-- Kiểm tra nếu là User -->
                <a style="color: red;font-weight: bold" href="ordercrud?role=<%= account.getRole() %>&id=<%= account.getId() %>">Welcome, <%= account.getName() %></a>
                <% } %>
                <a href="logout">Logout</a>
            </div>
            <% } %>


            <div class="contact"><img src="./img/customerService.webp" alt="img"></div>
            <a class="cart" href="showcart"><img src="./img/bag.png" alt="bag">
                <div class="numberprice">${cartSize}</div></a>
            <!-- Div chứa các ảnh cho từng phần menu -->
            <!-- Feature -->
            <div class="dropdown-images" id="feature-images">
                <div class="row"> <!-- Bọc các mục trong một hàng -->
                    <a href="allproducts?page=launchcalendar&launchcalendar=true" class="col-md-3 mb-3">
                        <img src="img/lauchercalendar.png" alt="Launch Calendar" />
                        <p>Launch Calendar</p>
                    </a>
                    <a href="allproducts?page=topselling&topselling=true" class="col-md-3 mb-3">
                        <img src="img/trending.png" alt="Trending" />
                        <p>Trending</p>
                    </a>
                    <a href="allproducts?page=newarrival&newarrival=true" class="col-md-3 mb-3">
                        <img src="img/newarrival.jpg" alt="New Arrival" />
                        <p>New Arrival</p>
                    </a>
                </div>
            </div>


            <!-- Series -->
            <div class="dropdown-images" id="series-images">
                <!-- Nhóm đầu tiên chứa 4 ảnh -->
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=molly&subcid=1"><img src="img/molly.webp" alt="MOLLY" />
                            <p> MOLLY</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=dimoo&subcid=2"><img src="img/dimoo.webp" alt="DIMOO" />
                            <p> DIMOO</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=hirono&subcid=3"><img src="img/hirono.webp" alt="HIRONO" />
                            <p> HIRONO</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=skullpanda&subcid=4"><img src="img/skullpanda.webp" alt="SKULLPANDA" />
                            <p> SKULLPANDA</p>
                        </a>
                    </div>
                </div>

                <!-- Nhóm thứ hai chứa 4 ảnh -->
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=crybaby&subcid=5"><img src="img/crybaby.webp" alt="CRYBABY" />
                            <p> CRYBABY</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=pucky&subcid=6"><img src="img/pucky.webp" alt="PUCKY" />
                            <p> PUCKY</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=sweetbean&subcid=7"><img src="img/sweetbean.webp" alt="SWEET BEAN" />
                            <p> SWEET BEAN</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=hacipupu&subcid=8"><img src="img/hacipupu.webp" alt="HACIPUPU" />
                            <p> HACIPUPU</p>
                        </a>
                    </div>
                </div>

                <!-- Nhóm thứ ba chứa 4 ảnh -->
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=disney&subcid=9"><img src="img/disney.webp" alt="DISNEY" />
                            <p> DISNEY</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=harrypotter&subcid=10"><img src="img/harrypotter.webp" alt="HARRY POTTER" />
                            <p> HARRY POTTER</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=themonsters&subcid=11"><img src="img/themonsters.webp" alt="THE MONSTERS" />
                            <p> THE MONSTERS</p>
                        </a>
                    </div>
                    <div class="col-md-3 mb-4">
                        <a href="allproducts?page=azura&subcid=12"><img src="img/azura.webp" alt="AZURA" />
                            <p> AZURA</p>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Mega -->
            <div class="dropdown-images" id="mega-images">
                <div class="row">
                    <a href="allproducts?page=mega100&subcid=13" class="col-md-3 mb-4">
                        <img src="img/mega100.webp" alt="MEGA 100%" />
                        <p>MEGA 100%</p>
                    </a>
                    <a href="allproducts?page=mega400&subcid=14" class="col-md-3 mb-4" >
                        <img src="img/mega400.webp" alt="MEGA 400%" />
                        <p>MEGA 400%</p>
                    </a>
                    <a href="allproducts?page=mega1000&subcid=15" class="col-md-3 mb-4">
                        <img src="img/mega1000.webp" alt="MEGA 1000%" />
                        <p>MEGA 1000%</p>
                    </a>
                    <a href="allproducts?page=allmega&cid=4"class="col-md-3 mb-4" >
                        <img src="img/allproducts.webp" alt="ALL MEGA" />
                        <p>ALL MEGA</p>
                    </a>
                </div>
            </div>

            <!-- Types -->
            <div class="dropdown-images" id="types-images">
                <div class="row">
                    <a href="allproducts?page=collaborations&cid=5" class="col-md-3 mb-4">
                        <img src="img/collab.webp" alt="Collaborations" />
                        <p>Collaborations</p>
                    </a>
                    <a href="allproducts?page=figure&subcid=16" class="col-md-3 mb-4" >
                        <img src="img/figure.webp" alt="Figure" />
                        <p>Figure</p>
                    </a>
                    <a href="allproducts?page=actionfigure&subcid=17" class="col-md-3 mb-4">
                        <img src="img/actionfigure.webp" alt="Action Figure" />
                        <p>Action Figure</p>
                    </a>
                    <a href="allproducts?page=allproducts" class="col-md-3 mb-4" >
                        <img src="img/allproducts.webp" alt="ALL Products" />
                        <p>ALL Products</p>
                    </a>
                </div>
            </div>

            <!-- Accessories -->
            <div class="dropdown-images" id="accessories-images">
                <div class="row">
                    <a href="allproducts?page=phoneaccessories&subcid=29" class="col-md-3 mb-4">
                        <img src="img/phoneaccessories.webp" alt="Phone Accessories" />
                        <p>Phone Accessories</p>
                    </a>
                    <a href="allproducts?page=plushtoys&subcid=27" class="col-md-3 mb-4" >
                        <img src="img/plushtoys.webp" alt="Plush Toys" />
                        <p>Plush Toys</p>
                    </a>
                    <a href="allproducts?page=bags&subcid=26" class="col-md-3 mb-4">
                        <img src="img/bags.webp" alt="Bags" />
                        <p>Bags</p>
                    </a>
                    <a href="allproducts?page=allaccessories&cid=2"class="col-md-3 mb-4" >
                        <img src="img/allproducts.webp" alt="ALL Accessories" />
                        <p>ALL Accessories</p>
                    </a>
                </div>
            </div>

        </div>


        <script>
            function setupMenuHover(menuId, imageId) {
                var menu = document.getElementById(menuId);
                var images = document.getElementById(imageId);

                menu.addEventListener('mouseenter', function () {
                    console.log(menuId + ' hovered'); // Thêm log để kiểm tra
                    images.style.display = 'block'; // Hiển thị ảnh khi hover vào mục menu
                });

                menu.addEventListener('mouseleave', function () {
                    setTimeout(function () {
                        if (!images.matches(':hover')) {
                            console.log(menuId + ' mouse leave'); // Thêm log để kiểm tra
                            images.style.display = 'none'; // Ẩn ảnh khi rời chuột khỏi menu và không ở trong images
                        }
                    });
                });

                images.addEventListener('mouseenter', function () {
                    images.style.display = 'block'; // Giữ khối ảnh hiển thị khi di chuột vào nó
                });

                images.addEventListener('mouseleave', function () {
                    images.style.display = 'none'; // Ẩn khối ảnh khi rời chuột
                });
            }

            // Gọi hàm cho từng phần menu
            setupMenuHover('new-feature', 'feature-images');
            setupMenuHover('series', 'series-images');
            setupMenuHover('mega', 'mega-images');
            setupMenuHover('types', 'types-images');
            setupMenuHover('accessories', 'accessories-images');

            //form search
            document.getElementById('navSearch').addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('searchFormOverlay').style.display = 'block';
            });

            document.getElementById('searchFormOverlay').addEventListener('click', function (e) {
                if (e.target === this) { // Kiểm tra nếu nhấn ra ngoài form
                    this.style.display = 'none';
                }
            });

        </script>


    </body>
</html>

