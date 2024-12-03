<%-- 
    Document   : UpdateAccount
    Created on : 24 thg 10, 2024, 03:01:00
    Author     : TRUNG
--%>
<%@page import="model.Account"%>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Lấy session và kiểm tra xem tài khoản người dùng đã đăng nhập chưa
    Account account = (Account) session.getAttribute("account");

    // Kiểm tra nếu người dùng chưa đăng nhập
    if (account == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Account</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding: 20px;
                font-family: 'Arial', sans-serif;
            }

            .container {
                max-width: 95%;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                margin-bottom: 20px;
                color: #343a40;
            }

            .form-control {
                border: 1px solid #ced4da;
                border-radius: 5px;
                transition: border-color 0.3s;
            }

            .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
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

            .form-group label {
                font-weight: bold;
            }

            .form-text {
                color: #6c757d;
            }

            .back-btn {
                margin-bottom: 20px;
            }

            @media (max-width: 576px) {
                .container {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% if (account.getRole() != 3) { %>
            <a href="dashboard" class="btn btn-primary back-btn">Back</a>
            <% } else { %>
            <!-- Nút Cancel chỉ hiển thị khi role là 3 -->
            <a href="ordercrud?role=<%= account.getRole() %>&id=<%= account.getId() %>" class="btn btn-primary back-btn">Back</a>
            <% } %>
            <div class="row">
                <div class="col-md-6">
                    <h2>Update Account Information</h2>
                    <form action="updateAccount" method="POST">
                        <div class="form-group">
                            <label for="id">ID:</label>
                            <input type="text" id="id" name="id" class="form-control" value="<%= account.getId() %>" readonly>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone:</label>
                            <input type="text" id="phone" name="phone" class="form-control" value="<%= account.getPhone() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" class="form-control" value="<%= account.getEmail() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="name">Name:</label>
                            <input type="text" id="name" name="name" class="form-control" value="<%= account.getName() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address" class="form-control" value="<%= (account.getAddress() != null) ? account.getAddress() : "" %>" required>
                        </div>

                        <div class="form-group">                   
                            <input type="hidden" id="password" name="password" class="form-control" value="<%= account.getPassword() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="sex">Sex:</label>
                            <select id="sex" name="sex" class="form-control">
                                <option value="1" <%= (account.getSex() == 1) ? "selected" : "" %>>Male</option>
                                <option value="2" <%= (account.getSex() == 2) ? "selected" : "" %>>Female</option>
                                <option value="0" <%= (account.getSex() == 0) ? "selected" : "" %>>Not Specified</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="dob">Date of Birth:</label>
                            <input type="date" id="dob" name="dob" class="form-control" value="<%= account.getDob() %>" required>
                        </div>

                        <button type="submit" class="btn btn-success">Update</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <h2>Change Password</h2>
                    <form action="changePassword" method="POST">                       
                        <div class="form-group">
                            <label for="currentPassword">Curent Password</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                        </div>
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
