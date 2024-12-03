<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CART</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <script src="./js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <form id="cartForm" action="checkout" method="post" onsubmit="return prepareCheckout();">
                <div class="container col-md-9" style="margin-top: 8%">
                    <h1 class="h3 fw-bold">MY CART</h1>
                    <div class="row">
                        <div class="col-md-7">
                            <div class="cart-header d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check" style="margin-bottom: -30px;">
                                    <input type="checkbox" class="form-check-input" id="selectAll" onclick="toggleSelectAll()" /> 
                                    <label class="form-check-label" for="selectAll">Select All</label>
                                </div>
                            </div>

                        <c:set var="cart" value="${requestScope.cart}"/>
                        <c:set var="tt" value="0"/>

                        <c:forEach items="${cart.items}" var="item">
                            <c:set var="tt" value="${tt + 1}"/>
                            <div class="cart-item border-bottom py-3 d-flex align-items-center">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input item-checkbox" name="selectItem" data-product-id="${item.product.pid}" data-price="${item.price * item.quantity}" 
                                           style="cursor: pointer;" 
                                           onclick="this.style.backgroundColor = this.checked ? 'black' : ''; this.style.borderColor = this.checked ? 'black' : ''; updateTotalPrice();" />
                                </div>

                                <div class="cart-item-image me-3">
                                    <img src="${item.product.image1}" alt="${item.product.pname}" class="img-thumbnail" style="width: 120px;">
                                </div>

                                <div class="cart-item-details flex-grow-1" style="width: 55%;">
                                    <a href="productdetail?pid=${item.product.pid}" class="mb-1 fw-bold text-truncate" >
                                        <p style="max-width: 95%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">${item.product.pname}</p>
                                    </a>
                                    <p class="mb-1 text-muted price">${item.price} đ</p>
                                    <div class="cart-item-quantity d-flex" style="margin-bottom: 50px">
                                        <div>Quantity: ${item.quantity}</div>
                                    </div>
                                </div>

                                <button type="button" class="btn btn-danger btn-sm remove-btn ms-auto" onclick="removeItem(${item.product.pid})">Remove</button>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="col-md-5">
                        <div class="cart-summary p-3 bg-light rounded" style="margin-top: 5px;">
                            <p class="mb-1">Subtotal: <span id="selectedTotalPrice">0</span> đ</p>
                            <p class="mb-1">Shipping: Calculated at next step</p>
                            <hr/>
                            <p class="h5"><strong>Total: <span id="finalTotalPrice">0</span> đ</strong></p>
                            <button type="submit" class="btn btn-outline-danger w-100 mt-3 checkout-btn fw-bold">CHECK OUT</button> 
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script>
            function toggleSelectAll() {
                const selectAllCheckbox = document.getElementById('selectAll');
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');

                itemCheckboxes.forEach(function (checkbox) {
                    checkbox.checked = selectAllCheckbox.checked; // Thiết lập trạng thái của các checkbox sản phẩm

                    // Thay đổi màu sắc cho các checkbox sản phẩm
                    if (checkbox.checked) {
                        checkbox.style.backgroundColor = 'black'; // Màu nền khi được chọn
                        checkbox.style.borderColor = 'black'; // Màu viền khi được chọn
                    } else {
                        checkbox.style.backgroundColor = ''; // Trở về màu nền mặc định
                        checkbox.style.borderColor = ''; // Trở về màu viền mặc định
                    }
                });

                // Thay đổi màu sắc cho checkbox "Select All"
                if (selectAllCheckbox.checked) {
                    selectAllCheckbox.style.backgroundColor = 'black'; // Màu nền khi được chọn
                    selectAllCheckbox.style.borderColor = 'black'; // Màu viền khi được chọn
                } else {
                    selectAllCheckbox.style.backgroundColor = ''; // Trở về màu nền mặc định
                    selectAllCheckbox.style.borderColor = ''; // Trở về màu viền mặc định
                }
                updateTotalPrice();
            }

            document.addEventListener("DOMContentLoaded", function () {
                const priceElements = document.querySelectorAll('.price');
                priceElements.forEach(function (el) {
                    let price = parseInt(el.textContent.trim());
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                });
            });

            function updateTotalPrice() {
                let totalPrice = 0;
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');

                itemCheckboxes.forEach(function (checkbox) {
                    if (checkbox.checked) {
                        const price = parseFloat(checkbox.getAttribute('data-price'));
                        totalPrice += price; // Cộng giá tiền của sản phẩm được chọn
                    }
                });

                // Cập nhật Subtotal và Total
                document.getElementById('selectedTotalPrice').textContent = new Intl.NumberFormat('vi-VN').format(totalPrice);
                document.getElementById('finalTotalPrice').textContent = new Intl.NumberFormat('vi-VN').format(totalPrice);
            }

            function prepareCheckout() {
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                const selectedProducts = [];

                itemCheckboxes.forEach(function (checkbox) {
                    if (checkbox.checked) {
                        selectedProducts.push(checkbox.getAttribute('data-product-id'));
                    }
                });

                // Kiểm tra xem có sản phẩm nào được chọn hay không
                if (selectedProducts.length === 0) {
                    alert("You have 0 product.");
                    return false; // Ngăn gửi form nếu không có sản phẩm nào
                }

                // Tạo một hidden input để lưu trữ danh sách sản phẩm đã chọn
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'selectedProducts';
                input.value = selectedProducts.join(','); // Chuyển đổi thành chuỗi phân cách bởi dấu phẩy
                document.getElementById('cartForm').appendChild(input);

                return true; // Cho phép gửi form
            }
            // remove item
            function removeItem(productId) {
                window.location = 'deletecart?productId=' + productId;
            }
        </script>
    </body>
</html>
