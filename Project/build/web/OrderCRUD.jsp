<%-- 
    Document   : OrderCRUD
    Created on : 26 thg 10, 2024, 15:25:08
    Author     : TRUNG
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Account"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // L?y session và ki?m tra xem có Admin ?ã ??ng nh?p không
    Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">

                            <h2>Manage Order</h2>                            
                        </div>
                        <% if (account.getRole() != 3) { %>
                        <a style="color: yellow" href="exportExcel">Export Excel</a> 
                        <% } %>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th style="width: 5%">OrderID</th>
                            <th style="width: 5%">AccountID</th>
                            <th style="width: 10%">Date</th>
                            <th style="width: 20%">Total</th>
                            <th style="width: 10%">Payment Method</th>
                            <th style="width: 10%">Payment Status</th>
                            <th style="width: 20%">Address</th>
                            <th style="width: 10%">Order Status</th>
                            <th style="width: 10%">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.data}" var="o">
                            <tr>
                                <td>${o.oid}</td>
                                <td style="text-align: center">${o.aid}</td>
                                <td>${o.orderDate}</td>
                                <td class="price">${o.totalAmount}</td>
                                <td>${o.paymentMethod}</td>
                                <td>${o.paymentStatus}</td>
                                <td>${o.shippingAddress}</td>
                                <td>${o.orderStatus}</td>
                                <td>
                                    <% if (account.getRole() != 3) { %>
                                    <!-- Nút Update chỉ hiển thị khi role không phải là 3 -->
                                    <c:choose>
                                        <c:when test="${(o.orderStatus == 'processing'||o.paymentStatus=='unpaid')&&o.orderStatus != 'canceled'}"> <a href="updateOrder?oid=${o.oid}">
                                                <button type="button" class="btn btn-warning">
                                                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                                </button>
                                            </a></c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                    <% } else { %>
                                    <c:choose>
                                        <c:when test="${o.orderStatus == 'processing'}"> <a href="cancelOrder?oid=${o.oid}">
                                                <button type="button" class="btn btn-warning">
                                                    <p style="margin: 2px 2px">Cancel</p>
                                                </button>
                                            </a></c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                    <% } %>
                                    <% if (account.getRole() != 3) { %>

                                    <c:choose>
                                        <c:when test="${(o.orderStatus == 'processing'||o.paymentStatus=='unpaid')&&o.orderStatus != 'canceled'}"> <a onclick="doDelete('${o.oid}')" href="#">
                                                <button type="button" class="btn btn-danger">
                                                    <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                                                </button>
                                            </a></c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                    <% } %>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="pagination justify-content-center">
                    <ul class="pagination">
                        <!-- Previous button -->
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="ordercrud?page=${currentPage - 1}&role=<%= account.getRole() %>&id=<%= account.getId() %>">Previous</a>
                            </li>
                        </c:if>

                        <!-- Page numbers -->
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                                <a class="page-link" href="ordercrud?page=${i}&role=<%= account.getRole() %>&id=<%= account.getId() %>">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Next button -->
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="ordercrud?page=${currentPage + 1}&role=<%= account.getRole() %>&id=<%= account.getId() %>">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const priceElements = document.querySelectorAll('.price');
                priceElements.forEach(function (el) {
                    let price = parseFloat(el.textContent.trim());
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                });
            });
        </script>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure delete oid: " + id + " ?"))
                {
                    window.location = 'deleteOrder?oid=' + id;
                }
            }
        </script>
    </body>
</html>

