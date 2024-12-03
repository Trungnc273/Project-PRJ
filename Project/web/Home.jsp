<%-- 
    Document   : home
    Created on : 2 thg 10, 2024, 13:40:15
    Author     : TRUNG
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
        <script src="./js/bootstrap.bundle.min.js"></script>


    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>

            <div class="container home">

                <!--new arrivals-->
                <h2 class="text-lg-start" style="color: red; margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">New Arrivals</h2>

                <div id="productCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-wrap="true" data-bs-interval="3000">

                    <!-- Indicators -->
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="0" class="active"></button>
                        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="1"></button>
                        <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="2"></button>
                    </div>

                    <!-- Carousel items -->
                    <div class="carousel-inner">
                    <c:forEach items="${requestScope.data}" var="p" varStatus="status" begin="0" end="11">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <div class="row">
                                </c:if>

                                <!-- Product Card -->
                                <div class="col-md-3 mb-4">
                                    <div class="card h-100">
                                        <a href="productdetail?pid=${p.pid}">
                                            <img src="${p.image1}" class="card-img-top" alt="${p.pname}" style="width:100%; height:280px; object-fit:cover;"/>
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-size: 1rem; color: black">${p.pname}</h5>
                                                <p class="card-text price" style="color: red">${p.price} ₫</p>
                                                <p class="card-text"><small class="text-muted">Date: ${p.datesell}</small></p>
                                            </div>
                                        </a>
                                    </div>
                                </div>

                                <c:if test="${(status.index + 1) % 4 == 0 || status.index == fn:length(requestScope.data) - 1}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <!-- Left control -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>

                    <!-- Right control -->
                    <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <!--feature-->
            <div class="banner my-4">
                <h2 style="margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">FEATURED</h2>
                <div class="content">
                    <div class="left">
                        <a href="allproducts?page=newarrival&newarrival=true"><img src="./img/homenew.webp" alt=""></a>
                    </div>
                    <div class="right">
                        <div class="right--top">
                            <a href="allproducts?page=allmega&cid=4" class="col-12"><img src="./img/homemega.webp"></a>
                        </div>
                        <div class="right--bot">
                            <a href="allproducts?page=figurine&cid=3" class="col-12"><img src="./img/homefigurine.webp"></a>
                        </div>
                    </div>
                </div>
            </div>

            <!--skullpanda recommentdation-->
            <h2 class="text-lg-start" style=" margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">Skullpanda Recommendation</h2>

            <div id="skullpandareCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-wrap="true" data-bs-interval="3000">

                <!-- Indicators -->
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="2"></button>
                </div>

                <!-- Carousel items -->
                <div class="carousel-inner">
                    <c:forEach items="${requestScope.data2}" var="p" varStatus="status" begin="0" end="7">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                <div class="row">
                                </c:if>

                                <!-- Product Card -->
                                <div class="col-md-3 mb-4">
                                    <div class="card h-100">
                                        <a href="productdetail?pid=${p.pid}">
                                            <img src="${p.image1}" class="card-img-top" alt="${p.pname}" style="width:100%; height:280px; object-fit:cover;"/>
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-size: 1rem; color: black">${p.pname}</h5>
                                                <p class="card-text price" style="color: red">${p.price} ₫</p>
                                                <p class="card-text"><small class="text-muted">Date: ${p.datesell}</small></p>
                                            </div>
                                        </a>
                                    </div>
                                </div>

                                <c:if test="${(status.index + 1) % 4 == 0 || status.index == fn:length(requestScope.data) - 1}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <!-- Left control -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#skullpandareCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>

                    <!-- Right control -->
                    <button class="carousel-control-next" type="button" data-bs-target="#skullpandareCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <!--RECOMMENDED FOR YOU-->
            <div class="banner my-4">
                <h2 style="margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">RECOMMENDED FOR YOU</h2>
                <div class="content">
                    <div class="left">
                        <a href="allproducts?page=dimoo&subcid=2"><img src="./img/homedimoo.webp" alt=""></a>
                    </div>
                    <div class="right">
                        <div class="right--top">
                            <a href="allproducts?page=molly&subcid=1" class="col-12"><img src="./img/homemolly.webp"></a>
                        </div>
                        <div class="right--bot">
                            <a href="allproducts?page=hirono&subcid=3" class="col-12"><img src="./img/homehirono.webp"></a>
                        </div>
                    </div>
                </div>
            </div>

            <!--Top Sellings-->
            <h2 class="text-lg-start" style=" margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">Top Sellings</h2>
            <div class="row">
                <c:forEach items="${requestScope.data4}" var="p" begin="0" end="15">
                    <div class="col-md-3 mb-4 ">
                        <div class="card h-100">
                            <a href="productdetail?pid=${p.pid}"> <!-- Link dẫn tới chi tiết sản phẩm -->
                                <img src="${p.image1}" class="card-img-top" alt="${p.pname}" style="width:100%; height:280px; object-fit:cover;"/>
                                <div class="card-body">
                                    <h5 class="card-title" style="font-size: 1rem; color: black">${p.pname}</h5>
                                    <p class="card-text price" style="color: red">${p.price} ₫</p>
                                    <p class="card-text"><small class="text-muted">Date: ${p.datesell}</small></p>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <a href="allproducts?page=topselling&topselling=true" class="topsell--button"><button class="btn-custom">VIEW MORE</button></a>

            <!-- POP FRIENDS -->
            <div class="popfriend my-4">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 style="font-weight: bold; font-size: 2rem; margin-top: 100px;">POP FRIENDS</h2>
                </div>
                <!-- Dòng kẻ ngang -->
                <hr />

                <!-- Carousel -->
                <div id="popFriendsCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <!-- Slide 1 -->
                        <div class="carousel-item active">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="./img/homef1.jpg" alt="Image 1" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef2.jpg" alt="Image 2" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef3.jpg" alt="Image 3" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef4.jpg" alt="Image 4" class="img-fluid">
                                </div>
                            </div>
                        </div>
                        <!-- Slide 2 -->
                        <div class="carousel-item">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="./img/homef5.jpg" alt="Image 5" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef6.jpg" alt="Image 6" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef7.jpg" alt="Image 7" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef8.jpg" alt="Image 8" class="img-fluid">
                                </div>
                            </div>
                        </div>
                        <!-- Slide 3 -->
                        <div class="carousel-item">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="./img/homef9.jpg" alt="Image 9" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef10.jpg" alt="Image 10" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef11.jpg" alt="Image 11" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef12.jpg" alt="Image 12" class="img-fluid">
                                </div>
                            </div>
                        </div>

                        <!-- Slide 4 -->
                        <div class="carousel-item">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="./img/homef13.jpg" alt="Image 13" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef14.jpg" alt="Image 14" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef15.jpg" alt="Image 15" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef16.jpg" alt="Image 16" class="img-fluid">
                                </div>
                            </div>
                        </div>

                        <!-- Slide 5 -->
                        <div class="carousel-item">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="./img/homef17.jpg" alt="Image 17" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef18.jpg" alt="Image 18" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef19.jpg" alt="Image 19" class="img-fluid">
                                </div>
                                <div class="col-md-3">
                                    <img src="./img/homef20.jpg" alt="Image 20" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Nút điều hướng -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#popFriendsCarousel"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#popFriendsCarousel"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>

        <div style="height: 50px"></div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="./js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const priceElements = document.querySelectorAll('.price');
                priceElements.forEach(function (el) {
                    let price = parseInt(el.textContent.trim());
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                });
            });
        </script>
    </body>
</html>
