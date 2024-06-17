package DAO;

import DB.DBContext;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ClubDAO {
    public static ClubDAO INSTANCE = new ClubDAO();
    private Connection connect;
    public String status = "OK";

    private ClubDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }

    public ResultSet getClubs() {
        try {
            String query = "SELECT * FROM Club";
            Statement stmt = connect.createStatement();
            return stmt.executeQuery(query);
        } catch (Exception e) {
            status = e.getMessage();
            return null;
        }
    }

    public ResultSet getClub(int clubId) {
        try {
            String query = "SELECT * FROM Club WHERE clubId = ?";
            Statement stmt = connect.createStatement();
            return stmt.executeQuery(query);
        } catch (Exception e) {
            status = e.getMessage();
            return null;
        }
    }

}
