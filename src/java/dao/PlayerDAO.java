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
public class PlayerDAO extends DBContext {

    public static PlayerDAO INSTANCE = new PlayerDAO();
    private Connection connect;
    private String status = "OK";

    private PlayerDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }
}
