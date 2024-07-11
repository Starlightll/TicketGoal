package DAO;

import DB.DBContext;
import Models.Club;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ClubDAO {
    public static ClubDAO INSTANCE = new ClubDAO();
    public String status = "OK";
    private Connection connect;

    private ClubDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }

    public static void main(String args[]) {
        Club club = INSTANCE.getClub(1);
        String clubName = club.getClubName();
        String clubImage = club.getClubLogo();
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

    public Club getClub(int clubId) {
        Club club = new Club();
        try {
            String query = "SELECT * FROM Club WHERE clubId = ?";
            PreparedStatement stmt = connect.prepareStatement(query);
            stmt.setInt(1, clubId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                club.setClubId(rs.getInt("clubId"));
                club.setClubName(rs.getString("clubName"));
                club.setClubLogo(rs.getString("logo"));
            }
        } catch (Exception e) {
            status = e.getMessage();
        }
        return club;
    }

}
