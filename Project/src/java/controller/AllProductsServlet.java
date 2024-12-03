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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "AllProductsServlet", urlPatterns = {"/allproducts"})
public class AllProductsServlet extends HttpServlet {

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
            out.println("<title>Servlet AllProductsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllProductsServlet at " + request.getContextPath() + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        String subcid = request.getParameter("subcid"); // Lấy subcid từ URL
        String cid = request.getParameter("cid"); // Lấy cid từ URL
        String newArrivalParam = request.getParameter("newarrival"); // Tham số cho sản phẩm mới
        String launchCalendar = request.getParameter("launchcalendar"); // Tham số cho sản phẩm mới
        String topSelling = request.getParameter("topselling"); // Tham số cho sản phẩm mới
        List<Product> productList;

        if ("true".equals(newArrivalParam)) {
            // Lấy danh sách sản phẩm mới
            productList = productDAO.getNewArrival();
        } else if ("true".equals(launchCalendar)) {
            // Lấy danh sách sản chưa tới ngay bán
            productList = productDAO.getLaunchCalendar();
        } else if ("true".equals(topSelling)) {
            // Lấy danh sách sản chưa tới ngay bán
            productList = productDAO.getTopSelling();
        } else if (subcid != null && !subcid.isEmpty()) {
            // Lấy danh sách sản phẩm theo subcid (ID danh mục con)
            productList = productDAO.searchBySubcateID(subcid);
        } else if (cid != null && !cid.isEmpty()) {
            // Lấy danh sách sản phẩm theo cid (ID danh mục)
            int categoryId = Integer.parseInt(cid);
            productList = productDAO.getProductsByCategoryID(categoryId);
        } else {
            // Nếu không có subcid hoặc cid, lấy tất cả sản phẩm
            productList = productDAO.getAll();
        }

        // Gán dữ liệu cho JSP
        request.setAttribute("data", productList);
        request.getRequestDispatcher("ListProduct.jsp").forward(request, response);
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
