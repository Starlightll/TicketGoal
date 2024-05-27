/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Pitch;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;
import java.sql.*;
import java.util.Base64;

/**
 *
 * @author mosdd
 */
public class PitchDAO {

    public static PitchDAO INSTANCE = new PitchDAO();
    private Connection connect;
    private String status = "OK";

    private PitchDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }

    public List<Pitch> getPitchList() {
        String sql = "SELECT * FROM Pitch";
        List<Pitch> pitchList = new ArrayList<Pitch>();
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Pitch pitch = new Pitch();
                pitch.setPitchId(rs.getInt("pitchId"));
                pitch.setPitchName(rs.getNString("pitchName"));
                pitch.setAddressName(rs.getNString("addressName"));
                pitch.setAddressURL(rs.getNString("addressURL"));
                String pitchStructure = Base64.getEncoder().encodeToString(rs.getBytes("pitchStructure"));
                pitch.setPitchStructure(pitchStructure);
                String pitchImage = Base64.getEncoder().encodeToString(rs.getBytes("image"));
                pitch.setImage(pitchImage);
                pitchList.add(pitch);
            }
        } catch (SQLException e) {
            return null;
        }
        return pitchList;
    }

    public int addPitch(String pitchName, String addressName, String addressURL, InputStream pitchStructure, InputStream pitchImage) {
        String sql = "INSERT INTO Pitch (pitchName, addressName, addressURL, pitchStructure, image) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = connect.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.close();
            statement.setNString(1, pitchName);
            statement.setString(2, addressName);
            statement.setString(3, addressURL);

            if (pitchStructure != null) {
                statement.setBlob(4, pitchStructure);
            } else {
                statement.setNull(4, java.sql.Types.BLOB);
            }

            if (pitchImage != null) {
                statement.setBlob(5, pitchImage);
            } else {
                statement.setNull(5, java.sql.Types.BLOB);
            }

            int rowsInserted = statement.executeUpdate();
            

            // Check if a row was inserted
            if (rowsInserted > 0) {
                // Retrieve the generated keys
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    // Return the generated pitchId
                    return generatedKeys.getInt(1);
                }
            }
            return -1; // Return -1 if no ID was generated or row was not inserted
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Return -1 in case of an SQL exception
        }
    }

    public boolean deletePitch(String pitchId) {
        String sql = "DELETE FROM Pitch \n" +
                     "Where Pitch.pitchId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(pitchId));
            int rowAffected = statement.executeUpdate();
            return rowAffected > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public void updatePitch(int pitchId, String pitchName, String address, String pitchStructure, String image) {

    }
    
}
