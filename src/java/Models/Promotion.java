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

    public Promotion() {
    }

    public Promotion(int promotionId, String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate) {
        this.promotionId = promotionId;
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
    }

    public Promotion(String promotionCode, String promotionDescription, LocalDateTime promotionStartDate, LocalDateTime promotionEndDate) {
        this.promotionCode = promotionCode;
        this.promotionDescription = promotionDescription;
        this.promotionStartDate = promotionStartDate;
        this.promotionEndDate = promotionEndDate;
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
        return "Promotion{" + "promotionId=" + promotionId + ", promotionCode=" + promotionCode + ", promotionDescription=" + promotionDescription + ", promotionStartDate=" + promotionStartDate + ", promotionEndDate=" + promotionEndDate + '}';
    }

}
