/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "OrderCRUDServlet", urlPatterns = {"/ordercrud"})
public class OrderCRUDServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderCRUDServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderCRUDServlet at " + request.getContextPath() + "</h1>");
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
    private static final int USER_ROLE = 3;
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int role = Integer.parseInt(request.getParameter("role"));
            int id = 0;
            if (request.getParameter("id") != null) {
                id = Integer.parseInt(request.getParameter("id"));
            }
            int currentPage = request.getParameter("page") != null
                    ? Integer.parseInt(request.getParameter("page"))
                    : 1;

            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders;
            int totalRecords;

            // Kiểm tra role để xác định danh sách đơn hàng cần lấy
            if (role == USER_ROLE) {
                orders = orderDAO.getOrdersByPageByAid(id, (currentPage - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
                totalRecords = orderDAO.getTotalOrderCountByAid(id);
            } else {
                orders = orderDAO.getOrdersByPage((currentPage - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
                totalRecords = orderDAO.getTotalOrderCount();
            }

            int totalPages = (int) Math.ceil(totalRecords * 1.0 / RECORDS_PER_PAGE);

            // Truyền dữ liệu vào request
            request.setAttribute("data", orders);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Chuyển tiếp tới trang JSP
            request.getRequestDispatcher("ManagerOrder.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
