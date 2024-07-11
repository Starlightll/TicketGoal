/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 * @author MSI VN
 */
public class PromotionMatch {
    private int promotionMatchId;
    private int promotionId;
    private int matchId;

    public PromotionMatch() {
    }

    public PromotionMatch(int promotionMatchId, int promotionId, int matchId) {
        this.promotionMatchId = promotionMatchId;
        this.promotionId = promotionId;
        this.matchId = matchId;
    }

    public int getPromotionMatchId() {
        return promotionMatchId;
    }

    public void setPromotionMatchId(int promotionMatchId) {
        this.promotionMatchId = promotionMatchId;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public int getMatchId() {
        return matchId;
    }

    public void setMatchId(int matchId) {
        this.matchId = matchId;
    }

    @Override
    public String toString() {
        return "PromotionMatch{" + "promotionMatchId=" + promotionMatchId + ", promotionId=" + promotionId + ", matchId=" + matchId + '}';
    }


}
