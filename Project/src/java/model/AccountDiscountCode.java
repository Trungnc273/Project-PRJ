/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TRUNG
 */
public class AccountDiscountCode {

    private int adid;
    private int aid;
    private int did;

    public AccountDiscountCode() {
    }

    public AccountDiscountCode(int adid, int aid, int did) {
        this.adid = adid;
        this.aid = aid;
        this.did = did;
    }

    public int getAdid() {
        return adid;
    }

    public void setAdid(int adid) {
        this.adid = adid;
    }

    public int getAid() {
        return aid;
    }

    public void setAid(int aid) {
        this.aid = aid;
    }

    public int getDid() {
        return did;
    }

    public void setDid(int did) {
        this.did = did;
    }

}
