/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TRUNG
 */
public class SubCategory {

    private int subcid;
    private String subcname;
    private Category category;

    public SubCategory() {
    }

    public SubCategory(int subcid, String subcname, Category category) {
        this.subcid = subcid;
        this.subcname = subcname;
        this.category = category;
    }

    public int getSubcid() {
        return subcid;
    }

    public void setSubcid(int subcid) {
        this.subcid = subcid;
    }

    public String getSubcname() {
        return subcname;
    }

    public void setSubcname(String subcname) {
        this.subcname = subcname;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

}
