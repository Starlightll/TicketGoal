/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Area;
import Models.Seat;
import Models.SeatStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ADMIN
 */
public class SeatDAO {
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
        String query = "SELECT *\n" +
                "FROM (SELECT * FROM Seat s) AS T1 INNER JOIN (Select * from Area a) AS T2 ON T1.areaId = T2.areaId\n" +
                "         LEFT JOIN (SELECT * FROM Ticket WHERE ticketStatusId = 1 AND matchId = ?) AS T3\n" +
                "                    ON T1.seatId = T3.seatId;";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, matchId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int seatId = rs.getInt("seatId");
                int seatNumber = rs.getInt("seatNumber");
                int row = rs.getInt("row");
                int price = rs.getInt("price");
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getNString("areaName"));
                int seatStatusId = 1;
                if (rs.getInt("ticketStatusId") == 1) {
                    seatStatusId = 3;
                }
                if (rs.getInt("ticketStatusId") == 2) {
                    seatStatusId = 5;
                }
                Seat seat = new Seat(seatId, seatNumber, row, price, area, seatStatusId, matchId);
                matchSeats.add(seat);
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Get all seat of match: " + e);
        }
        return matchSeats;
    }


    public boolean updateSeatStatus(int seatId, int statusId) {
        String query = "UPDATE Seat SET seatStatusId = ? WHERE seatId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, statusId);
            statement.setInt(2, seatId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Update seat status: " + e);
        }
        return false;
    }


    public void updateSeatPrice(int seatId, int price) {
        String query = "UPDATE Seat SET price = ? WHERE seatId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, price);
            statement.setInt(2, seatId);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Update seat price: " + e);
        }
    }

    public void updateSeatPriceByArea(int areaId, int price) {
        String query = "UPDATE Seat SET price = ? WHERE areaId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, price);
            statement.setInt(2, areaId);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            System.out.println("Update seat price by area: " + e);
        }
    }

    public long getSeatPrice(int seatId) {
        String query = "SELECT price FROM Seat WHERE seatId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, seatId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getLong("price");
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Get seat price: " + e);
        }
        return 0;
    }

    public Seat getSeatById(int seatId) {
        String query = "SELECT * FROM Seat JOIN Area ON SEAT.areaId = Area.areaId WHERE seatId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1, seatId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int seatNumber = rs.getInt("seatNumber");
                int row = rs.getInt("row");
                int price = rs.getInt("price");
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getNString("areaName"));
                int seatStatusId = rs.getInt("seatStatusId");
                int matchId = rs.getInt("matchId");
                return new Seat(seatId, seatNumber, row, price, area, seatStatusId, matchId);
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Get seat by id: " + e);
        }
        return null;
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
