<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Account"%>   
<%@page import="java.util.List"%>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Page</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
        <script src="./js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container mt-5">
                <form action="buy" method="POST">
                    <div class="row" style="margin-top: 8%">
                        <!-- Shipping Address Section -->
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5>Shipping Address:</h5>
                                </div>
                                <div class="card-body">
                                    <p><strong>Name:</strong> <%= account.getName() %></p>
                                <p><strong>Phone:</strong> <%= account.getPhone() %></p>
                                <p><strong>Address:</strong><%= account.getAddress() != null ? account.getAddress() : "Address not available" %></p>
                            </div>
                        </div>

                        <!-- Payment Method Section -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Payment Method:</h5>
                            </div>
                            <div class="card-body">
                                <form>
                                    <div class="mb-3">
                                        <label for="paymentMethod" class="form-label">Choose Payment Method:</label>
                                        <select class="form-select" id="paymentMethod" name="paymentMethod" required onchange="toggleImage()">
                                            <option value="bank transfer">Bank Transfer</option>
                                            <option value="cash payment">Cash Payment</option>
                                        </select>
                                    </div>

                                    <!-- Hình ảnh sẽ được hiển thị ở đây -->
                                    <img style="width: 100%" id="paymentImage" src="./img/qr.jpg" alt="Payment Image" style="display: none;" />

                                </form>
                            </div>
                        </div>

                        <!--                         Coupon Section 
                                                <div class="card mb-4">
                                                    <div class="card-header">
                                                        <h5>Coupon:</h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" placeholder="Enter your coupon code">
                                                            <button class="btn btn-dark">Apply</button>
                                                        </div>
                                                        <p class="text-danger mt-2">*Offers and coupons cannot be shared</p>
                                                    </div>
                                                </div>-->
                    </div>

                    <!-- Order Summary Section -->
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Your Order</h5>
                            </div>
                            <div class="card-body">
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${requestScope.itemList}">
                                    <div class="row">
                                        <div class="col-md-4 d-flex justify-content-center">
                                            <img src="${item.product.image1}" alt="Product Image" class="img-fluid" style="width: 60%;">
                                        </div>
                                        <div class="col-md-8">
                                            <p><strong>${item.product.pname}</strong></p>
                                            <p><strong>Price:</strong> <span class="price">${item.price}</span></p>
                                            <p><strong>QTY:</strong> ${item.quantity}</p>
                                            <input type="hidden" name="itemList" value="${item.product.pid},${item.quantity},${item.price}"/>
                                        </div>
                                    </div>
                                    <hr>
                                    <c:set var="itemTotal" value="${item.price * item.quantity}" />
                                    <c:set var="total" value="${total + itemTotal}" />
                                </c:forEach>
                                <h4 class="text-end"><strong>Total:</strong> <span class="price">${total}</span></h4>
                                <input type="hidden" name="totalAmount" value="${total}">
                            </div>
                        </div>

                        <!-- Proceed to Pay Button -->
                        <div class="d-grid gap-2" style="margin-bottom: 30px">
                            <button type=<%= account.getAddress() != null ? "submit" : "button" %> class="btn btn-danger btn-lg" onclick="checkAddress()">Proceed to Pay</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>
        <script>
            function checkAddress() {
                // Kiểm tra xem địa chỉ có tồn tại không bằng cách sử dụng giá trị từ mã JSP
                const address = "<%= account.getAddress() != null ? account.getAddress() : "" %>";

                if (address === "") {
                    // Nếu địa chỉ trống, hiển thị cảnh báo và chuyển hướng đến trang cập nhật
                    alert("You need to add an address");
                    window.location.href = 'UpdateAccount.jsp';
                } else {
                    // Nếu địa chỉ tồn tại, gửi form
                    document.getElementById("orderForm").submit();
                }
            }
            document.addEventListener("DOMContentLoaded", function () {
                const priceElements = document.querySelectorAll('.price');
                priceElements.forEach(function (el) {
                    let price = parseInt(el.textContent.trim());
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                });
            });
            function toggleImage() {
                const paymentMethod = document.getElementById("paymentMethod").value;
                const paymentImage = document.getElementById("paymentImage");

                if (paymentMethod === "bank transfer") {
                    paymentImage.style.display = "block"; // Hiện hình ảnh
                } else {
                    paymentImage.style.display = "none"; // Ẩn hình ảnh
                }
            }
        </script>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
