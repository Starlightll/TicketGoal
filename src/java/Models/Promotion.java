/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;

/**
 * @author MSI VN
 */
public class Promotion {

    private int promotionId;
    private String promotionCode;
    private String promotionDescription;
    private LocalDateTime promotionStartDate;
    private LocalDateTime promotionEndDate;
    private int promotionMatchId;
    private int matchStatusId;
    private int promotionDiscount;

    public Promotion(String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate, int promotionMatchId, int promotionDiscount) {
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
        this.promotionMatchId = promotionMatchId;
        this.promotionDiscount = promotionDiscount;
    }

    public Promotion(int promotionId, String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate, int promotionMatchId, int promotionDiscount) {
        this.promotionId = promotionId;
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
        this.promotionMatchId = promotionMatchId;
        this.promotionDiscount = promotionDiscount;
    }

    public Promotion() {
    }

    public int getPromotionDiscount() {
        return promotionDiscount;
    }

    public void setPromotionDiscount(int promotionDiscount) {
        this.promotionDiscount = promotionDiscount;
    }

    public int getPromotionMatchId() {
        return promotionMatchId;
    }

    public void setPromotionMatchId(int promotionMatchId) {
        this.promotionMatchId = promotionMatchId;
    }

    public int getMatchStatusId() {
        return matchStatusId;
    }

    public void setMatchStatusId(int matchStatusId) {
        this.matchStatusId = matchStatusId;
    }

    public Promotion(int promotionId, String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate, int promationMatchId) {
        this.promotionId = promotionId;
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
        this.promotionMatchId = promationMatchId;
    }

    public Promotion(String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate, int promationMatchId) {
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
        this.promotionMatchId = promationMatchId;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getPromotionCode() {
        return promotionCode;
    }

    public void setPromotionCode(String promotionCode) {
        this.promotionCode = promotionCode;
    }

    public String getPromotionDescription() {
        return promotionDescription;
    }

    public void setPromotionDescription(String promotionDescription) {
        this.promotionDescription = promotionDescription;
    }

    public LocalDateTime getPromotionStartDate() {
        return promotionStartDate;
    }

    public void setPromotionStartDate(LocalDateTime promotionStartDate) {
        this.promotionStartDate = promotionStartDate;
    }

    public LocalDateTime getPromotionEndDate() {
        return promotionEndDate;
    }

    public void setPromotionEndDate(LocalDateTime promotionEndDate) {
        this.promotionEndDate = promotionEndDate;
    }

    @Override
    public String toString() {
        return "Promotion{" + "promotionId=" + promotionId + ", promotionCode=" + promotionCode + ", promotionDescription=" + promotionDescription + ", promotionStartDate=" + promotionStartDate + ", promotionEndDate=" + promotionEndDate + ", promotionMatchId=" + promotionMatchId + ", matchStatusId=" + matchStatusId + '}';
    }

}
