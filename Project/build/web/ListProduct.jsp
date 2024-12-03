<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/home.css">
    </head>
    <style>
        .home{
            margin: 0 20px;
        }
    </style>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>

            <div class="home">
                <div class="row">
                    <div class="col-md-2" style="margin-top: 208px">
                        <!-- Thanh bên cho bộ lọc -->
                        <div class="filters">
                            <h5 style="font-weight: bold; color: black;">Product filter</h5>
                            <form action="filproduct" method="get">
                                <div class="form-group">
                                    <label for="series">Series:</label>
                                    <select name="series" id="series" class="form-control">
                                        <option value="0" <%= request.getParameter("series") != null && request.getParameter("series").equals("0") ? "selected" : "" %>>None</option>
                                    <option value="1" <%= request.getParameter("series") != null && request.getParameter("series").equals("1") ? "selected" : "" %>>Molly</option>
                                    <option value="2" <%= request.getParameter("series") != null && request.getParameter("series").equals("2") ? "selected" : "" %>>Dimoo</option>
                                    <option value="3" <%= request.getParameter("series") != null && request.getParameter("series").equals("3") ? "selected" : "" %>>Hirono</option>
                                    <option value="4" <%= request.getParameter("series") != null && request.getParameter("series").equals("4") ? "selected" : "" %>>Skullpanda</option>
                                    <option value="5" <%= request.getParameter("series") != null && request.getParameter("series").equals("5") ? "selected" : "" %>>Crybaby</option>
                                    <option value="6" <%= request.getParameter("series") != null && request.getParameter("series").equals("6") ? "selected" : "" %>>Pucky</option>
                                    <option value="7" <%= request.getParameter("series") != null && request.getParameter("series").equals("7") ? "selected" : "" %>>Sweet bean</option>
                                    <option value="8" <%= request.getParameter("series") != null && request.getParameter("series").equals("8") ? "selected" : "" %>>Hacipupu</option>
                                    <option value="9" <%= request.getParameter("series") != null && request.getParameter("series").equals("9") ? "selected" : "" %>>Disney</option>
                                    <option value="10" <%= request.getParameter("series") != null && request.getParameter("series").equals("10") ? "selected" : "" %>>Harry potter</option>
                                    <option value="11" <%= request.getParameter("series") != null && request.getParameter("series").equals("11") ? "selected" : "" %>>The monsters</option>
                                    <option value="12" <%= request.getParameter("series") != null && request.getParameter("series").equals("12") ? "selected" : "" %>>Azura</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="priceRange">Range price:</label>
                                <select name="priceRange" id="priceRange" class="form-control">
                                    <option value="0-10000000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("0-10000000") ? "selected" : "" %>>All Price</option>
                                    <option value="0-100000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("0-100000") ? "selected" : "" %>>Under 100.000 ₫</option>
                                    <option value="100000-500000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("100000-500000") ? "selected" : "" %>>100.000 ₫ - 500.000 ₫</option>
                                    <option value="500000-1000000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("500000-1000000") ? "selected" : "" %>>500.000 ₫ - 1.000.000 ₫</option>
                                    <option value="1000000-2000000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("1000000-2000000") ? "selected" : "" %>>1.000.000 ₫ - 2.000.000 ₫</option>
                                    <option value="2000000-10000000" <%= request.getParameter("priceRange") != null && request.getParameter("priceRange").equals("2000000-10000000") ? "selected" : "" %>>Over 2.000.000 ₫</option>
                                </select>
                            </div>

                            <!-- Tương tự cho các trường mega, figures, accessories -->

                            <div class="form-group">
                                <label for="mega">Mega:</label>
                                <select name="mega" id="mega" class="form-control">
                                    <option value="0" <%= request.getParameter("mega") != null && request.getParameter("mega").equals("0") ? "selected" : "" %>>None</option>
                                    <option value="13" <%= request.getParameter("mega") != null && request.getParameter("mega").equals("13") ? "selected" : "" %>>Mega 100%</option>
                                    <option value="14" <%= request.getParameter("mega") != null && request.getParameter("mega").equals("14") ? "selected" : "" %>>Mega 400%</option>
                                    <option value="15" <%= request.getParameter("mega") != null && request.getParameter("mega").equals("15") ? "selected" : "" %>>Mega 1000%</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="figures">Figures:</label>
                                <select name="figures" id="figures" class="form-control">
                                    <option value="0" <%= request.getParameter("figures") != null && request.getParameter("figures").equals("0") ? "selected" : "" %>>None</option>
                                    <option value="16" <%= request.getParameter("figures") != null && request.getParameter("figures").equals("16") ? "selected" : "" %>>Figure</option>
                                    <option value="17" <%= request.getParameter("figures") != null && request.getParameter("figures").equals("17") ? "selected" : "" %>>Action figure</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="accessories">Accessories:</label>
                                <select name="accessories" id="accessories" class="form-control">
                                    <option value="0" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("0") ? "selected" : "" %>>None</option>
                                    <option value="23" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("23") ? "selected" : "" %>>Earphone case</option>
                                    <option value="24" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("24") ? "selected" : "" %>>Earphone bag</option>
                                    <option value="25" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("25") ? "selected" : "" %>>Phone case</option>
                                    <option value="26" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("26") ? "selected" : "" %>>Bag</option>
                                    <option value="27" <%= request.getParameter("accessories") != null && request.getParameter("accessories").equals("27") ? "selected" : "" %>>Plush toy</option>
                                </select>
                            </div>

                            <button style="margin-top: 5px" type="submit" class="btn btn-primary">Search</button>

                            <h5 style="font-weight: bold; color: black; margin-top: 10px">Sort Products</h5>
                            <div class="form-group">
                                <label for="accessories">Sort by price:</label>
                                <select name="sortPrice" id="sortPrice" class="form-control">
                                    <option value="0" <%= request.getParameter("sortPrice") != null && request.getParameter("sortPrice").equals("0") ? "selected" : "" %>>None</option>
                                    <option value="incre" <%= request.getParameter("sortPrice") != null && request.getParameter("sortPrice").equals("incre") ? "selected" : "" %>>Incre</option>  
                                    <option value="decre" <%= request.getParameter("sortPrice") != null && request.getParameter("sortPrice").equals("decre") ? "selected" : "" %>>Decre</option>
                                </select>
                            </div>
                            <button style="margin-top: 5px" type="submit" class="btn btn-primary">Sort</button>
                        </form>

                    </div>

                </div>
                <div class="col-md-10">
                    <h2 class="text-lg-center" style="color: black; margin:120px 0 60px 0; font-weight: bold; font-size: 2rem;">
                        <c:choose>
                            <c:when test="${param.page == 'allproducts'}">ALL PRODUCT</c:when>
                            <c:when test="${param.page == 'molly'}">MOLLY</c:when>
                            <c:when test="${param.page == 'dimoo'}">DIMOO</c:when>
                            <c:when test="${param.page == 'hirono'}">HIRONO</c:when>
                            <c:when test="${param.page == 'skullpanda'}">SKULLPANDA</c:when>
                            <c:when test="${param.page == 'crybaby'}">CRYBABY</c:when>
                            <c:when test="${param.page == 'pucky'}">PUCKY</c:when>
                            <c:when test="${param.page == 'sweetbean'}">SWEET BEAN</c:when>
                            <c:when test="${param.page == 'hacipupu'}">HACIPUPU</c:when>
                            <c:when test="${param.page == 'disney'}">DISNEY</c:when>
                            <c:when test="${param.page == 'harrypotter'}">HARRY POTTER</c:when>
                            <c:when test="${param.page == 'themonsters'}">THE MONSTERS</c:when>
                            <c:when test="${param.page == 'azura'}">AZURA</c:when>
                            <c:when test="${param.page == 'mega100'}">MEGA 100%</c:when>
                            <c:when test="${param.page == 'mega400'}">MEGA 400%</c:when>
                            <c:when test="${param.page == 'mega1000'}">MEGA 1000%</c:when>
                            <c:when test="${param.page == 'figure'}">Figure</c:when>
                            <c:when test="${param.page == 'actionfigure'}">Action Figure</c:when>
                            <c:when test="${param.page == 'phoneaccessories'}">Phone Accessories</c:when>
                            <c:when test="${param.page == 'plushtoys'}">Plush Toys</c:when>
                            <c:when test="${param.page == 'bags'}">Bags</c:when>
                            <c:when test="${param.page == 'allmega'}">ALL MEGA</c:when>
                            <c:when test="${param.page == 'collaborations'}">Collaborations</c:when>
                            <c:when test="${param.page == 'allaccessories'}">ALL Accessories</c:when>
                            <c:when test="${param.page == 'figurine'}">FIGURINE</c:when>
                            <c:when test="${param.page == 'newarrival'}">New Arrival</c:when>
                            <c:when test="${param.page == 'launchcalendar'}">Launch Calendar</c:when>
                            <c:when test="${param.page == 'topselling'}">Top Sellings</c:when>
                            <c:when test="${param.page == 'blindbox'}">Blind Box</c:when>
                            <c:otherwise>Search Results</c:otherwise>
                        </c:choose>
                    </h2>

                    <div class="row">
                        <c:forEach items="${data}" var="p">
                            <div class="col-md-3 mb-4">
                                <div class="card h-100">
                                    <a href="productdetail?pid=${p.pid}">
                                        <img src="${p.image1}" class="card-img-top" alt="${p.pname}" style="width:100%; height:280px; object-fit:cover;"/>
                                        <div class="card-body">
                                            <h5 class="card-title" style="font-size: 1rem; color: black">${p.pname}</h5>
                                            <p class="card-text price" style="color: red">${p.price} ₫</p>
                                            <p class="card-text"><small class="text-muted">Date: ${p.datesell}</small></p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>

        <div style="height: 100px"></div>
        <jsp:include page="Footer.jsp"></jsp:include>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const priceElements = document.querySelectorAll('.price');
                priceElements.forEach(function (el) {
                    let price = parseInt(el.textContent.trim());
                    el.textContent = new Intl.NumberFormat('vi-VN').format(price) + ' ₫';
                });
            });
        </script>
    </body>
</html>
