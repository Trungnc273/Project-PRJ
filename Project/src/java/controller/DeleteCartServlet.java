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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Product;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "DeleteCartServlet", urlPatterns = {"/deletecart"})
public class DeleteCartServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteCartServlet at " + request.getContextPath() + "</h1>");
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
        // Lấy danh sách sản phẩm từ ProductDAO
        ProductDAO d = new ProductDAO();
        List<Product> list = d.getAll(); // Lấy danh sách tất cả sản phẩm

        // Lấy giá trị của giỏ hàng từ cookie
        Cookie[] arr = request.getCookies();
        String txt = "";
        if (arr != null) {
            for (Cookie o : arr) {
                if (o.getName().equals("cart")) {
                    txt = o.getValue(); // Lấy giá trị của cookie giỏ hàng
                    o.setMaxAge(0); // Xóa cookie cũ
                    response.addCookie(o);
                }
            }
        }

        // Lấy productId của sản phẩm cần xóa
        String pid = request.getParameter("productId");

        // Kiểm tra và xóa sản phẩm khỏi chuỗi giỏ hàng trong cookie
        if (!txt.isEmpty()) {
            // Chuỗi giỏ hàng có dạng "pid1:quantity1.pid2:quantity2"
            String[] products = txt.split("\\.");
            StringBuilder newTxt = new StringBuilder();
            for (String product : products) {
                String[] details = product.split(":");
                if (!details[0].equals(pid)) { // Nếu productId khác với sản phẩm cần xóa
                    if (newTxt.length() > 0) {
                        newTxt.append("."); // Thêm dấu "." nếu không phải sản phẩm đầu tiên
                    }
                    newTxt.append(product); // Giữ lại sản phẩm không bị xóa
                }
            }
            txt = newTxt.toString();
        }

        // Cập nhật lại cookie giỏ hàng
        Cookie c = new Cookie("cart", txt);
        c.setMaxAge(30 * 24 * 60 * 60); // Cookie có thời hạn 30 ngày
        response.addCookie(c);

        // Cập nhật số lượng sản phẩm trong giỏ hàng vào session
        Cart cart = new Cart(txt, list); // Tạo giỏ hàng mới từ chuỗi cookie và danh sách sản phẩm
        int itemCount = cart.getItems().size(); // Đếm số lượng sản phẩm sau khi xóa

        // Lưu số lượng sản phẩm vào session
        request.getSession().setAttribute("cartSize", itemCount); // Cập nhật lại session

        // Chuyển hướng người dùng về trang giỏ hàng hoặc trang trước đó
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer);
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
