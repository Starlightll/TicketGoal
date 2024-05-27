/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import DB.DBContext;
import Models.Seat;
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

}
