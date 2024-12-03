<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/productdetail.css">
    </head>
    <style>
        .carousel-control-prev,
        .carousel-control-next {
            filter: invert(1);
            width: 5%;

        }
        .carousel-control-prev {
            transform: translateX(-45%);
        }
        .carousel-control-next {
            transform: translateX(45%);
        }

    </style>

    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div style="margin-top: 150px"></div>
            <div class="container product-detail">
            <c:choose>
                <c:when test="${not empty product}">
                    <div class="row">
                        <!-- Cột hình ảnh sản phẩm -->
                        <div class="col-md-7">
                            <div class="product-images d-flex">
                                <!-- Các ảnh nhỏ bên trái -->
                                <div class="thumbnails d-flex flex-column me-2">
                                    <img style="width: 100px;" src="<c:out value='${product.image1}' />" alt="Ảnh chính" class="img-thumbnail thumbnail mb-2 smallimage" onclick="changeImage(this)" />
                                    <img style="width: 100px;" src="<c:out value='${product.image2}' />" alt="Ảnh khác" class="img-thumbnail thumbnail mb-2 smallimage" onclick="changeImage(this)" />
                                    <img style="width: 100px;" src="<c:out value='${product.image3}' />" alt="Ảnh khác" class="img-thumbnail thumbnail mb-2 smallimage" onclick="changeImage(this)" />
                                    <img style="width: 100px;"  src="<c:out value='${product.image4}' />" alt="Ảnh khác" class="img-thumbnail thumbnail mb-2 smallimage" onclick="changeImage(this)" />
                                    <img style="width: 100px;" src="<c:out value='${product.image5}' />" alt="Ảnh khác" class="img-thumbnail thumbnail mb-2 smallimage" onclick="changeImage(this)" />
                                </div>

                                <!-- Ảnh lớn chính -->
                                <div>
                                    <img style="width: 532px;" id="mainImage" src="<c:out value='${product.image1}' />" alt="<c:out value='${product.pname}' />" class="img-fluid" />
                                </div>
                            </div>
                        </div>

                        <!-- Cột chi tiết sản phẩm -->
                        <div class="col-md-5 product-info">
                            <div>
                                <c:if test="${product.quantity == 0}">
                                    <span class="badge bg-secondary">Sold Out</span>
                                </c:if>
                                <c:if test="${product.datesell.after(currentDate)}">
                                    <span class="badge bg-warning">Launch</span>
                                </c:if>
                            </div>
                            <h2><c:out value="${product.pname}" /></h2>
                            <p class="price" style="color: red"><c:out value="${product.price}" /> ₫</p>
                            <div class="form-group">
                                <label for="quantity" style="font-weight: bold">QUANTITY</label>

                                <div style="width: 150px; margin-top: 10px" class="input-group input-quantity">
                                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(-1)" <c:if test="${product.quantity == 0 || (product.datesell.after(currentDate))}">disabled</c:if>>-</button>
                                    <input type="number" id="quantity" class="form-control quantity-input" min="1" value="1" <c:if test="${product.quantity == 0 || (product.datesell.after(currentDate))}">disabled</c:if> />
                                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(1)" <c:if test="${product.quantity == 0 || (product.datesell.after(currentDate))}">disabled</c:if>>+</button>
                                    </div>
                                </div>
                                <br/>

                                <!-- Div chứa cả hai nút -->
                                <div style="display: flex; gap: 10px;">
                                    <!-- Form cho nút ADD TO CART -->
                                    <form action="addcart" method="post">
                                        <input type="hidden" name="productId" value="${product.pid}">
                                    <input type="hidden" name="quantity" id="cartQuantity" value="1">
                                    <button class="addandbuy btn btn-primary notify-btn bg-black" 
                                            <c:if test="${product.quantity == 0 || product.datesell.after(currentDate)}">disabled</c:if>>
                                                ADD TO CART
                                            </button>
                                    </form>

                                    <!-- Form cho nút BUY NOW -->
                                    <form action="buyNow" method="post">
                                        <input type="hidden" name="productId" value="${product.pid}">
                                    <input type="hidden" name="quantity" id="buyQuantity" value="1">
                                    <button class="addandbuy btn btn-primary notify-btn bg-danger" 
                                            <c:if test="${product.quantity == 0 || product.datesell.after(currentDate)}">disabled</c:if>>
                                                BUY NOW
                                            </button>
                                    </form>
                                </div>

                                <hr />

                                <!-- Phần Details -->
                                <div class="details-container">
                                    <p style="display: inline-block;font-weight: bold">Details</p>
                                    <!-- Nút mũi tên mở rộng -->
                                    <button class="btn btn-outline-secondary" style="margin-bottom: 5px; border: none; background-color: transparent; color: black; width: 20px; text-align: start" type="button" onclick="toggleDetails('productDetails', this)">
                                        ▼ <span class="arrow"></span>
                                    </button>
                                </div>
                                <div id="productDetails" style="display: none;">
                                    <p><c:out value="${product.describe}" escapeXml="false" /></p>
                            </div>
                            <hr />

                            <!-- Phần SHIPPING & AFTER-SALES SERVICE -->
                            <div class="details-container">
                                <p style="display: inline-block; font-weight: bold">SHIPPING & AFTER-SALES SERVICE</p>
                                <!-- Nút mũi tên mở rộng -->
                                <button class="btn btn-outline-secondary" style="margin-bottom: 5px; border: none; background-color: transparent; color: black; width: 20px; text-align: start" type="button" onclick="toggleDetails('shipservice', this)">
                                    ▼ <span class="arrow"></span>
                                </button>
                            </div>
                            <div id="shipservice" style="display: none;">
                                <p>1. Shipping:<br/>
                                    Standard Shipping (15-30 working days)<br/>
                                    Expedited Shipping (3-7 working days)<br/>
                                    2. Defects:<br/>
                                    (1) Limited items don't have an exchange service. If you find a serious defect in the item, contact support@popmart.com, with the related order number and unpacking video of the figurine within five (5) days of receiving the product.<br/>
                                    (2) For information security reasons, please contact us with the email address you used to place the order. You will be contacted by a Customer Support Representative who will assist you in resolving the issue.<br/>
                                    (3) In order to avoid any disputes regarding refunds or exchanges, customers are encouraged to video record themselves opening the package. A video recording must be completed no later than two days after delivery. A video should clearly show the shipping sheet, the package condition, and product defects.<br/>
                                    3. Tax fees:<br/>
                                    For international express shipments, the buyer shall bear any Customs Duty costs<br/></p>
                                <br/><a style="text-decoration: underline" href="ShippingPolicy.jsp" target="_blank">Read More</a>
                            </div>
                            <hr />
                        </div>
                    </div>
                    <img src="<c:out value='${product.imagesize}' />" alt="image size" class="otherimg"/>
                    <img src="<c:out value='${product.imageinfor}' />" alt="image information" class="otherimg"/>
                </c:when>
                <c:otherwise>
                    <p>Không tìm thấy sản phẩm.</p>
                </c:otherwise>
            </c:choose>

            <h2 class="text-lg-start" style="color: red; margin-top: 100px; font-weight: bold; font-size: 2rem;margin-bottom: 30px;">Related Products</h2>

            <div id="productCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-wrap="true" data-bs-interval="3000">

                <!-- Indicators -->
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="2"></button>
                </div>

                <!-- Carousel items -->
                <div class="carousel-inner">
                    <c:forEach items="${requestScope.data}" var="p" varStatus="status" begin="0" end="7">
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
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
            <script src="./js/bootstrap.bundle.min.js"></script>
            <script>
                                    // Hàm để thay đổi hình ảnh chính khi nhấp vào ảnh nhỏ
                                    function changeImage(element) {
                                        document.getElementById('mainImage').src = element.src;
                                    }
            </script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const priceElements = document.querySelectorAll('.price');
                    priceElements.forEach(function (el) {
                        let price = parseInt(el.textContent.trim());
                        el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                    });
                });
            </script>
            <script>
                function changeQuantity(delta) {
                    var quantityInput = document.getElementById('quantity');
                    var currentValue = parseInt(quantityInput.value);
                    var newValue = currentValue + delta;
                    if (newValue < 1)
                        newValue = 1; // Đảm bảo số lượng không nhỏ hơn 1
                    quantityInput.value = newValue;
                }

                function toggleDetails(detailId, button) {
                    var detailsElement = document.getElementById(detailId);
                    if (detailsElement.style.display === "none" || detailsElement.style.display === "") {
                        detailsElement.style.display = "block"; // Hiện thông tin chi tiết
                        button.innerHTML = "▲ <span class='arrow'></span>"; // Thay đổi mũi tên thành lên
                    } else {
                        detailsElement.style.display = "none"; // Ẩn thông tin chi tiết
                        button.innerHTML = "▼ <span class='arrow'></span>"; // Thay đổi mũi tên thành xuống
                    }
                }
//               gioi han quantity nhap vao
                function changeQuantity(delta) {
                    var quantityInput = document.getElementById('quantity');
                    var currentValue = parseInt(quantityInput.value);
                    var availableQuantity = ${product.quantity}; // Số lượng sản phẩm hiện có

                    var newValue = currentValue + delta;

                    // Kiểm tra nếu số lượng nhập vào nhỏ hơn hoặc bằng 0 thì đặt thành 1
                    if (newValue < 1) {
                        newValue = 1;
                    }

                    // Kiểm tra nếu số lượng nhập vào lớn hơn số lượng sản phẩm hiện có
                    if (newValue > availableQuantity) {
                        newValue = availableQuantity;
                    }

                    quantityInput.value = newValue;
                }

                document.getElementById('quantity').addEventListener('input', function () {
                    var quantityInput = document.getElementById('quantity');
                    var currentValue = parseInt(quantityInput.value);
                    var availableQuantity = ${product.quantity}; // Số lượng sản phẩm hiện có

                    // Nếu số lượng nhập vào nhỏ hơn 1 thì đặt thành 1
                    if (currentValue < 1) {
                        quantityInput.value = 1;
                    }

                    // Nếu số lượng nhập vào lớn hơn số lượng sản phẩm hiện có thì đặt thành số lượng hiện có
                    if (currentValue > availableQuantity) {
                        quantityInput.value = availableQuantity;
                    }
                });
        </script>
        <script>
            function changeQuantity(amount) {
                var quantityInput = document.getElementById("quantity");
                var currentQuantity = parseInt(quantityInput.value);
                var newQuantity = currentQuantity + amount;

                if (newQuantity >= 1) {
                    quantityInput.value = newQuantity;
                    updateBuyQuantity();
                }
            }

            function updateBuyQuantity() {
                var quantityInput = document.getElementById("quantity");
                var quantity = quantityInput.value;

                // Chỉ cập nhật nếu giá trị là số và không âm
                if (!isNaN(quantity) && quantity >= 1) {
                    document.getElementById("buyQuantity").value = quantity;
                    document.getElementById("cartQuantity").value = quantity;
                }
            }

            // Thêm sự kiện lắng nghe cho ô nhập số lượng
            document.getElementById("quantity").addEventListener("input", function () {
                updateBuyQuantity();
            });
        </script>
    </body>
</html>
