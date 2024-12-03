<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enter Verification Code</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
        <script src="./js/bootstrap.bundle.min.js"></script>
        <script>
            window.onload = function () {
            <c:if test="${not empty requestScope.errorMessage}">
                alert("${requestScope.errorMessage}");
            </c:if>
            };
        </script>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container">
                <h2 class="text-center" style="margin-top: 10%">Enter Verification Code</h2>
                <form class="d-flex justify-content-center" style="margin-bottom: 12.5%" action="verifyCode" method="post">
                    <div class="mb-3">
                        <label for="code" class="form-label">Enter Code:</label>
                        <input type="hidden" name="email" value="${requestScope.email}" required>
                    <input type="text" id="code" name="code" class="form-control" required>
                </div>
                <button style="height: 40px;margin-top: 30px;margin-left: 10px"  type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
