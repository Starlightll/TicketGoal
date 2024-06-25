/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.PromotionMatch;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSI VN
 */
public class PromotionMatchDAO {

    private static PromotionMatchDAO INSTANCE;
    private final Connection connect;
    private final String insertPromotionMatchQuery = "INSERT INTO PromotionMatch (promotionId, matchId) VALUES (?, ?)";
    private final String deletePromotionMatchQuery = "DELETE FROM PromotionMatch WHERE promotionMatchId = ?";
    private final String getMatchesByPromotionIdQuery = "SELECT * FROM PromotionMatch WHERE promotionId = ?";

    public PromotionMatchDAO() {
        connect = new DBContext().getConnection();
    }

    public static PromotionMatchDAO getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new PromotionMatchDAO();
        }
        return INSTANCE;
    }

    public void addPromotionMatch(int promotionId, int matchId) {
        try (PreparedStatement ps = connect.prepareStatement(insertPromotionMatchQuery)) {
            ps.setInt(1, promotionId);
            ps.setInt(2, matchId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removePromotionMatch(int promotionMatchId) {
        try (PreparedStatement ps = connect.prepareStatement(deletePromotionMatchQuery)) {
            ps.setInt(1, promotionMatchId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PromotionMatch> getMatchesByPromotionId(int promotionId) {
        List<PromotionMatch> matches = new ArrayList<>();
        try (PreparedStatement ps = connect.prepareStatement(getMatchesByPromotionIdQuery)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PromotionMatch promotionMatch = new PromotionMatch();
                    promotionMatch.setPromotionMatchId(rs.getInt("promotionMatchId"));
                    promotionMatch.setPromotionId(rs.getInt("promotionId"));
                    promotionMatch.setMatchId(rs.getInt("matchId"));
                    matches.add(promotionMatch);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matches;
    }

    public static void main(String[] args) {
        System.out.println(new PromotionMatchDAO().getMatchesByPromotionId(1));
    }
}
