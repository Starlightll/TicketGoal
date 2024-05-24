/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Pitch;
import java.sql.Connection;
import java.util.List;

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
    
    private List<Pitch> getPitchList() {
        
        
        return null;
    }
    
    private void addPitch(String pitchName, String address, String pitchStructure, String image) {
        
    }
    
    private void deletePitch(int pitchId) {
        
    }
    
    private void updatePitch(int pitchId, String pitchName, String address, String pitchStructure, String image ){
        
    }
    
}
