/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Account;
import Models.Ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class TicketDAO {

    private Connection connect;
    private String status = "OK";

    public TicketDAO() {
        connect = new DBContext().getConnection();
    }

    public Ticket selectTicket(int cartId) {
        Ticket ticket = null;
        String sql = "SELECT * FROM ticket WHERE cartId = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, cartId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                int seatId = rs.getInt("seatId");
                int ticketStatusId = rs.getInt("ticketStatusId");
                int ticketId = rs.getInt("ticketId");
                int matchId = rs.getInt("matchId");
                ticket = new Ticket(ticketId, code, date, seatId, ticketStatusId, cartId, matchId);
            }
        } catch (SQLException e) {
            System.out.println("Select ticket: " + e);
        }
        return ticket;
    }
 public List<Ticket> getTicketByTicketStatus(int status) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM ticket WHERE ticketStatusId = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, status);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                int seatId = rs.getInt("seatId");
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");

                Ticket ticket = new Ticket(ticketId, code, date, seatId, ticketStatusId, cartId, matchId);
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by status: " + e);
        }
        return tickets;
    }

    public boolean buyTicket(Ticket ticket) {
        String sql = "INSERT INTO Ticket(code, date, seatId, ticketStatusId, cartId, matchId) VALUES(?,?,?,?,?,?)";
        boolean rowInserted = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, ticket.getCode());
            statement.setDate(2, new java.sql.Date(ticket.getDate().getTime()));
            statement.setInt(3, ticket.getSeatId());
            statement.setInt(4, 1);
            statement.setInt(5, ticket.getCartId());
            statement.setInt(6, ticket.getMatchId());
            rowInserted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Insert ticket: " + e);
        }
        return rowInserted;
    }

    public int addToCart(Ticket ticket) {
        String sql = "INSERT INTO Ticket(code, date, seatId, ticketStatusId, cartId, matchId) VALUES(?,?,?,?,?,?)";
        int rowInserted = 0;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, ticket.getCode());
            statement.setDate(2, new java.sql.Date(ticket.getDate().getTime()));
            statement.setInt(3, ticket.getSeatId());
            statement.setInt(4,2);
            statement.setInt(5, ticket.getCartId());
            statement.setInt(6, ticket.getMatchId());
            rowInserted = statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Insert ticket: " + e);
        }
        return rowInserted;
    }


    public List<Ticket> getTicketInCart(int accountId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = " SELECT t.ticketId, t.code, t.date, t.seatId, t.ticketStatusId, t.cartId, t.matchId, "
                + "s.seatNumber, s.price, a.areaName, "
                + "m.club1, m.club2, c1.clubName AS club1Name, c2.clubName AS club2Name "
                + "FROM Ticket t "
                + "JOIN Seat s ON t.seatId = s.seatId "
                + "JOIN Area a ON s.areaId = a.areaId "
                + "JOIN Match m ON t.matchId = m.matchId "
                + "JOIN Club c1 ON m.club1 = c1.clubId "
                + "JOIN Club c2 ON m.club2 = c2.clubId "
                + "JOIN Cart cr ON t.cartId = cr.cartId "
                + "WHERE cr.accountId = ? AND t.ticketStatusId = 2";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                int seatId = rs.getInt("seatId");
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");

                tickets.add(new Ticket(ticketId, code, date, seatId, ticketStatusId, cartId, matchId,
                        seatNumber, areaName, price, club1Name, club2Name));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public List<Ticket> getTicketInCartByMatchAndAccount(Account account, int matchId) {
        List<Ticket> ticketList = new ArrayList<>();
        for(Ticket ticket: getTicketInCart(account.getAccountId())) {
            if(ticket.getMatchId() == matchId) {
                ticketList.add(ticket);
            }
        }
        return ticketList;
    }


    public List<Ticket> getPaidTicket(){
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM Ticket WHERE ticketStatusId = 1";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                int seatId = rs.getInt("seatId");
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                tickets.add(new Ticket(ticketId, code, date, seatId, ticketStatusId, cartId, matchId));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public List<Ticket> getPaidTicketByMatch(int matchId){
        List<Ticket> tickets = new ArrayList<>();
        for(Ticket ticket: getPaidTicket()) {
            if(ticket.getMatchId() == matchId) {
                tickets.add(ticket);
            }
        }
        return tickets;
    }

    public List<Ticket> searchTicketsByClubAndIds(String club) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.ticketId, t.code, t.date, t.seatId, t.ticketStatusId, t.cartId, t.matchId, "
                + "s.seatNumber, s.price, a.areaName, "
                + "m.club1, m.club2, c1.clubName AS club1Name, c2.clubName AS club2Name "
                + "FROM Ticket t "
                + "JOIN Seat s ON t.seatId = s.seatId "
                + "JOIN Area a ON s.areaId = a.areaId "
                + "JOIN Match m ON t.matchId = m.matchId "
                + "JOIN Club c1 ON m.club1 = c1.clubId "
                + "JOIN Club c2 ON m.club2 = c2.clubId "
                + "JOIN Cart cr ON t.cartId = cr.cartId "
                + "WHERE c1.clubName like ? or c2.clubName like ? or a.areaName like ?";

        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setString(1, "%" + club + "%");
            st.setString(2, "%" + club + "%");
            st.setString(3, "%" + club + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                int seatId = rs.getInt("seatId");
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");

                tickets.add(new Ticket(ticketId, code, date, seatId, ticketStatusId, cartId, matchId,
                        seatNumber, areaName, price, club1Name, club2Name));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public boolean deleteTick(int cartId) {
        String sql = "Delete from Ticket where ticketId = ?";
        boolean rowDeleted = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, cartId);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Delete fail: " + e);
        }
        return rowDeleted;
    }

    public boolean deleteCart(int cartId) {
        String sql = "Delete from Cart where cartId = ?";
        boolean rowDeleted = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, cartId);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Delete fail: " + e);
        }
        return rowDeleted;
    }
    public static void main(String[] args) {
        System.out.println(new TicketDAO().getTicketByTicketStatus(2));
    }
}
