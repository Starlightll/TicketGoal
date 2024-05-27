/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ADMIN
 */
public class SeatStatus {
    private int seatStatusId;
    private String statusName;

    public SeatStatus() {
    }

    public SeatStatus(int seatStatusId, String statusName) {
        this.seatStatusId = seatStatusId;
        this.statusName = statusName;
    }

    public int getSeatStatusId() {
        return seatStatusId;
    }

    public void setSeatStatusId(int seatStatusId) {
        this.seatStatusId = seatStatusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
    
    
    
}
