/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author TRUNG
 */
public class Product {

    private int pid;
    private String pname;
    private int price;
    private String describe, image1, image2, image3, image4, image5, imagesize, imageinfor;
    private int quantity;
    private Date datesell;
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    public Product() {
    }

    public Product(int pid, String pname, int price, String describe, String image1, String image2, String image3, String image4, String image5, String imagesize, String imageinfor, int quantity, Date datesell) {
        this.pid = pid;
        this.pname = pname;
        this.price = price;
        this.describe = describe;
        this.image1 = image1;
        this.image2 = image2;
        this.image3 = image3;
        this.image4 = image4;
        this.image5 = image5;
        this.imagesize = imagesize;
        this.imageinfor = imageinfor;
        this.quantity = quantity;
        this.datesell = datesell;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getImage1() {
        return image1;
    }

    public void setImage1(String image1) {
        this.image1 = image1;
    }

    public String getImage2() {
        return image2;
    }

    public void setImage2(String image2) {
        this.image2 = image2;
    }

    public String getImage3() {
        return image3;
    }

    public void setImage3(String image3) {
        this.image3 = image3;
    }

    public String getImage4() {
        return image4;
    }

    public void setImage4(String image4) {
        this.image4 = image4;
    }

    public String getImage5() {
        return image5;
    }

    public void setImage5(String image5) {
        this.image5 = image5;
    }

    public String getImagesize() {
        return imagesize;
    }

    public void setImagesize(String imagesize) {
        this.imagesize = imagesize;
    }

    public String getImageinfor() {
        return imageinfor;
    }

    public void setImageinfor(String imageinfor) {
        this.imageinfor = imageinfor;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getDatesell() {
        return datesell;
    }

    public void setDatesell(Date datesell) {
        this.datesell = datesell;
    }

    public SimpleDateFormat getSdf() {
        return sdf;
    }

    public void setSdf(SimpleDateFormat sdf) {
        this.sdf = sdf;
    }

}
