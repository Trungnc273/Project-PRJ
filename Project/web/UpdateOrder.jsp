<%-- 
    Document   : UpdateOrder
    Created on : 26 thg 10, 2024, 17:22:30
    Author     : TRUNG
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Product</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding: 20px;
                font-family: 'Arial', sans-serif;
            }

            .container {
                max-width: 600px;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                margin-bottom: 20px;
                color: #343a40;
            }

            .form-group label {
                font-weight: bold;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                transition: background-color 0.3s;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <c:set var="o" value="${requestScope.order}" />
        <div class="container">
            <a href="ordercrud" class="btn btn-primary back-btn">Back</a>
            <h1>Update an Order</h1>
            <form action="updateOrder" method="post">
                <div class="form-group">
                    <label for="oid">Order ID:</label>
                    <input type="number" id="oid" readonly name="oid" value="${o.oid}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="aid">Account ID:</label>
                    <input type="number" id="aid" readonly name="aid" value="${o.aid}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="date">Date Order:</label>
                    <input type="date" id="date" name="date" readonly value="${o.orderDate}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="totalAmount">Total Amount:</label>
                    <input type="number" id="totalAmount" name="totalAmount" readonly value="${o.totalAmount}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="paymentMethod">Payment Method:</label>
                    <input type="text" id="paymentMethod" name="paymentMethod" readonly value="${o.paymentMethod}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="paymentStatus">Payment Status:</label>
                    <select id="paymentStatus" name="paymentStatus" class="form-control">
                        <option value="unpaid" <c:if test="${o.paymentStatus == 'unpaid'}">selected</c:if>>Unpaid</option>
                        <option value="paid" <c:if test="${o.paymentStatus == 'paid'}">selected</c:if>>Paid</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="shippingAddress">Shipping Address:</label>
                        <input type="text" id="shippingAddress" name="shippingAddress" readonly value="${o.shippingAddress}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="orderStatus">Order Status:</label>
                    <select id="orderStatus" name="orderStatus" class="form-control">
                        <option value="processing" <c:if test="${o.orderStatus == 'processing'}">selected</c:if>>Processing</option>
                        <option value="shipping" <c:if test="${o.orderStatus == 'shipping'}">selected</c:if>>Shipping</option>
                        <option value="delivered" <c:if test="${o.orderStatus == 'delivered'}">selected</c:if>>Delivered</option>
                        <option value="canceled" <c:if test="${o.orderStatus == 'canceled'}">selected</c:if>>Canceled</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">SAVE</button>
            </form>
        </div>
    </body>
</html>
