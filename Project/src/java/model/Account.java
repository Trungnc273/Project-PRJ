package model;

import java.util.Date;

/**
 *
 * @author TRUNG
 */
public class Account {

    private int id;
    private String phone; // Đổi từ int thành String
    private String email;
    private String name;
    private String address;
    private String password;
    private int sex;
    private Date dob;
    private int role;

    public Account() {
    }

    public Account(int id, String phone, String email, String name, String address, String password, int sex, Date dob, int role) {
        this.id = id;
        this.phone = phone; // phone giờ là String
        this.email = email;
        this.name = name;
        this.address = address;
        this.password = password;
        this.sex = sex;
        this.dob = dob;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() { // Sửa kiểu trả về thành String
        return phone;
    }

    public void setPhone(String phone) { // Sửa kiểu tham số thành String
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
