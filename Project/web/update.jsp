<%-- 
    Document   : new
    Created on : 26 thg 9, 2024, 13:38:47
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
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.3.0/ckeditor5.css">
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
        <c:set var="p" value="${requestScope.product}" />
        <div class="container">
            <a href="productcrud" class="btn btn-primary back-btn">Back</a>
            <h1>Update a Product</h1>
            <form action="update" method="post">
                <div class="form-group">
                    <label for="pid">ID:</label>
                    <input type="number" id="pid" readonly name="pid" value="${p.pid}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="pname">Enter Name:</label>
                    <input type="text" id="pname" name="pname" value="${p.pname}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="price">Enter Price:</label>
                    <input type="number" id="price" name="price" value="${p.price}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="describe">Enter Description:</label>
                    <textarea id="editor" name="describe" class="form-control" required>${p.describe}</textarea>
                </div>

                <div class="form-group">
                    <label for="image1">Enter Image 1:</label>
                    <input type="text" id="image1" name="image1" value="${p.image1}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="image2">Enter Image 2:</label>
                    <input type="text" id="image2" name="image2" value="${p.image2}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="image3">Enter Image 3:</label>
                    <input type="text" id="image3" name="image3" value="${p.image3}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="image4">Enter Image 4:</label>
                    <input type="text" id="image4" name="image4" value="${p.image4}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="image5">Enter Image 5:</label>
                    <input type="text" id="image5" name="image5" value="${p.image5}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="imagesize">Enter Image Size:</label>
                    <input type="text" id="imagesize" name="imagesize" value="${p.imagesize}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="imageinfor">Enter Image Information:</label>
                    <input type="text" id="imageinfor" name="imageinfor" value="${p.imageinfor}" class="form-control">
                </div>

                <div class="form-group">
                    <label for="quantity">Enter Quantity:</label>
                    <input type="number" id="quantity" name="quantity" value="${p.quantity}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="datesell">Enter Date Sell:</label>
                    <input type="date" id="datesell" name="datesell" value="${p.datesell}" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary">SAVE</button>
            </form>
        </div>
        <script type="importmap">
            {
            "imports": {
            "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/43.3.0/ckeditor5.js",
            "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/43.3.0/"
            }
            }
        </script>
        <script type="module">
            import {
            ClassicEditor,
                    Essentials,
                    Paragraph,
                    Bold,
                    Italic,
                    Font
            } from 'ckeditor5';

            ClassicEditor
                    .create(document.querySelector('#editor'), {
                        plugins: [Essentials, Paragraph, Bold, Italic, Font],
                        toolbar: [
                            'undo', 'redo', '|', 'bold', 'italic', '|',
                            'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor'
                        ]
                    })
                    .then(editor => {
                        window.editor = editor;
                    })
                    .catch(error => {
                        console.error(error);
                    });
            document.querySelector('form').addEventListener('submit', function () {
                // Đồng bộ nội dung của CKEditor vào textarea trước khi submit form
                document.querySelector('#editor').value = window.editor.getData();
            });

        </script>
    </body>
</html>

