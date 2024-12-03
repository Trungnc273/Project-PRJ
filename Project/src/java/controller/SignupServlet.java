/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import dal.AccountDAO;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "SignupServlet", urlPatterns = {"/signup"})
public class SignupServlet extends HttpServlet {

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
            out.println("<title>Servlet SignupServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("Login.jsp").forward(request, response);
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
        String fullName = request.getParameter("name");
        String phoneNumber = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO accountDAO = new AccountDAO();

        // Kiểm tra sự tồn tại của số điện thoại hoặc email
        boolean isPhoneExist = accountDAO.checkPhoneExists(phoneNumber);
        boolean isEmailExist = accountDAO.checkEmailExists(email);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (isPhoneExist && isEmailExist) {
            // Nếu cả số điện thoại và email đều tồn tại
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Phone number already exists!\\nEmail already exists!');");
            out.println("location='Login.jsp?signup=true';");
            out.println("</script>");
        } else if (isPhoneExist) {
            // Nếu chỉ số điện thoại tồn tại
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Phone number already exists!');");
            out.println("location='Login.jsp?signup=true';");
            out.println("</script>");
        } else if (isEmailExist) {
            // Nếu chỉ email tồn tại
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Email already exists!');");
            out.println("location='Login.jsp?signup=true';");
            out.println("</script>");
        } else {
            // Nếu không có lỗi, tạo tài khoản mới
            Account newAccount = new Account();
            newAccount.setName(fullName);
            newAccount.setPhone(phoneNumber);
            newAccount.setEmail(email);
            newAccount.setPassword(password);
            newAccount.setSex(0); // giá trị sex mặc định
            newAccount.setDob(null);
            newAccount.setRole(3);

            boolean isRegistered = accountDAO.signupAccount(newAccount);

            if (isRegistered) {
                // Nếu đăng ký thành công, hiển thị thông báo
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Registration successful!');");
                out.println("location='Login.jsp';");  // Chuyển về trang đăng nhập
                out.println("</script>");
            } else {
                // Nếu có lỗi khi tạo tài khoản
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error occurred during registration!');");
                out.println("location='Login.jsp?signup=true';");  // Chuyển về trang signup
                out.println("</script>");
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
