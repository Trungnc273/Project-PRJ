package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;

/**
 *
 * @author TRUNG
 */
public class AccountDAO extends DBContext {

    public Account checkAuthen(String useraccount, String password) {
        String sql = "SELECT * FROM Accounts WHERE (email = ? OR phone = ?) AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, useraccount);

            if (isNumeric(useraccount)) {
                st.setInt(2, Integer.parseInt(useraccount));
            } else {
                st.setNull(2, java.sql.Types.INTEGER);
            }

            st.setString(3, password);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("password"),
                        rs.getInt("sex"),
                        rs.getDate("dob"),
                        rs.getInt("role")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Phương thức kiểm tra xem một chuỗi có phải là số hay không
    private boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public boolean signupAccount(Account account) {
        String sql = "INSERT INTO Accounts (phone, email, name, address, password, sex, dob, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, account.getPhone()); // 
            st.setString(2, account.getEmail());
            st.setString(3, account.getName());
            st.setString(4, account.getAddress());
            st.setString(5, account.getPassword());
            st.setInt(6, account.getSex());
            st.setDate(7, (Date) account.getDob());
            st.setInt(8, account.getRole());

            return st.executeUpdate() > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            System.out.println(e);
            return false; // Trả về false nếu có lỗi
        }
    }

    public boolean checkPhoneExists(String phone) {
        String query = "SELECT COUNT(*) FROM Accounts WHERE phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Kiểm tra có tồn tại hay không
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM Accounts WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Kiểm tra có tồn tại hay không
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateAccount(int id, String phone, String email, String name, String address, String password, int sex, String dob) {
        String sql = "UPDATE Accounts SET phone = ?, email = ?, name = ?, address = ?, password = ?, sex = ?, dob = ? WHERE id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, phone);  // Cập nhật phone
            pstmt.setString(2, email);
            pstmt.setString(3, name);
            pstmt.setString(4, address);
            pstmt.setString(5, password);
            pstmt.setInt(6, sex);
            pstmt.setString(7, dob);
            pstmt.setInt(8, id);  // Điều kiện WHERE sử dụng id

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changePassword(String email, String password) {
        String sql = "UPDATE Accounts SET password = ? WHERE email = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, password);
            pstmt.setString(2, email);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changePassword(int id, String password) {
        String sql = "UPDATE Accounts SET password = ? WHERE id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, password);
            pstmt.setInt(2, id);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkOldPassword(int accountId, String oldPassword) {
        String query = "SELECT password FROM Accounts WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(oldPassword); // So sánh mật khẩu
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        AccountDAO d = new AccountDAO();
        d.changePassword("gnurtnc@gmail.com", "Trungpro");
        System.out.println(d.checkPhoneExists("123456789"));
    }
}
