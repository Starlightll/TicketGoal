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
    private Seat seat;
    private int ticketStatusId;
    private int cartId;
    private Match match;
    private String status;
    public Ticket() {
    }

    public Ticket(int ticketId, String code, Date date, Seat seat, int ticketStatusId, int cartId, Match match) {
        this.ticketId = ticketId;
        this.code = code;
        this.date = date;
        this.seat = seat;
        this.ticketStatusId = ticketStatusId;
        this.cartId = cartId;
        this.match = match;
    }

    public Ticket(String code, Date date, Seat seat, int ticketStatusId, int cartId, Match match) {
        this.code = code;
        this.date = date;
        this.seat = seat;
        this.ticketStatusId = ticketStatusId;
        this.cartId = cartId;
        this.match = match;
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

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
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

    public Match getMatch() {
        return match;
    }

    public void setMatch(Match match) {
        this.match = match;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
