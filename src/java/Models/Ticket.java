/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.util.Date;


public class Ticket {
    private int ticketId;
    private String code;
    private Date date;
    private int seatId;
    private int ticketStatusId;
    private int cartId;
    private int matchId;
    
//  add new
    private String seatNumber;
    private String areaName;
    private double price;
    private String club1;
    private String club2;

    public Ticket() {
    }

    public Ticket(int ticketId, String code, Date date, int seatId, int ticketStatusId, int cartId, int matchId) {
        this.ticketId = ticketId;
        this.code = code;
        this.date = date;
        this.seatId = seatId;
        this.ticketStatusId = ticketStatusId;
        this.cartId = cartId;
        this.matchId = matchId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getTicketStatusId() {
        return ticketStatusId;
    }

    public void setTicketStatusId(int ticketStatusId) {
        this.ticketStatusId = ticketStatusId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getMatchId() {
        return matchId;
    }

    public void setMatchId(int matchId) {
        this.matchId = matchId;
    }

    public Ticket(int ticketId, String code, Date date, int seatId, int ticketStatusId, int cartId, int matchId, String seatNumber, String areaName, double price, String club1, String club2) {
        this.ticketId = ticketId;
        this.code = code;
        this.date = date;
        this.seatId = seatId;
        this.ticketStatusId = ticketStatusId;
        this.cartId = cartId;
        this.matchId = matchId;
        this.seatNumber = seatNumber;
        this.areaName = areaName;
        this.price = price;
        this.club1 = club1;
        this.club2 = club2;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getClub1() {
        return club1;
    }

    public void setClub1(String club1) {
        this.club1 = club1;
    }

    public String getClub2() {
        return club2;
    }

    public void setClub2(String club2) {
        this.club2 = club2;
    }
}
