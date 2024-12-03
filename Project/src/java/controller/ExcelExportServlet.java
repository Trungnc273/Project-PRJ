// src/controller/ExcelExportServlet.java
package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import model.Order;

@WebServlet(name = "ExcelExportServlet", urlPatterns = {"/exportExcel"})
public class ExcelExportServlet extends HttpServlet {

    private static final int COLUMN_INDEX_ORDER_ID = 0;
    private static final int COLUMN_INDEX_ACCOUNT_ID = 1;
    private static final int COLUMN_INDEX_ORDER_DATE = 2;
    private static final int COLUMN_INDEX_DISCOUN_TID = 3;
    private static final int COLUMN_INDEX_TOTAL = 4;
    private static final int COLUMN_INDEX_PAYMENT_METHOD = 5;
    private static final int COLUMN_INDEX_PAYMENT_STATUS = 6;
    private static final int COLUMN_INDEX_SHIPPING_ADDRESS = 7;
    private static final int COLUMN_INDEX_ORDER_STATUS = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO d = new OrderDAO();
        List<Order> orders = d.getAll();
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Books");
            // Write Header
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(COLUMN_INDEX_ORDER_ID).setCellValue("Order ID");
            headerRow.createCell(COLUMN_INDEX_ACCOUNT_ID).setCellValue("Account ID");
            headerRow.createCell(COLUMN_INDEX_ORDER_DATE).setCellValue("Order date");
            headerRow.createCell(COLUMN_INDEX_DISCOUN_TID).setCellValue("Discount ID");
            headerRow.createCell(COLUMN_INDEX_TOTAL).setCellValue("Total");
            headerRow.createCell(COLUMN_INDEX_PAYMENT_METHOD).setCellValue("Payment method");
            headerRow.createCell(COLUMN_INDEX_PAYMENT_STATUS).setCellValue("Payment status");
            headerRow.createCell(COLUMN_INDEX_SHIPPING_ADDRESS).setCellValue("Address");
            headerRow.createCell(COLUMN_INDEX_ORDER_STATUS).setCellValue("Order status");
            // Write Data Rows
            int rowIndex = 1;
            for (Order order : orders) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(COLUMN_INDEX_ORDER_ID).setCellValue(order.getOid());
                row.createCell(COLUMN_INDEX_ACCOUNT_ID).setCellValue(order.getAid());
                row.createCell(COLUMN_INDEX_ORDER_DATE).setCellValue(order.getOrderDate());
                row.createCell(COLUMN_INDEX_DISCOUN_TID).setCellValue(order.getDid());
                row.createCell(COLUMN_INDEX_TOTAL).setCellValue(order.getTotalAmount());
                row.createCell(COLUMN_INDEX_PAYMENT_METHOD).setCellValue(order.getPaymentMethod());
                row.createCell(COLUMN_INDEX_PAYMENT_STATUS).setCellValue(order.getPaymentStatus());
                row.createCell(COLUMN_INDEX_SHIPPING_ADDRESS).setCellValue(order.getShippingAddress());
                row.createCell(COLUMN_INDEX_ORDER_STATUS).setCellValue(order.getOrderStatus());
            }
            // Set HTTP response headers
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=orders.xlsx");
            // Write workbook to output stream
            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        }
    }

}
