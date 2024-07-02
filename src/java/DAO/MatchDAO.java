/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Area;
import Models.Match;
import Models.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mosdd
 */
public class MatchDAO {
    public static MatchDAO INSTANCE = new MatchDAO();
    private Connection connect;
    public String status = "OK";

    private MatchDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }

    public ResultSet getMatches() {
        try {
            String query = "SELECT * FROM Match INNER JOIN dbo.Pitch P on P.pitchId = Match.pitchId WHERE matchStatusId != 0";
            Statement stmt = connect.createStatement();
            return stmt.executeQuery(query);
        } catch (Exception e) {
            status = e.getMessage();
            return null;
        }
    }

    public Match getMatch(int matchId) {
        try {
            String query = "SELECT * FROM Match WHERE matchId = ?";
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setInt(1, matchId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setPitchId(rs.getInt("pitchId"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                match.setClub1(ClubDAO.INSTANCE.getClub(rs.getInt("club1")));
                match.setClub2(ClubDAO.INSTANCE.getClub(rs.getInt("club2")));
                return match;
            }
        } catch (Exception e) {
            status = e.getMessage();
            return null;
        }
        return null;
    }

    
    public boolean addMatch(Match match) {
        try {
            String query = "INSERT INTO Match(schedule, pitchId, matchStatusId, club1, club2) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement ps = connect.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, new java.sql.Timestamp(match.getSchedule().getTime()));
            ps.setInt(2, match.getPitchId());
            ps.setInt(3, match.getMatchStatusId());
            ps.setInt(4, match.getClub1().getClubId());
            ps.setInt(5, match.getClub2().getClubId());
            int rowsInserted = ps.executeUpdate();
            int matchId = -1;
            if(rowsInserted > 0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    matchId = rs.getInt(1);
                }
            }
            ps.close();
            String query2 = "INSERT INTO Seat (seatNumber, row, price, areaId, seatStatusId, matchId)\n" +
                    "SELECT seatNumber, row, price, areaId, seatStatusId, ?\n" +
                    "FROM Seat\n" +
                    "WHERE matchId IS NULL;";
            ps = connect.prepareStatement(query2);
            ps.setInt(1, matchId);
            ps.executeUpdate();
            ps.close();
            return true;
        } catch (Exception e) {
            status = e.getMessage();
            return false;
        }
    }

    public boolean updateMatch(Match match) {
        try {
            String query = "UPDATE Match SET schedule = ?, pitchId = ?, matchStatusId = ?, club1 = ?, club2 = ? WHERE matchId = ?";
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setTimestamp(1, new java.sql.Timestamp(match.getSchedule().getTime()));
            ps.setInt(2, match.getPitchId());
            ps.setInt(3, match.getMatchStatusId());
            ps.setInt(4, match.getClub1().getClubId());
            ps.setInt(5, match.getClub2().getClubId());
            ps.setInt(6, match.getMatchId());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            status = e.getMessage();
            return false;
        }
    }

    public boolean deleteMatch(int matchId) {
        try {
            String query = "UPDATE Match SET matchStatusId = 0 WHERE matchId = ?";
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setInt(1, matchId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            status = e.getMessage();
            return false;
        }
    }

    public List<Seat> getSeatOfMatch(int matchId) {
        List<Seat> seats = new ArrayList<>();
        try {
            String query = "SELECT * FROM Seat LEFT JOIN Area A on A.areaId = Seat.areaId WHERE matchId = ?";
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setInt(1, matchId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                seat.setRow(rs.getInt("row"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seats.add(seat);
            }
        } catch (Exception e) {
            status = e.getMessage();
            System.out.println("GetSeatOfMatch: " + status);
            return null;
        }
        return seats;
    }
    
}
