<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
        <script src="./js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container">
                <h2 class="text-center" style="margin-top: 10%">Enter your new password:</h2>
                <form class="d-flex justify-content-center" style="margin-bottom: 12.5%" action="resetPassword" method="post">
                    <div class="mb-3">
                        <label for="pass" class="form-label">Enter new password:</label>
                        <input type="hidden" name="email" value="${requestScope.email}" required>
                    <input type="text" id="pass" name="pass" class="form-control" required>
                </div>
                <button style="height: 40px;margin-top: 30px;margin-left: 10px"  type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
