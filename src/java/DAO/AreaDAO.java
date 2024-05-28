/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Area;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mosdd
 */
public class AreaDAO {
    public static AreaDAO INSTANCE = new AreaDAO();
    private Connection connect;

    private AreaDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }
    
    public List<Area> getAllArea(String pitchId){
        List<Area> areaList = new ArrayList<>();
        String sql = "SELECT * FROM Area WHERE pitchId = ?";
        try(PreparedStatement statement = connect.prepareStatement(sql)){
            statement.setNString(1, pitchId);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getNString("areaName"));
                areaList.add(area);
            }
        }catch(SQLException e){
            return null;
        }
        return areaList; 
    }
    
    public boolean addArea(String areaName, String pitchId) {
        String sql = "INSERT INTO Area VALUES (?, ?)";
        try(PreparedStatement statement = connect.prepareStatement(sql)){
            statement.setNString(1, areaName);
            statement.setNString(2, pitchId);
            int insertedRow = statement.executeUpdate();
            return insertedRow > 0;
        }catch(SQLException e){
            return false;
        }
    }
    
    public boolean deleteArea(String areaId) {
        String sql = "DELETE FROM Area WHERE areaId = ?";
        try (PreparedStatement statement = connect.prepareStatement(sql)) {
            statement.setNString(1,areaId);
            int deletedRow = statement.executeUpdate();
            return deletedRow > 0;
        } catch (SQLException e) {
            return false;
        }
    }
    
    public static void main (String args[]) {
        AreaDAO area = AreaDAO.INSTANCE;
        List<Area> areaList = area.getAllArea("7");
    }
}
