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
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import model.Order;
import model.Product;

/**
 *
 * @author TRUNG
 */
public class OrderDAO extends DBContext {

    public String getSalesGrowthMessage() {
        double currentSales = getTotalSalesForCurrentMonthValue();
        double lastMonthSales = getTotalSalesForLastMonthValue();
        String growthMessage = calculateGrowthRateMessage(currentSales, lastMonthSales);

        return growthMessage;
    }

    public String getOrderGrowthMessage() {
        int currentOrder = getTotalOrdersForCurrentMonthValue();
        int lastMonthOrder = getTotalOrdersForLastMonthValue();
        String growthMessage = calculateOrderGrowthRateMessage(currentOrder, lastMonthOrder);

        return growthMessage;
    }

    public String getCustomerGrowthMessage() {
        int currentCustomer = getUniqueCustomersForCurrentMonth();
        int lastMonthCustomer = getUniqueCustomersForLastMonth();
        String growthMessage = calculateCustomerGrowthRateMessage(currentCustomer, lastMonthCustomer);

        return growthMessage;
    }

    public String getTotalSalesForCurrentMonth() {
        double currentSales = getTotalSalesForCurrentMonthValue();
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String formattedCurrentSales = currencyFormat.format(currentSales);
        return formattedCurrentSales;
    }

    public String getTotalOrderForCurrentMonth() {
        String currentOrder = getTotalOrdersForCurrentMonthValue() + "";
        return currentOrder;
    }

    public String getTotalCustomerForCurrentMonth() {
        String currentOrder = getUniqueCustomersForCurrentMonth() + "";
        return currentOrder;
    }

    private double getTotalSalesForCurrentMonthValue() {
        double totalSales = 0.0;

        // Lấy tháng và năm hiện tại
        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        String sql = "SELECT SUM(total_amount) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, currentMonth);
            stmt.setInt(2, currentYear);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalSales = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSales; // Trả về giá trị chưa định dạng
    }

    private double getTotalSalesForLastMonthValue() {
        double totalSales = 0.0;

        // Lấy tháng và năm hiện tại
        LocalDate now = LocalDate.now();
        LocalDate lastMonth = now.minusMonths(1);
        int lastMonthValue = lastMonth.getMonthValue();
        int lastYearValue = lastMonth.getYear();

        String sql = "SELECT SUM(total_amount) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lastMonthValue);
            stmt.setInt(2, lastYearValue);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalSales = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSales; // Trả về giá trị chưa định dạng
    }

    private String calculateGrowthRateMessage(double currentSales, double lastMonthSales) {
        if (lastMonthSales == 0) {
            return "Increased by 100%"; // Nếu tháng trước không có doanh thu
        }

        double difference = currentSales - lastMonthSales; // Tính sự khác biệt giữa doanh thu tháng hiện tại và tháng trước
        double growthRate = (difference / lastMonthSales) * 100; // Tính tỷ lệ phần trăm tăng trưởng

        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        if (growthRate > 0) {
            return "Increased by " + String.format("%.2f", growthRate) + "%";
        } else if (growthRate < 0) {
            return "Decreased by " + String.format("%.2f", -growthRate) + "%";
        } else {
            return "No change";
        }
    }

    private int getTotalOrdersForCurrentMonthValue() {
        int totalOrders = 0;

        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        String sql = "SELECT COUNT(*) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, currentMonth);
            stmt.setInt(2, currentYear);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalOrders;
    }

    private int getTotalOrdersForLastMonthValue() {
        int totalOrders = 0;

        LocalDate now = LocalDate.now();
        LocalDate lastMonth = now.minusMonths(1);
        int lastMonthValue = lastMonth.getMonthValue();
        int lastYearValue = lastMonth.getYear();

        String sql = "SELECT COUNT(*) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lastMonthValue);
            stmt.setInt(2, lastYearValue);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalOrders;
    }

    private String calculateOrderGrowthRateMessage(int currentOrderCount, int lastMonthOrderCount) {
        if (lastMonthOrderCount == 0) {
            return "Orders increased by " + currentOrderCount; // Nếu tháng trước không có đơn hàng
        }

        int difference = currentOrderCount - lastMonthOrderCount;
        double orderGrowthRate = (double) difference / lastMonthOrderCount * 100;

        if (orderGrowthRate > 0) {
            return "Orders increased by " + String.format("%.2f", orderGrowthRate) + "%";
        } else if (orderGrowthRate < 0) {
            return "Orders decreased by " + String.format("%.2f", -orderGrowthRate) + "%";
        } else {
            return "No change in orders";
        }
    }

    private int getUniqueCustomersForCurrentMonth() {
        int totalCustomers = 0;

        LocalDate now = LocalDate.now();
        int currentMonth = now.getMonthValue();
        int currentYear = now.getYear();

        String sql = "SELECT COUNT(DISTINCT aid) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, currentMonth);
            stmt.setInt(2, currentYear);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalCustomers = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCustomers;
    }

    private int getUniqueCustomersForLastMonth() {
        int totalCustomers = 0;

        LocalDate now = LocalDate.now();
        LocalDate lastMonth = now.minusMonths(1);
        int lastMonthValue = lastMonth.getMonthValue();
        int lastYearValue = lastMonth.getYear();

        String sql = "SELECT COUNT(DISTINCT aid) AS total FROM Orders "
                + "WHERE order_status = 'delivered' "
                + "AND MONTH(order_date) = ? "
                + "AND YEAR(order_date) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lastMonthValue);
            stmt.setInt(2, lastYearValue);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalCustomers = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCustomers;
    }

    private String calculateCustomerGrowthRateMessage(int currentCustomerCount, int lastMonthCustomerCount) {
        if (lastMonthCustomerCount == 0) {
            return "Customers increased by " + currentCustomerCount; // Nếu tháng trước không có khách hàng
        }

        int difference = currentCustomerCount - lastMonthCustomerCount;
        double customerGrowthRate = (double) difference / lastMonthCustomerCount * 100;

        if (customerGrowthRate > 0) {
            return "Customers increased by " + difference + " (" + String.format("%.2f", customerGrowthRate) + "%)";
        } else if (customerGrowthRate < 0) {
            return "Customers decreased by " + -difference + " (" + String.format("%.2f", -customerGrowthRate) + "%)";
        } else {
            return "No change in customers";
        }
    }

    public double[] getSalesDataByMonth() {
        double[] monthlySales = new double[12]; // Mảng chứa doanh thu của 12 tháng
        String sql = "SELECT MONTH(order_date) AS month, SUM(total_amount) AS total "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear()); // Lấy năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                double total = rs.getDouble("total");
                monthlySales[month - 1] = total; // Gán tổng doanh thu vào đúng vị trí tháng trong mảng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlySales;
    }

    public double[] getSalesDataByMonthLastYear() {
        double[] monthlySales = new double[12]; // Mảng chứa doanh thu của 12 tháng
        String sql = "SELECT MONTH(order_date) AS month, SUM(total_amount) AS total "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear() - 1); // Lấy năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                double total = rs.getDouble("total");
                monthlySales[month - 1] = total; // Gán tổng doanh thu vào đúng vị trí tháng trong mảng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlySales;
    }

    public double[] getSalesDataByMonthTwoYearAgo() {
        double[] monthlySales = new double[12]; // Mảng chứa doanh thu của 12 tháng
        String sql = "SELECT MONTH(order_date) AS month, SUM(total_amount) AS total "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear() - 2); // Lấy năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                double total = rs.getDouble("total");
                monthlySales[month - 1] = total; // Gán tổng doanh thu vào đúng vị trí tháng trong mảng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlySales;
    }

    public int[] getOrdersPerMonth() {
        int[] monthlyOrders = new int[12]; // Mảng chứa số lượng đơn hàng cho 12 tháng

        String sql = "SELECT MONTH(order_date) AS month, COUNT(*) AS order_count "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear()); // Đặt năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                int orderCount = rs.getInt("order_count");
                monthlyOrders[month - 1] = orderCount; // Gán số lượng đơn hàng vào đúng tháng tương ứng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyOrders; // Trả về mảng chứa số lượng đơn hàng của 12 tháng
    }

    public int[] getOrdersPerMonthLastYear() {
        int[] monthlyOrders = new int[12]; // Mảng chứa số lượng đơn hàng cho 12 tháng

        String sql = "SELECT MONTH(order_date) AS month, COUNT(*) AS order_count "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear() - 1); // Đặt năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                int orderCount = rs.getInt("order_count");
                monthlyOrders[month - 1] = orderCount; // Gán số lượng đơn hàng vào đúng tháng tương ứng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyOrders; // Trả về mảng chứa số lượng đơn hàng của 12 tháng
    }

    public int[] getOrdersPerMonthTwoYearAgo() {
        int[] monthlyOrders = new int[12]; // Mảng chứa số lượng đơn hàng cho 12 tháng

        String sql = "SELECT MONTH(order_date) AS month, COUNT(*) AS order_count "
                + "FROM Orders WHERE order_status = 'delivered' AND YEAR(order_date) = ? "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, LocalDate.now().getYear() - 2); // Đặt năm hiện tại
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("month");
                int orderCount = rs.getInt("order_count");
                monthlyOrders[month - 1] = orderCount; // Gán số lượng đơn hàng vào đúng tháng tương ứng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyOrders; // Trả về mảng chứa số lượng đơn hàng của 12 tháng
    }

    public int[] getDistinctCustomersPerMonth() {
        int[] customersPerMonth = new int[12];
        // Thực hiện truy vấn SQL để lấy số lượng khách hàng distinct cho mỗi tháng
        // Giả sử bạn đã có kết nối đến cơ sở dữ liệu
        String sql = "SELECT MONTH(order_date) AS month, COUNT(DISTINCT aid) AS customer_count "
                + "FROM orders "
                + "WHERE order_status = 'delivered' "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int month = rs.getInt("month") - 1; // Giảm 1 để phù hợp với chỉ số mảng (0-11)
                customersPerMonth[month] = rs.getInt("customer_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customersPerMonth;
    }

    public int[] getDistinctCustomersPerMonthLastYear() {
        int[] customersPerMonth = new int[12];
        String sql = "SELECT MONTH(order_date) AS month, COUNT(DISTINCT aid) AS customer_count "
                + "FROM orders "
                + "WHERE YEAR(order_date) = ? "
                + "AND order_status = 'delivered' "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, LocalDate.now().getYear() - 1); // Gán năm năm ngoái vào truy vấn
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int month = rs.getInt("month") - 1; // Giảm 1 để phù hợp với chỉ số mảng (0-11)
                    customersPerMonth[month] = rs.getInt("customer_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customersPerMonth;
    }

    public int[] getDistinctCustomersPerMonthTwoYearAgo() {
        int[] customersPerMonth = new int[12];
        String sql = "SELECT MONTH(order_date) AS month, COUNT(DISTINCT aid) AS customer_count "
                + "FROM orders "
                + "WHERE YEAR(order_date) = ? "
                + "AND order_status = 'delivered' "
                + "GROUP BY MONTH(order_date)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, LocalDate.now().getYear() - 2); // Gán năm năm ngoái vào truy vấn
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int month = rs.getInt("month") - 1; // Giảm 1 để phù hợp với chỉ số mảng (0-11)
                    customersPerMonth[month] = rs.getInt("customer_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customersPerMonth;
    }

    public int[] getOrderCountBySubCategory() {
        // Mảng 12 phần tử, mỗi phần tử tương ứng với subcid từ 1 đến 12
        int[] orderCount = new int[12];

        String sql = "SELECT scp.subcid, COUNT(od.pid) AS order_count "
                + "FROM OrderDetail od "
                + "JOIN Products p ON od.pid = p.pid "
                + "JOIN SubCategoryProduct scp ON p.pid = scp.pid "
                + "WHERE scp.subcid BETWEEN 1 AND 12 "
                + "GROUP BY scp.subcid";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int subcid = rs.getInt("subcid");
                int count = rs.getInt("order_count");

                // Gán giá trị vào mảng tại vị trí subcid-1 (do mảng bắt đầu từ 0)
                orderCount[subcid - 1] = count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderCount;
    }

    public int insertOrder(int aid, double totalAmount, String shippingAddress, String paymentMethod) {
        String sql = "INSERT INTO Orders (aid, order_date, total_amount, payment_method, payment_status, shipping_address, order_status) "
                + "VALUES (?, GETDATE(), ?, ?, 'unpaid', ?, 'processing')";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, aid);
            preparedStatement.setDouble(2, totalAmount);
            preparedStatement.setString(3, paymentMethod);
            preparedStatement.setString(4, shippingAddress);

            preparedStatement.executeUpdate(); // Thực hiện chèn dữ liệu vào bảng
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return getLastOrderId(); // Trả về id của đơn hàng mới được chèn
    }

    public void insertOrderDetail(int oid, int pid, int quantity, int price) {
        String sql = "INSERT INTO OrderDetail (oid, pid, quantity, price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, oid); // Chèn oid
            preparedStatement.setInt(2, pid); // Chèn pid
            preparedStatement.setInt(3, quantity); // Chèn quantity
            preparedStatement.setInt(4, price);

            preparedStatement.executeUpdate();
            System.out.println("Order detail inserted successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getLastOrderId() {
        String sql = "SELECT TOP 1 oid FROM Orders ORDER BY oid DESC"; // Lấy đơn hàng mới nhất dựa trên order_date
        int lastOrderId = 0;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                lastOrderId = rs.getInt("oid"); // Lấy giá trị id của đơn hàng mới nhất
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lastOrderId; // Trả về id của đơn hàng mới nhất
    }

    public List<Order> getAll() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql); ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Order order = new Order();
                order.setOid(resultSet.getInt("oid"));
                order.setAid(resultSet.getInt("aid"));
                order.setOrderDate(resultSet.getDate("order_date"));
                order.setDid(resultSet.getInt("did"));
                order.setTotalAmount(resultSet.getDouble("total_amount"));
                order.setPaymentMethod(resultSet.getString("payment_method"));
                order.setPaymentStatus(resultSet.getString("payment_status"));
                order.setShippingAddress(resultSet.getString("shipping_address"));
                order.setOrderStatus(resultSet.getString("order_status"));

                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> getOrdersByPage(int start, int total) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY order_date DESC, oid OFFSET ?  ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOid(rs.getInt("oid"));
                order.setAid(rs.getInt("aid"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setDid(rs.getInt("did"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setOrderStatus(rs.getString("order_status"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

// Phương thức tính tổng số lượng đơn hàng
    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> getOrdersByPageByAid(int aid, int start, int total) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE aid = ? ORDER BY order_date DESC, oid OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, aid);
            ps.setInt(2, start);
            ps.setInt(3, total);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOid(rs.getInt("oid"));
                order.setAid(rs.getInt("aid"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setDid(rs.getInt("did"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setOrderStatus(rs.getString("order_status"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
// Phương thức tính tổng số lượng đơn hàng cho một tài khoản cụ thể

    public int getTotalOrderCountByAid(int aid) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE aid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, aid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void update(Order o) {
        String sql = "update Orders set payment_status=?, order_status=? where oid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, o.getPaymentStatus());
            st.setString(2, o.getOrderStatus());
            st.setInt(3, o.getOid());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void cancelOrder(int id, String o) {
        String sql = "update Orders set order_status=? where oid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, o);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Order getOrderByID(int id) {
        String sql = "select * from Orders where oid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setOid(rs.getInt("oid"));
                o.setAid(rs.getInt("aid"));
                o.setOrderDate(rs.getDate("order_date"));
                o.setDid(rs.getInt("did"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setPaymentStatus(rs.getString("payment_status"));
                o.setShippingAddress(rs.getString("shipping_address"));
                o.setOrderStatus(rs.getString("order_status"));
                return o;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteOrder(int orderId) {
        String deleteOrderDetailSql = "DELETE FROM OrderDetail WHERE oid = ?";
        String deleteOrderSql = "DELETE FROM Orders WHERE oid = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu giao dịch

            // Xóa các bản ghi trong OrderDetail trước
            try (PreparedStatement pstmt1 = connection.prepareStatement(deleteOrderDetailSql)) {
                pstmt1.setInt(1, orderId);
                pstmt1.executeUpdate();
            }

            // Sau đó xóa đơn hàng
            try (PreparedStatement pstmt2 = connection.prepareStatement(deleteOrderSql)) {
                pstmt2.setInt(1, orderId);
                pstmt2.executeUpdate();
            }

            connection.commit(); // Cam kết giao dịch
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
    }

    public static void main(String[] args) {
        OrderDAO d = new OrderDAO();
        System.out.println(d.getOrdersByPageByAid(4, 1, 5).get(1).getOid());
    }

}
