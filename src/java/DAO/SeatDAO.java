/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import DB.DBContext;
import Models.Seat;
import Models.SeatStatus;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SeatDAO extends  DBContext{
    private Connection connection;
    
    public List<Seat> findAll() {
        String sql = "SELECT * FROM Seat";
        connection = new DBContext().getConnection();
        List<Seat> listFound = new ArrayList<>();
        try {
            //- Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //- Set parameter ( optional )
            //- Thực thi câu lệnh
            ResultSet resultSet = statement.executeQuery();
            //- trả về kết quả
            while (resultSet.next()) {
                int seatId = resultSet.getInt("seatId");
                int seatNumber = resultSet.getInt("seatNumber");
                int price = resultSet.getInt("price");
                int areaId = resultSet.getInt("areaId");
                int seatStatusId = resultSet.getInt("seatStatusId");

                Seat seat = new Seat(seatId, seatNumber, price, areaId, seatStatusId);
                listFound.add(seat);
            }
        } catch (Exception e) {
        }
        return listFound;
    }

    public void insert(Seat seat) {
        String sql = "INSERT INTO [Seat]\n"
                + "           ([seatNumber]\n"
                + "           ,[price]\n"
                + "           ,[areaId]\n"
                + "           ,[seatStatusId])\n"
                + "     VALUES\n"
                + "           (?, ? , ? , ?)";
        connection = new DBContext().getConnection();
        if(seat.getSeatNumber() <= 0 || seat.getPrice() <= 0) {
            return;
        }
        try {
            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
            PreparedStatement statement = connection.prepareStatement(sql,
                    Statement.RETURN_GENERATED_KEYS);
            //set parameter
            statement.setObject(1, seat.getSeatNumber());
            statement.setObject(2, seat.getPrice());
            statement.setObject(3, seat.getAreaId());
            statement.setObject(4, seat.getSeatStatusId());
            //thuc thi cau lenh
            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void edit(Seat seat) {
        String sql = "UPDATE [Seat]\n"
                + "   SET [seatNumber] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[areaId] = ?\n"
                + "      ,[seatStatusId] = ?\n"
                + " WHERE seatId = ?";
        connection = new DBContext().getConnection();
        if(seat.getSeatNumber() <= 0 || seat.getPrice() <= 0) {
            return;
        }
        try {
            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
            PreparedStatement statement = connection.prepareStatement(sql,
                    Statement.RETURN_GENERATED_KEYS);
            //set parameter
            statement.setObject(1, seat.getSeatNumber());
            statement.setObject(2, seat.getPrice());
            statement.setObject(3, seat.getAreaId());
            statement.setObject(4, seat.getSeatStatusId());
            statement.setObject(5, seat.getSeatId());
            //thuc thi cau lenh
            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Seat> findAllByAreaId(int pitchId) {
        String sql = "SELECT * FROM Seat where areaId =?";
        connection = new DBContext().getConnection();
        List<Seat> listFound = new ArrayList<>();
        try {
            //- Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //- Set parameter ( optional )
            statement.setInt(1, pitchId);
            //- Thực thi câu lệnh
            ResultSet resultSet = statement.executeQuery();
            //- trả về kết quả
            while (resultSet.next()) {
                int seatId = resultSet.getInt("seatId");
                int seatNumber = resultSet.getInt("seatNumber");
                int price = resultSet.getInt("price");
                int areaId = resultSet.getInt("areaId");
                int seatStatusId = resultSet.getInt("seatStatusId");

                Seat seat = new Seat(seatId, seatNumber, price, areaId, seatStatusId);
                listFound.add(seat);
            }
        } catch (Exception e) {
        }
        return listFound;
    }
    
    public Seat findAllById(int id) {
        String sql = "SELECT * FROM Seat where seatId =?";
        connection = new DBContext().getConnection();
        List<Seat> listFound = new ArrayList<>();
        try {
            //- Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //- Set parameter ( optional )
            statement.setInt(1, id);
            //- Thực thi câu lệnh
            ResultSet resultSet = statement.executeQuery();
            //- trả về kết quả
            if (resultSet.next()) {
                int seatId = resultSet.getInt("seatId");
                int seatNumber = resultSet.getInt("seatNumber");
                int price = resultSet.getInt("price");
                int areaId = resultSet.getInt("areaId");
                int seatStatusId = resultSet.getInt("seatStatusId");

                Seat seat = new Seat(seatId, seatNumber, price, areaId, seatStatusId);
                return seat;
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public Seat finSeatByIdNumber(int areaId, int number) {
        String sql = "SELECT * FROM Seat where areaId =? and seatNumber=?";
        connection = new DBContext().getConnection();
        List<Seat> listFound = new ArrayList<>();
        try {
            //- Tạo đối tượng PrepareStatement
            PreparedStatement statement = connection.prepareStatement(sql);
            //- Set parameter ( optional )
            statement.setInt(1, areaId);
            statement.setInt(2, number);
            //- Thực thi câu lệnh
            ResultSet resultSet = statement.executeQuery();
            //- trả về kết quả
            if (resultSet.next()) {
                int seatId = resultSet.getInt("seatId");
                int seatNumber = resultSet.getInt("seatNumber");
                int price = resultSet.getInt("price");
                int seatStatusId = resultSet.getInt("seatStatusId");

                Seat seat = new Seat(seatId, seatNumber, price, areaId, seatStatusId);
                return seat;
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public int deleteSeat(int id) {
        String sql = "delete from Seat where seatId=?";
        connection = new DBContext().getConnection();
        try {
            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            //thuc thi cau lenh
            return statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int deleteSeatByArea(int areaId) {
        String sql = "delete from Seat where areaId=?";
        connection = new DBContext().getConnection();
        try {
            //tao doi tuong prepared statement ( them generated key vao tham so thu 2)
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, areaId);
            //thuc thi cau lenh
            return statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
     public SeatStatus getSeatStatusById(int statusId) {
        String sql = "SELECT * FROM seatStatus where seatStatusId = ?";
         connection = new DBContext().getConnection();
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, statusId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int statusID = rs.getInt("seatStatusId");
                String statusName = rs.getNString("statusName");
                SeatStatus seat = new SeatStatus(statusID, statusName);
                return seat;
            }
        } catch (SQLException e) {
            System.out.println("get statu set: " + e);
            return null;
        }
        return null;
    }

}
