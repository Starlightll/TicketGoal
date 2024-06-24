/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Seat;
import Models.SeatStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SeatDAO{
    public static SeatDAO INSTANCE = new SeatDAO();
    private Connection connect;
    private String status = "OK";

    private SeatDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }


    public List<Seat> getAllSeatOfMatch(int matchId) {
        List<Seat> matchSeats = new ArrayList<>();
        String query = "SELECT * FROM (SELECT * FROM Seat s) AS T1\n" +
                "         LEFT JOIN (SELECT * FROM Ticket WHERE ticketStatusId = 1 AND matchId = ?) AS T2\n" +
                "                    ON T1.seatId = T2.seatId;";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, matchId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int seatId = rs.getInt("seatId");
                int seatNumber = rs.getInt("seatNumber");
                int row = rs.getInt("row");
                int price = rs.getInt("price");
                int areaId = rs.getInt("areaId");
                int seatStatusId = 1;
                if(rs.getInt("ticketStatusId")==1){
                    seatStatusId = 3;
                }
                Seat seat = new Seat(seatId, seatNumber, row, price, areaId, seatStatusId);
                matchSeats.add(seat);
            }
        } catch (SQLException e) {
            System.out.println("Get all seat of match: " + e);
        }
        return matchSeats;
    }








    public List<Seat> findAll() {
        List<Seat> listFound = new ArrayList<>();
//        String sql = "SELECT * FROM Seat";
//        connection = new DBContext().getConnection();
//        try {
//            //- Tạo đối tượng PrepareStatement
//            PreparedStatement statement = connection.prepareStatement(sql);
//            //- Set parameter ( optional )
//            //- Thực thi câu lệnh
//            ResultSet resultSet = statement.executeQuery();
//            //- trả về kết quả
//            while (resultSet.next()) {
//                int seatId = resultSet.getInt("seatId");
//                int seatNumber = resultSet.getInt("seatNumber");
//                int price = resultSet.getInt("price");
//                int areaId = resultSet.getInt("areaId");
//                int seatStatusId = resultSet.getInt("seatStatusId");
//
//                Seat seat = new Seat(seatId, seatNumber, 0,price, areaId, seatStatusId);
//                listFound.add(seat);
//            }
//        } catch (Exception e) {
//        }
        return listFound;
    }

    public int insert(Seat seat) {
//        String sql = "INSERT INTO [Seat]\n"
//                + "           ([seatNumber]\n"
//                + "           ,[price]\n"
//                + "           ,[areaId]\n"
//                + "           ,[seatStatusId])\n"
//                + "     VALUES\n"
//                + "           (?, ? , ? , ?)";
//        connection = new DBContext().getConnection();
//        if(seat.getSeatNumber() <= 0 || seat.getPrice() <= 0) {
//            return 0;
//        }
//        try {
//            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
//            PreparedStatement statement = connection.prepareStatement(sql,
//                    Statement.RETURN_GENERATED_KEYS);
//            //set parameter
//            statement.setObject(1, seat.getSeatNumber());
//            statement.setObject(2, seat.getPrice());
//            statement.setObject(3, seat.getAreaId());
//            statement.setObject(4, seat.getSeatStatusId());
//            //thuc thi cau lenh
//            return statement.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return 0;
    }

    public int edit(Seat seat) {
//        String sql = "UPDATE [Seat]\n"
//                + "   SET [seatNumber] = ?\n"
//                + "      ,[price] = ?\n"
//                + "      ,[areaId] = ?\n"
//                + "      ,[seatStatusId] = ?\n"
//                + " WHERE seatId = ?";
//        connection = new DBContext().getConnection();
//        if(seat.getSeatNumber() <= 0 || seat.getPrice() <= 0) {
//            return 0;
//        }
//        try {
//            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
//            PreparedStatement statement = connect.prepareStatement(sql,
//                    Statement.RETURN_GENERATED_KEYS);
//            //set parameter
//            statement.setObject(1, seat.getSeatNumber());
//            statement.setObject(2, seat.getPrice());
//            statement.setObject(3, seat.getAreaId());
//            statement.setObject(4, seat.getSeatStatusId());
//            statement.setObject(5, seat.getSeatId());
//            //thuc thi cau lenh
//            return statement.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return 0;
    }
    
    public List<Seat> findAllByAreaId(int pitchId) {
//        String sql = "SELECT * FROM Seat where areaId =?";
//        connection = new DBContext().getConnection();
//        List<Seat> listFound = new ArrayList<>();
//        try {
//            //- Tạo đối tượng PrepareStatement
//            PreparedStatement statement = connection.prepareStatement(sql);
//            //- Set parameter ( optional )
//            statement.setInt(1, pitchId);
//            //- Thực thi câu lệnh
//            ResultSet resultSet = statement.executeQuery();
//            //- trả về kết quả
//            while (resultSet.next()) {
//                int seatId = resultSet.getInt("seatId");
//                int seatNumber = resultSet.getInt("seatNumber");
//                int price = resultSet.getInt("price");
//                int areaId = resultSet.getInt("areaId");
//                int seatStatusId = resultSet.getInt("seatStatusId");
//
//                Seat seat = new Seat(seatId, seatNumber, 0, price, areaId, seatStatusId);
//                listFound.add(seat);
//            }
//        } catch (Exception e) {
//        }
//        return listFound;
        return null;
    }
    
    public Seat findAllById(int id) {
//        String sql = "SELECT * FROM Seat where seatId =?";
//        connection = new DBContext().getConnection();
//        List<Seat> listFound = new ArrayList<>();
//        try {
//            //- Tạo đối tượng PrepareStatement
//            PreparedStatement statement = connection.prepareStatement(sql);
//            //- Set parameter ( optional )
//            statement.setInt(1, id);
//            //- Thực thi câu lệnh
//            ResultSet resultSet = statement.executeQuery();
//            //- trả về kết quả
//            if (resultSet.next()) {
//                int seatId = resultSet.getInt("seatId");
//                int seatNumber = resultSet.getInt("seatNumber");
//                int price = resultSet.getInt("price");
//                int areaId = resultSet.getInt("areaId");
//                int seatStatusId = resultSet.getInt("seatStatusId");
//
//                Seat seat = new Seat(seatId, seatNumber, 0, price, areaId, seatStatusId);
//                return seat;
//            }
//        } catch (Exception e) {
//        }
        return null;
    }
    
    public Seat finSeatByIdNumber(int areaId, int number) {
//        String sql = "SELECT * FROM Seat where areaId =? and seatNumber=?";
//        connection = new DBContext().getConnection();
//        List<Seat> listFound = new ArrayList<>();
//        try {
//            //- Tạo đối tượng PrepareStatement
//            PreparedStatement statement = connection.prepareStatement(sql);
//            //- Set parameter ( optional )
//            statement.setInt(1, areaId);
//            statement.setInt(2, number);
//            //- Thực thi câu lệnh
//            ResultSet resultSet = statement.executeQuery();
//            //- trả về kết quả
//            if (resultSet.next()) {
//                int seatId = resultSet.getInt("seatId");
//                int seatNumber = resultSet.getInt("seatNumber");
//                int price = resultSet.getInt("price");
//                int seatStatusId = resultSet.getInt("seatStatusId");
//
//                Seat seat = new Seat(seatId, seatNumber, 0, price, areaId, seatStatusId);
//                return seat;
//            }
//        } catch (Exception e) {
//        }
        return null;
    }
    
    public int deleteSeat(int id) {
//        String sql = "delete from Seat where seatId=?";
//        connection = new DBContext().getConnection();
//        try {
//            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, id);
//            //thuc thi cau lenh
//            return statement.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return 0;
    }
    
    public int deleteSeatByArea(int areaId) {
//        String sql = "delete from Seat where areaId=?";
//        connection = new DBContext().getConnection();
//        try {
//            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, areaId);
//            //thuc thi cau lenh
//            return statement.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return 0;
    }
    
     public SeatStatus getSeatStatusById(int statusId) {
//        String sql = "SELECT * FROM seatStatus where seatStatusId = ?";
//         connection = new DBContext().getConnection();
//        try {
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, statusId);
//            ResultSet rs = statement.executeQuery();
//            if (rs.next()) {
//                int statusID = rs.getInt("seatStatusId");
//                String statusName = rs.getNString("statusName");
//                SeatStatus seat = new SeatStatus(statusID, statusName);
//                return seat;
//            }
//        } catch (SQLException e) {
//            System.out.println("get statu set: " + e);
//            return null;
//        }
        return null;
    }

}
