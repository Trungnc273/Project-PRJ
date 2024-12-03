<%-- 
    Document   : ManagerProducts
    Created on : 7 thg 10, 2024, 21:29:47
    Author     : TRUNG
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
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

                            <h2>Manage Product</h2>

                        </div>
                        <div class="col-sm-6">
                            <a href="new.jsp"  class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th style="width: 10%">ID</th>
                            <th style="width: 30%">Name</th>
                            <th style="width: 20%">Image</th>
                            <th style="width: 20%">Price</th>
                            <th style="width: 20%">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.data}" var="p">
                            <tr>
                                <td>${p.pid}</td>
                                <td style="text-align: center">${p.pname}</td>
                                <td>
                                    <img style="height: 80%;width: 80%;border-radius: 0" src="${p.image1}">
                                </td>
                                <td class="price">${p.price} ₫</td>
                                <td>
                                    <a href="update?pid=${p.pid}"><button type="button" class="btn btn-warning"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></button></a>
                                    <a onclick="doDelete('${p.pid}')" href="#"><button type="button" class="btn btn-danger"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></button></a>
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
                                <a class="page-link" href="productcrud?page=${currentPage - 1}">Previous</a>
                            </li>
                        </c:if>

                        <!-- Page numbers -->
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                                <a class="page-link" href="productcrud?page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Next button -->
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="productcrud?page=${currentPage + 1}">Next</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy tất cả các phần tử có class "price"
                const priceElements = document.querySelectorAll('.price');

                // Lặp qua từng phần tử và định dạng giá
                priceElements.forEach(function (el) {
                    let price = parseInt(el.textContent.trim()); // Chuyển giá trị về kiểu số nguyên
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫'; // Định dạng số với dấu chấm phân cách hàng ngàn và thêm '₫'
                });
            });
        </script>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure delete id: " + id + " ?"))
                {
                    window.location = 'delete?pid=' + id;
                }
            }
        </script>
    </body>
</html>
