/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import java.sql.Connection;

/**
 *
 * @author mosdd
 */
public class AccountDAO {
    
    public static AccountDAO INSTANCE = new AccountDAO();
    private Connection connect;
    private String status = "OK";

    private AccountDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }
}