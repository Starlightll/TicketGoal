/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Promotion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSI VN
 */
public class PromotionDAO {

    private static PromotionDAO INSTANCE;
    private final Connection connect;
    private final String getPromotionByIdQuery = "SELECT * FROM Promotion WHERE promotionId = ?";
    private final String getAllPromotionsQuery = "SELECT * FROM Promotion";
    private final String insertPromotionQuery = "INSERT INTO Promotion (promotionCode, promotionDescription, promotionStartDate, promotionEndDate , promotionMatchId) VALUES (?, ?, ?, ?, ?)";
    private final String updatePromotionQuery = "UPDATE Promotion SET promotionCode = ?, promotionDescription = ?, promotionStartDate = ?, promotionEndDate = ? , promotionMatchId = ? WHERE promotionId = ?";
    private final String deletePromotionQuery = "DELETE FROM Promotion WHERE promotionId = ?";

    public PromotionDAO() {
        connect = new DBContext().getConnection();
    }

    public static PromotionDAO getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new PromotionDAO();
        }
        return INSTANCE;
    }

    public Promotion getPromotionById(int promotionId) {
        Promotion promotion = null;
        try (PreparedStatement ps = connect.prepareStatement(getPromotionByIdQuery)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    promotion = new Promotion();
                    promotion.setPromotionId(rs.getInt("promotionId"));
                    promotion.setPromotionCode(rs.getString("promotionCode"));
                    promotion.setPromotionDescription(rs.getString("promotionDescription"));
                    promotion.setPromotionStartDate(rs.getTimestamp("promotionStartDate").toLocalDateTime());
                    promotion.setPromotionEndDate(rs.getTimestamp("promotionEndDate").toLocalDateTime());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotion;
    }

    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        try (PreparedStatement ps = connect.prepareStatement(getAllPromotionsQuery); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionId(rs.getInt("promotionId"));
                promotion.setPromotionCode(rs.getString("promotionCode"));
                promotion.setPromotionDescription(rs.getString("promotionDescription"));
                promotion.setPromotionStartDate(rs.getTimestamp("promotionStartDate").toLocalDateTime());
                promotion.setPromotionEndDate(rs.getTimestamp("promotionEndDate").toLocalDateTime());
                promotions.add(promotion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }

    public boolean isPromotionCodeExists(String promotionCode) {
        String query = "SELECT 1 FROM Promotion WHERE promotionCode = ?";
        try (PreparedStatement ps = connect.prepareStatement(query)) {
            ps.setString(1, promotionCode);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Promotion insertPromotion(Promotion promotion) throws Exception {
        ResultSet generatedKeys = null;
        try (PreparedStatement ps = connect.prepareStatement(insertPromotionQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            if (isPromotionCodeExists(promotion.getPromotionCode())) {
                throw new Exception("Promotion code already exists.");
            }
            ps.setString(1, promotion.getPromotionCode());
            ps.setString(2, promotion.getPromotionDescription());
            ps.setTimestamp(3, Timestamp.valueOf(promotion.getPromotionStartDate()));
            ps.setTimestamp(4, Timestamp.valueOf(promotion.getPromotionEndDate()));
            ps.setInt(5, promotion.getPromotionMatchId());
            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new Exception("Creating promotion failed, no rows affected.");
            }

            generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int promotionId = generatedKeys.getInt(1);
                promotion.setPromotionId(promotionId);
                return promotion;
            } else {
                throw new Exception("Creating promotion failed, no ID obtained.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (generatedKeys != null) {
                try {
                    generatedKeys.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public boolean updatePromotion(Promotion promotion) {
        System.out.println(promotion);
        boolean rowUpdated = false;
        try (PreparedStatement ps = connect.prepareStatement(updatePromotionQuery)) {
            ps.setString(1, promotion.getPromotionCode());
            ps.setString(2, promotion.getPromotionDescription());
            ps.setTimestamp(3, Timestamp.valueOf(promotion.getPromotionStartDate()));
            ps.setTimestamp(4, Timestamp.valueOf(promotion.getPromotionEndDate()));
            ps.setInt(5, promotion.getPromotionMatchId());
            ps.setInt(6, promotion.getPromotionId());
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deletePromotion(int promotionId) {
        boolean rowDeleted = false;
        try (PreparedStatement ps = connect.prepareStatement(deletePromotionQuery)) {
            ps.setInt(1, promotionId);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    public List<Promotion> getPromotionsBySearchAndSort(String searchQuery, String sortBy, int page, int pageSize) {
        List<Promotion> promotions = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Promotion");
        boolean hasSearch = false;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            queryBuilder.append(" WHERE promotionCode LIKE ? OR promotionDescription LIKE ?");
            hasSearch = true;
        }

        if (sortBy != null && !sortBy.isEmpty()) {
            queryBuilder.append(" ORDER BY ");
            queryBuilder.append(sortBy);
        } else {
            queryBuilder.append(" ORDER BY promotionId");
        }

        int offset = (page - 1) * pageSize;
        queryBuilder.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connect.prepareStatement(queryBuilder.toString())) {
            int parameterIndex = 1;
            if (hasSearch) {
                String likeSearchQuery = "%" + searchQuery + "%";
                ps.setString(parameterIndex++, likeSearchQuery);
                ps.setString(parameterIndex++, likeSearchQuery);
            }

            ps.setInt(parameterIndex++, offset);
            ps.setInt(parameterIndex, pageSize);

            System.out.println(queryBuilder.toString());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promotion promotion = new Promotion();
                    promotion.setPromotionId(rs.getInt("promotionId"));
                    promotion.setPromotionCode(rs.getString("promotionCode"));
                    promotion.setPromotionDescription(rs.getString("promotionDescription"));
                    promotion.setPromotionStartDate(rs.getTimestamp("promotionStartDate").toLocalDateTime());
                    promotion.setPromotionEndDate(rs.getTimestamp("promotionEndDate").toLocalDateTime());
                    promotion.setPromotionMatchId(rs.getInt("promotionMatchId"));
                    promotions.add(promotion);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return promotions;
    }

    public static void main(String[] args) {
        System.out.println(new PromotionDAO().getPromotionsBySearchAndSort(null, null, 1, 10));
    }
}
