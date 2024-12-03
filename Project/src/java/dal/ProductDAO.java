/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author TRUNG
 */
public class ProductDAO extends DBContext {

    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from Products";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        List<Product> list = p.filterProducts("0", "0-10000000", "0", "0", "0", "incre");
        System.out.println(list.get(1).getPid());
        System.out.println(list.get(1).getPname());
        System.out.println(list.get(1).getDescribe());
        p.insertSubCategoryProduct(9, 36);
    }

    public void insertSubCategoryProduct(int subcid, int pid) {
        String sql = "INSERT INTO SubCategoryProduct (subcid, pid) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, subcid);
            ps.setInt(2, pid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //insert
    public void insert(Product p) {
        String sql = "insert into products values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, p.getPid());
            st.setString(2, p.getPname());
            st.setInt(3, p.getPrice());
            st.setString(4, p.getDescribe());
            st.setString(5, p.getImage1());
            st.setString(6, p.getImage2());
            st.setString(7, p.getImage3());
            st.setString(8, p.getImage4());
            st.setString(9, p.getImage5());
            st.setString(10, p.getImagesize());
            st.setString(11, p.getImageinfor());
            st.setInt(12, p.getQuantity());
            st.setDate(13, (Date) p.getDatesell());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
//check exsied

    public Product getProductByID(int id) {
        String sql = "select * from products where pid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                return p;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //update
    public void update(Product p) {
        String sql = "update products set pname=?, price=?, describe=?, image1=?, image2=?, image3=?, image4=?, image5=?, imagesize=?, imageinfor=?, quantity=?, datesell=? where pid=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getPname());
            st.setInt(2, p.getPrice());
            st.setString(3, p.getDescribe());
            st.setString(4, p.getImage1());
            st.setString(5, p.getImage2());
            st.setString(6, p.getImage3());
            st.setString(7, p.getImage4());
            st.setString(8, p.getImage5());
            st.setString(9, p.getImagesize());
            st.setString(10, p.getImageinfor());
            st.setInt(11, p.getQuantity());
            st.setDate(12, (Date) p.getDatesell());
            st.setInt(13, p.getPid());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //    xoa
    public void delete(int id) {
        String sqlSubCategoryProduct = "DELETE FROM SubCategoryProduct WHERE pid = ?";
        String sqlOrderDetail = "DELETE FROM OrderDetail WHERE pid = ?";
        String sqlProducts = "DELETE FROM Products WHERE pid = ?";

        try {
            // Bắt đầu một transaction để đảm bảo việc xóa là toàn vẹn
            connection.setAutoCommit(false);

            // Xóa liên kết trong bảng SubCategoryProduct
            try (PreparedStatement st1 = connection.prepareStatement(sqlSubCategoryProduct)) {
                st1.setInt(1, id);
                st1.executeUpdate();
            }

            // Xóa liên kết trong bảng OrderDetail
            try (PreparedStatement st2 = connection.prepareStatement(sqlOrderDetail)) {
                st2.setInt(1, id);
                st2.executeUpdate();
            }

            // Cuối cùng, xóa sản phẩm trong bảng Products
            try (PreparedStatement st3 = connection.prepareStatement(sqlProducts)) {
                st3.setInt(1, id);
                st3.executeUpdate();
            }

            // Hoàn tất transaction
            connection.commit();
        } catch (SQLException e) {
            try {
                // Nếu có lỗi, rollback transaction
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                // Khôi phục chế độ auto-commit
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    //get product order by date sell but day datesell<=today
    public List<Product> getNewArrival() {
        String sql = "SELECT *\n"
                + "FROM Products\n"
                + "WHERE datesell >= DATEADD(month, -3, GETDATE())\n"
                + "AND datesell < GETDATE()\n"
                + "ORDER BY datesell DESC;";
        List<Product> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

//    search follow subcategory
    public List<Product> searchBySubcateID(String subcid) {
        List<Product> list = new ArrayList<>();
        try {
            // Loại bỏ 'where' thừa
            String sql = "SELECT * FROM Products p JOIN SubCategoryProduct scp ON p.pid = scp.pid WHERE 1=1";
            if (subcid != null && !subcid.trim().isEmpty()) {
                sql += " AND scp.subcid = ? ORDER BY datesell DESC";
            }
            PreparedStatement ps = connection.prepareStatement(sql);
            if (subcid != null && !subcid.trim().isEmpty()) {
                ps.setString(1, subcid);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);  // Thêm sản phẩm vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //search by name
    public List<Product> searchByName(String name) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE pname LIKE ? ORDER BY datesell DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getProductsByCategoryID(int cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT DISTINCT p.*\n"
                + "FROM Products p\n"
                + "JOIN SubCategoryProduct scp ON p.pid = scp.pid\n"
                + "JOIN SubCategories sc ON scp.subcid = sc.subcid\n"
                + "WHERE sc.cid = ? ORDER BY datesell DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy sản phẩm có ngày bán lớn hơn ngày hiện tại
    public List<Product> getLaunchCalendar() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE datesell > ? ORDER BY datesell DESC";
        try {
            // Lấy ngày hiện tại
            java.util.Date today = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(today.getTime());

            PreparedStatement st = connection.prepareStatement(sql);
            st.setDate(1, sqlDate);  // Gán ngày hiện tại vào câu truy vấn
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);  // Thêm sản phẩm vào danh sách
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

// Top sell
    public List<Product> getTopSelling() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    p.pid,             \n"
                + "    p.pname,           \n"
                + "    p.price,          \n"
                + "    p.[describe],      \n"
                + "    p.image1,         \n"
                + "    p.image2,         \n"
                + "    p.image3,         \n"
                + "    p.image4,       \n"
                + "    p.image5,       \n"
                + "    p.imagesize,      \n"
                + "    p.imageinfor,    \n"
                + "    p.quantity,       \n"
                + "    p.datesell,       \n"
                + "    SUM(od.quantity) AS total_quantity \n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    OrderDetail od ON o.oid = od.oid\n"
                + "JOIN \n"
                + "    Products p ON od.pid = p.pid\n"
                + "WHERE \n"
                + "    o.order_status = 'delivered'\n"
                + "GROUP BY \n"
                + "    p.pid, p.pname, p.price, p.[describe], p.image1, p.image2, p.image3, p.image4, p.image5, p.imagesize, p.imageinfor, p.quantity, p.datesell\n"
                + "ORDER BY \n"
                + "    total_quantity DESC; "; // Sắp xếp theo tổng số lượng đã giao, giảm dần

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);  // Thêm sản phẩm vào danh sách
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> filterProducts(String seriesId, String priceRange, String megaId, String figuriesId, String accessoriesId, String sortPrice) {
        List<Product> list = new ArrayList<>();
        // Câu SQL gốc với WHERE (1=1) để dễ thêm điều kiện
        try {
            String sql = "SELECT DISTINCT p.* FROM Products p JOIN SubCategoryProduct sp ON p.pid = sp.pid WHERE (1=1)";

            // Sử dụng dấu ngoặc đơn để nhóm các điều kiện subcategories với OR
            boolean hasSubCategoryFilter = false;
            if (!seriesId.equals("0") || !megaId.equals("0") || !figuriesId.equals("0") || !accessoriesId.equals("0")) {
                sql += " AND (";
                if (!seriesId.equals("0")) {
                    sql += "sp.subcid = ?";
                    hasSubCategoryFilter = true;
                }
                if (!megaId.equals("0")) {
                    if (hasSubCategoryFilter) {
                        sql += " OR ";
                    }
                    sql += "sp.subcid = ?";
                    hasSubCategoryFilter = true;
                }
                if (!figuriesId.equals("0")) {
                    if (hasSubCategoryFilter) {
                        sql += " OR ";
                    }
                    sql += "sp.subcid = ?";
                    hasSubCategoryFilter = true;
                }
                if (!accessoriesId.equals("0")) {
                    if (hasSubCategoryFilter) {
                        sql += " OR ";
                    }
                    sql += "sp.subcid = ?";
                }
                sql += ")";
            }

            // Điều kiện lọc theo khoảng giá
            sql += " AND (p.price > ? AND p.price < ?)";
            if (sortPrice.equals("incre")) {
                sql += " ORDER BY p.price";
            }
            if (sortPrice.equals("decre")) {
                sql += " ORDER BY p.price DESC";
            }
            // Chuẩn bị câu lệnh SQL
            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;

            // Gán giá trị cho các tham số subcategories (int)
            if (!seriesId.equals("0")) {
                ps.setInt(index++, Integer.parseInt(seriesId));
            }
            if (!megaId.equals("0")) {
                ps.setInt(index++, Integer.parseInt(megaId));
            }
            if (!figuriesId.equals("0")) {
                ps.setInt(index++, Integer.parseInt(figuriesId));
            }
            if (!accessoriesId.equals("0")) {
                ps.setInt(index++, Integer.parseInt(accessoriesId));
            }

            // Gán giá trị cho khoảng giá (int)
            String[] priceParts = priceRange.split("-");
            ps.setInt(index++, Integer.parseInt(priceParts[0]));
            ps.setInt(index++, Integer.parseInt(priceParts[1]));

            // Thực thi truy vấn và xử lý kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setDescribe(rs.getString("describe"));
                p.setImage1(rs.getString("image1"));
                p.setImage2(rs.getString("image2"));
                p.setImage3(rs.getString("image3"));
                p.setImage4(rs.getString("image4"));
                p.setImage5(rs.getString("image5"));
                p.setImagesize(rs.getString("imagesize"));
                p.setImageinfor(rs.getString("imageinfor"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDatesell(rs.getDate("datesell"));
                list.add(p);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isProductInOrderDetail(int pid) {
        String sql = "SELECT COUNT(*) FROM OrderDetail WHERE pid = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, pid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // Nếu có ít nhất một dòng, trả về true
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Không có dòng nào trong OrderDetail tương ứng với sản phẩm này
    }

    // Phương thức lấy danh sách sản phẩm theo trang
    public List<Product> getProductsByPage(int start, int total) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY pid OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setPrice(rs.getInt("price"));
                p.setImage1(rs.getString("image1"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

// Phương thức tính tổng số sản phẩm
    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM Products";
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

    public List<Product> getProductsBySubidFromPid(int pid) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT DISTINCT p.* FROM Products p "
                + "JOIN SubCategoryProduct scp ON p.pid = scp.pid "
                + "WHERE scp.subcid IN ( "
                + "   SELECT subcid FROM SubCategoryProduct WHERE pid = ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setPid(rs.getInt("pid"));
                product.setPname(rs.getString("pname"));
                product.setPrice(rs.getInt("price"));
                product.setDescribe(rs.getString("describe"));
                product.setImage1(rs.getString("image1"));
                product.setImage2(rs.getString("image2"));
                product.setImage3(rs.getString("image3"));
                product.setImage4(rs.getString("image4"));
                product.setImage5(rs.getString("image5"));
                product.setImagesize(rs.getString("imagesize"));
                product.setImageinfor(rs.getString("imageinfor"));
                product.setQuantity(rs.getInt("quantity"));
                product.setDatesell(rs.getDate("datesell"));
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return productList;
    }

}
