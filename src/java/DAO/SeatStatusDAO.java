/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.SeatStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Admin
 */
public class SeatStatusDAO  {
    public static SeatStatusDAO INSTANCE = new SeatStatusDAO();
    private Connection connect;
    private String status = "OK";

    private SeatStatusDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }
    
    public List<SeatStatus> getSeatStatusList() {
        String sql = "SELECT * FROM seatStatus";
        List<SeatStatus> seatStatus = new ArrayList<>();
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int statusID = rs.getInt("seatStatusId");
                String statusName = rs.getNString("statusName");
                SeatStatus seat = new SeatStatus(statusID, statusName);
                seatStatus.add(seat);
            }
        } catch (SQLException e) {
            System.out.println("get statu set: " + e);
            return null;
        }
        return seatStatus;
    }
    
   
}
