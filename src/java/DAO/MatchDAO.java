/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Match;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

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
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setTimestamp(1, new java.sql.Timestamp(match.getSchedule().getTime()));
            ps.setInt(2, match.getPitchId());
            ps.setInt(3, match.getMatchStatusId());
            ps.setInt(4, match.getClub1().getClubId());
            ps.setInt(5, match.getClub2().getClubId());
            ps.executeUpdate();
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
    
}
