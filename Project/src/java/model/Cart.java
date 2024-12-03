/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author TRUNG
 */
public class Cart {

    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<Item> getItems() {
        return items;
    }

    public Item getItemById(int id) {
        for (Item i : items) {
            if (i.getProduct().getPid() == id) {
                return i;
            }
        }
        return null;
    }

    public int getQuantityById(int id) {
        return getItemById(id).getQuantity();
    }

    public void addItem(Item t) {
        if (getItemById(t.getProduct().getPid()) != null) {
            Item m = getItemById(t.getProduct().getPid());
            m.setQuantity(m.getQuantity() + t.getQuantity());
        } else {
            items.add(t);
        }
    }

    public void removeItem(int id) {
        if (getItemById(id) != null) {
            items.remove(getItemById(id));
        }
    }

    public double getTotalMoney() {
        double t = 0;
        for (Item i : items) {
            t += i.getQuantity() * i.getPrice();
        }
        return t;
    }

    private Product getProductById(int id, List<Product> list) {
        for (Product i : list) {
            if (i.getPid() == id) {
                return i;
            }
        }
        return null;
    }

    public Cart(String txt, List<Product> list) {
        items = new ArrayList<>();
        try {
            if (txt != null & txt.length() != 0) {
                String[] s = txt.split("\\.");
                for (String i : s) {
                    String[] n = i.split(":");
                    int id = Integer.parseInt(n[0]);
                    int quantity = Integer.parseInt(n[1]);
                    Product p = getProductById(id, list);
                    Item t = new Item(p, quantity, p.getPrice());
                    addItem(t);
                }
            }
        } catch (NumberFormatException e) {

        }
    }

    public void updateQuantity(int productId, int newQuantity) {
        for (Item item : items) { // Ensure this uses the correct 'Item' class
            if (item.getProduct().getPid() == productId) {
                item.setQuantity(newQuantity); // Update quantity for the product
                break; // Exit the loop once the product is found
            }
        }
    }

}
