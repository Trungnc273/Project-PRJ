<%-- 
    Document   : new
    Created on : 26 thg 9, 2024, 13:38:47
    Author     : TRUNG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Product</title>
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

            .error-message {
                color: red;
                margin-bottom: 20px;
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
        <script>
            function generateSeriesDropdowns() {
                const container = document.getElementById("seriesContainer");
                container.innerHTML = ""; // Xóa các dropdown cũ
                const count = parseInt(document.getElementById("seriesCount").value);

                // Tạo các dropdown mới dựa trên số lượng series
                for (let i = 1; i <= count; i++) {
                    const select = document.createElement("select");
                    select.name = `series`; // Đặt tên để gửi giá trị
                    select.classList.add("form-control", "mb-2");
                    select.innerHTML = `
                 <option value="0">None</option>
                 <option value="1">Molly</option>
                 <option value="2">Dimoo</option>
                 <option value="3">Hirono</option>
                 <option value="4">Skullpanda</option>
                 <option value="5">Crybaby</option>
                 <option value="6">Pucky</option>
                 <option value="7">Sweet bean</option>
                 <option value="8">Hacipupu</option>
                 <option value="9">Disney</option>
                 <option value="10">Harry potter</option>
                 <option value="11">The monsters</option>
                 <option value="12">Azura</option>
                 <option value="13">Mega 100%</option>
                 <option value="14">Mega 400%</option>
                 <option value="15">Mega 1000%</option>
                 <option value="16">Figure</option>
                 <option value="17">Action Figure</option>
                 <option value="18">Detective Conan</option>
                 <option value="19">Sponge Bob</option>
                 <option value="20">Warner Bros</option>
                 <option value="21">Universal Studios</option>
                 <option value="22">League of Legends</option>
                 <option value="23">Earphone Case</option>
                 <option value="24">Earphone Bag</option>
                 <option value="25">Phone Case</option>
                 <option value="26">Bag</option>
                 <option value="27">Plush Toy</option>
                 <option value="28">Blind Box</option>
                 <option value="29">Phone Accessory</option>
             `;
                    container.appendChild(select);
                }
            }

            function collectSeriesValues() {
                const selects = document.querySelectorAll('select[name="series"]');
                const seriesValues = Array.from(selects)
                        .map(select => select.value)
                        .filter(value => value !== "0"); // Loại bỏ giá trị "None"
                const seriesString = seriesValues.join(','); // Tạo chuỗi
                document.getElementById("seriesHiddenInput").value = seriesString; // Ghi vào ô nhập ẩn
            }

            // Gọi hàm collectSeriesValues khi có sự kiện thay đổi
            document.addEventListener('change', collectSeriesValues);
        </script>

    </head>
    <body>
        <div class="container">
            <a href="productcrud" class="btn btn-primary back-btn">Back</a>
            <h1>Add a New Product</h1>
            <h4 class="error-message">${requestScope.error}</h4>
            <form action="add" method="get">
                <div class="form-group">
                    <label for="pid">Enter ID:</label>
                    <input type="number" id="pid" name="pid" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="pname">Enter Name:</label>
                    <input type="text" id="pname" name="pname" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="price">Enter Price:</label>
                    <input type="number" id="price" name="price" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="describe">Enter Description:</label>
                    <input type="text" id="describe" name="describe" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image1">Enter Image 1:</label>
                    <input type="text" id="image1" name="image1" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image2">Enter Image 2:</label>
                    <input type="text" id="image2" name="image2" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image3">Enter Image 3:</label>
                    <input type="text" id="image3" name="image3" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image4">Enter Image 4:</label>
                    <input type="text" id="image4" name="image4" class="form-control">
                </div>

                <div class="form-group">
                    <label for="image5">Enter Image 5:</label>
                    <input type="text" id="image5" name="image5" class="form-control">
                </div>

                <div class="form-group">
                    <label for="imagesize">Enter Image Size:</label>
                    <input type="text" id="imagesize" name="imagesize" class="form-control">
                </div>

                <div class="form-group">
                    <label for="imageinfor">Enter Image Information:</label>
                    <input type="text" id="imageinfor" name="imageinfor" class="form-control">
                </div>

                <div class="form-group">
                    <label for="quantity">Enter Quantity:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="datesell">Enter Date Sell:</label>
                    <input type="date" id="datesell" name="datesell" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="seriesCount">Enter Number of Series:</label>
                    <input type="number" id="seriesCount" name="seriesCount" class="form-control" min="1" max="12" oninput="generateSeriesDropdowns()" required>
                </div>

                <div id="seriesContainer" class="form-group">
                    <!-- Các dropdown sẽ được tạo tự động ở đây -->
                </div>
                <input type="hidden" id="seriesHiddenInput" name="seriesList" value="">
                <button type="submit" class="btn btn-primary">SAVE</button>
            </form>
        </div>

    </body>
</html>

<!--cc-->

