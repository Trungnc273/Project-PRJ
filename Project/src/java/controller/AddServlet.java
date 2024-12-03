/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Product;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "AddServlet", urlPatterns = {"/add"})
public class AddServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            // Lấy thông tin từ request
            String id_raw = request.getParameter("pid");
            String name = request.getParameter("pname");
            String price_raw = request.getParameter("price");
            String describe = request.getParameter("describe");
            String image1 = request.getParameter("image1");
            String image2 = request.getParameter("image2");
            String image3 = request.getParameter("image3");
            String image4 = request.getParameter("image4");
            String image5 = request.getParameter("image5");
            String imagesize = request.getParameter("imagesize");
            String imageinfor = request.getParameter("imageinfor");
            String quantity_raw = request.getParameter("quantity");
            String datesell_raw = request.getParameter("datesell");

            // Khai báo biến
            int id, price, quantity;
            Date datesell;

            try {
                // Chuyển đổi dữ liệu
                id = Integer.parseInt(id_raw);
                price = Integer.parseInt(price_raw);
                quantity = Integer.parseInt(quantity_raw);
                datesell = java.sql.Date.valueOf(datesell_raw);

                ProductDAO pd = new ProductDAO();
                // Kiểm tra sản phẩm đã tồn tại
                if (pd.getProductByID(id) != null) {
                    request.setAttribute("error", id + " đã tồn tại.");
                    request.getRequestDispatcher("new.jsp").forward(request, response);
                    return;
                }

                // Tạo và thêm sản phẩm mới
                Product p_new = new Product(id, name, price, describe, image1, image2, image3, image4, image5, imagesize, imageinfor, quantity, datesell);
                pd.insert(p_new);
                // Xử lý subcategories
                String seriesList_raw = request.getParameter("seriesList");
                List<Integer> seriesList = new ArrayList<>();

                if (seriesList_raw != null && !seriesList_raw.isEmpty()) {
                    String[] seriesArray = seriesList_raw.split(","); // Tách chuỗi
                    for (String seriesId : seriesArray) {
                        seriesList.add(Integer.parseInt(seriesId.trim())); // Chuyển đổi thành Integer và thêm vào danh sách
                    }
                }

                // Thêm sản phẩm vào các subcategory tương ứng
                for (int subCategoryId : seriesList) {
                    pd.insertSubCategoryProduct(subCategoryId, id);
                }

                // Chuyển hướng về trang quản lý sản phẩm
                response.sendRedirect("productcrud");
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Đầu vào không hợp lệ cho các trường số. Vui lòng thử lại.");
                request.getRequestDispatcher("new.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.");
                request.getRequestDispatcher("new.jsp").forward(request, response);
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
