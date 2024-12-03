/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import model.Account;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "CreateAccountServlet", urlPatterns = {"/createAccount"})
public class CreateAccountServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccountServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String fullName = request.getParameter("name");
            String phoneNumber = request.getParameter("phone");
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // Có thể cần mã hóa password
            String address = request.getParameter("address");
            String sex = request.getParameter("sex");
            String dobString = request.getParameter("dob"); // Giữ nguyên để chuyển đổi
            String role = request.getParameter("role");

            AccountDAO accountDAO = new AccountDAO();

            // Kiểm tra sự tồn tại của số điện thoại hoặc email
            boolean isPhoneExist = accountDAO.checkPhoneExists(phoneNumber);
            boolean isEmailExist = accountDAO.checkEmailExists(email);
            Date dob = java.sql.Date.valueOf(dobString);

            if (isPhoneExist && isEmailExist) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Phone number already exists!\\nEmail already exists!');");
                out.println("location='ManagerAccount.jsp';");
                out.println("</script>");
            } else if (isPhoneExist) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Phone number already exists!');");
                out.println("location='ManagerAccount.jsp';");
                out.println("</script>");
            } else if (isEmailExist) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email already exists!');");
                out.println("location='ManagerAccount.jsp';");
                out.println("</script>");
            } else {
                // Nếu không có lỗi, tạo tài khoản mới
                Account newAccount = new Account();
                newAccount.setName(fullName);
                newAccount.setPhone(phoneNumber);
                newAccount.setEmail(email);
                newAccount.setPassword(password); // Có thể cần mã hóa password
                newAccount.setAddress(address);
                newAccount.setSex(Integer.parseInt(sex));
                newAccount.setDob(dob);
                newAccount.setRole(Integer.parseInt(role));
                boolean isRegistered = accountDAO.signupAccount(newAccount);

                if (isRegistered) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Đăng ký thành công!');");
                    out.println("location='ManagerAccount.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Đã xảy ra lỗi trong quá trình đăng ký!');");
                    out.println("location='ManagerAccount.jsp';");
                    out.println("</script>");
                }
            }
        }
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
