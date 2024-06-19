/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;
import java.util.List;

/**
 *
 * @author admin
 */
public class Contact {
    private int id;
    private String title;
    private String name;
    private String message;
    private Date createdDate;
    private String email;
    private List<ContactCategory> list;

    public Contact() {
    }

    public Contact(int id, String title, String name, String message, Date createdDate, List<ContactCategory> list) {
        this.id = id;
        this.title = title;
        this.name = name;
        this.message = message;
        this.createdDate = createdDate;
        this.list = list;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public List<ContactCategory> getList() {
        return list;
    }

    public void setList(List<ContactCategory> list) {
        this.list = list;
    }
    
    public boolean checkRead(){
        ContactCategory a = new ContactCategory();
        a.setId(1);
        return list.contains(a);
    }
    
    public boolean checkImportant(){
        ContactCategory a = new ContactCategory();
        a.setId(3);
        return list.contains(a);
    }
    
    public boolean checkStarred(){
        ContactCategory a = new ContactCategory();
        a.setId(4);
        return list.contains(a);
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    
}
