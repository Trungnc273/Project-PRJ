/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.PrintWriter;
import static java.lang.System.out;

/**
 *
 * @author TRUNG
 */
@WebServlet(name = "SendVerificationEmailServlet", urlPatterns = {"/sendVerificationEmail"})
public class SendVerificationEmailServlet extends HttpServlet {

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
            out.println("<title>Servlet SendVerificationEmailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendVerificationEmailServlet at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        // Kiểm tra xem email có tồn tại trong cơ sở dữ liệu
        if (verifyEmail(email)) {
            String verificationCode = generateVerificationCode();
            // Lưu mã xác minh vào session của người dùng
            request.getSession().setAttribute("verificationCode", verificationCode);

            // Gửi mã xác minh qua email
            if (sendEmail(email, verificationCode)) {
                // Chuyển hướng đến trang nhập mã xác minh nếu gửi thành công
                request.setAttribute("email", email);
                request.getRequestDispatcher("EnterVerificationCode.jsp").forward(request, response);
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error!Try again after a few minutes.');");
                out.println("window.location.href = 'home';");
                out.println("</script>");
            }
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Email not valid');");
            out.println("window.location.href = 'Forgotpassword.jsp';");
            out.println("</script>");
        }
    }

    private String generateVerificationCode() {
        // Tạo mã xác minh ngẫu nhiên, gồm 4 chữ số
        return String.valueOf((int) (Math.random() * 9000) + 1000);
    }

    private boolean sendEmail(String email, String code) {
        String subject = "NCT MART";
        String body = "Code: " + code;

        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); // Thay bằng địa chỉ SMTP server của bạn
            props.put("mail.smtp.port", "587"); // Port thông dụng là 587 cho TLS
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Tạo phiên gửi email với xác thực
            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("ntvippro24@gmail.com", "wywbybbfbhauyekr"); // Thay bằng tài khoản email của bạn
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("support@nctmart.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(body);

            // Gửi email
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean verifyEmail(String email) {
        // Sử dụng AccountDAO để kiểm tra email trong cơ sở dữ liệu
        AccountDAO accountDAO = new AccountDAO();
        return accountDAO.checkEmailExists(email);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý việc gửi mã xác minh qua email cho tính năng quên mật khẩu";
    }
}
