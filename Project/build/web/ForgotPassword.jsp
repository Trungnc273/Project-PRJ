<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
        <script src="./js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container">
                <h2 class="text-center" style="margin-top: 10%">Forgot Password</h2>
                <form class="d-flex justify-content-center" style="margin-bottom: 13.5%" action="sendVerificationEmail" method="post">
                    <div class="col-md-4">
                        <label for="email" class="form-label">Enter your Email:</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <button style="height: 40px;margin-top: 30px;margin-left: 10px" type="submit" class="btn btn-primary">Send</button>
                </form>
            </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
