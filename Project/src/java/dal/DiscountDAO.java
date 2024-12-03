/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.DiscountCode;

/**
 *
 * @author TRUNG
 */
public class DiscountDAO extends DBContext {

    public boolean addDiscountCodeToAccount(int accountId, int discountCodeId) {
        String sql = "INSERT INTO AccountDiscountCodes (aid, did) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountId);
            st.setInt(2, discountCodeId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public List<DiscountCode> searchDiscountCodeByCode(String code) {
        List<DiscountCode> discountCodes = new ArrayList<>();
        String sql = "SELECT * FROM DiscountCodes WHERE code = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, code);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int did = rs.getInt("did");
                String discountCode = rs.getString("code");
                String type = rs.getString("type");
                int value = rs.getInt("value");
                Date startDate = rs.getDate("startDate");
                boolean isActive = rs.getBoolean("isActive");

                DiscountCode discount = new DiscountCode(did, discountCode, type, value, startDate, isActive);
                discountCodes.add(discount);
            }
        } catch (SQLException e) {
            System.out.println("Error searching discount code: " + e.getMessage());
        }

        return discountCodes; // Trả về danh sách mã giảm giá tìm được
    }

    public DiscountCode validateDiscountCode(String code) {
        DiscountCode discountCode = null;
        String sql = "SELECT * FROM DiscountCodes WHERE code = ? AND isActive = 1 AND startDate <= ?";
        LocalDate now = LocalDate.now(); // Lấy ngày hiện tại
        Date currentDate = Date.valueOf(now); // Chuyển đổi LocalDate sang java.sql.Date

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, code);
            st.setDate(2, currentDate); // Sử dụng currentDate để so sánh

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int did = rs.getInt("did");
                String discountCodeValue = rs.getString("code");
                String type = rs.getString("type");
                int value = rs.getInt("value");
                Date startDate = rs.getDate("startDate");
                boolean isActive = rs.getBoolean("isActive");

                // Tạo đối tượng DiscountCode
                discountCode = new DiscountCode(did, discountCodeValue, type, value, startDate, isActive);
            }
        } catch (SQLException e) {
            System.out.println("Error validating discount code: " + e.getMessage());
        }

        return discountCode;
    }

    public boolean hasUsedDiscountCode(int accountId, int discountCodeId) {
        String sql = "SELECT COUNT(*) FROM AccountDiscountCodes WHERE aid = ? AND did = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, accountId);
            st.setInt(2, discountCodeId);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // Trả về true nếu đã sử dụng mã, ngược lại false
            }
        } catch (SQLException e) {
            System.out.println("Error checking if discount code is used: " + e.getMessage());
        }
        return false; // Trả về false nếu có lỗi
    }

}
