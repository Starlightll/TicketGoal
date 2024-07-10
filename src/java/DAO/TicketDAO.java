/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.*;

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

    public List<Ticket> getTicketByTicketStatus(int status) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n" +
                "FROM Ticket t\n" +
                "JOIN Seat s ON t.seatId = s.seatId\n" +
                "JOIN Area a ON s.areaId = a.areaId\n" +
                "JOIN Match m ON t.matchId = m.matchId\n" +
                "JOIN Club c1 ON m.club1 = c1.clubId\n" +
                "JOIN Club c2 ON m.club2 = c2.clubId\n" +
                "JOIN Cart cr ON t.cartId = cr.cartId\n" +
                "JOIN Pitch p ON m.pitchId = p.pitchId\n" +
                "WHERE t.ticketStatusId = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, status);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                tickets.add(new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by status: " + e);
        }
        return tickets;
    }


    public int addToCart(Ticket ticket) {
        String sql = "INSERT INTO Ticket(code, date, seatId, ticketStatusId, cartId, matchId) VALUES(?,?,?,?,?,?)";
        int rowInserted = 0;
        try {
            PreparedStatement statement = connect.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setString(1, ticket.getCode());
            statement.setDate(2, new java.sql.Date(ticket.getDate().getTime()));
            statement.setInt(3, ticket.getSeat().getSeatId());
            statement.setInt(4,2);
            statement.setInt(5, ticket.getCartId());
            statement.setInt(6, ticket.getMatch().getMatchId());
            rowInserted = statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                rowInserted = rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Insert ticket: " + e);
        }
        return rowInserted;
    }


    public List<Ticket> getTicketInCart(int accountId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n" +
                "FROM Ticket t\n" +
                "JOIN Seat s ON t.seatId = s.seatId\n" +
                "JOIN Area a ON s.areaId = a.areaId\n" +
                "JOIN Match m ON t.matchId = m.matchId\n" +
                "JOIN Club c1 ON m.club1 = c1.clubId\n" +
                "JOIN Club c2 ON m.club2 = c2.clubId\n" +
                "JOIN Cart cr ON t.cartId = cr.cartId\n" +
                "JOIN Pitch p ON m.pitchId = p.pitchId\n" +
                "WHERE cr.accountId = ? and t.ticketStatusId = 2";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, accountId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                tickets.add(new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public Ticket getTicketById(int ticketId) {
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n" +
                "FROM Ticket t\n" +
                "JOIN Seat s ON t.seatId = s.seatId\n" +
                "JOIN Area a ON s.areaId = a.areaId\n" +
                "JOIN Match m ON t.matchId = m.matchId\n" +
                "JOIN Club c1 ON m.club1 = c1.clubId\n" +
                "JOIN Club c2 ON m.club2 = c2.clubId\n" +
                "JOIN Cart cr ON t.cartId = cr.cartId\n" +
                "JOIN Pitch p ON m.pitchId = p.pitchId\n" +
                "WHERE t.ticketId = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, ticketId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                return new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match);
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return null;
    }

    public List<Ticket> getTicketInCartByMatchAndAccount(Account account, int matchId) {
        List<Ticket> ticketList = new ArrayList<>();
        for(Ticket ticket: getTicketInCart(account.getAccountId())) {
            if(ticket.getMatch().matchId == matchId) {
                ticketList.add(ticket);
            }
        }
        return ticketList;
    }


    public List<Ticket> getPaidTicket(){
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n" +
                "FROM Ticket t\n" +
                "JOIN Seat s ON t.seatId = s.seatId\n" +
                "JOIN Area a ON s.areaId = a.areaId\n" +
                "JOIN Match m ON t.matchId = m.matchId\n" +
                "JOIN Club c1 ON m.club1 = c1.clubId\n" +
                "JOIN Club c2 ON m.club2 = c2.clubId\n" +
                "JOIN Cart cr ON t.cartId = cr.cartId\n" +
                "JOIN Pitch p ON m.pitchId = p.pitchId\n" +
                "WHERE t.ticketStatusId = 1";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                tickets.add(new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public List<Ticket> getPaidTicketByMatch(int matchId){
        List<Ticket> tickets = new ArrayList<>();
        for(Ticket ticket: getPaidTicket()) {
            if(ticket.getMatch().getMatchId() == matchId) {
                tickets.add(ticket);
            }
        }
        return tickets;
    }

    public List<Ticket> searchTicketsByClubAndIds(String club) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n" +
                "FROM Ticket t\n" +
                "JOIN Seat s ON t.seatId = s.seatId\n" +
                "JOIN Area a ON s.areaId = a.areaId\n" +
                "JOIN Match m ON t.matchId = m.matchId\n" +
                "JOIN Club c1 ON m.club1 = c1.clubId\n" +
                "JOIN Club c2 ON m.club2 = c2.clubId\n" +
                "JOIN Cart cr ON t.cartId = cr.cartId\n" +
                "JOIN Pitch p ON m.pitchId = p.pitchId\n"
                + "WHERE (c1.clubName like ? or c2.clubName like ? or a.areaName like ?) AND t.ticketStatusId = 2";
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
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                tickets.add(new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public boolean deleteTick(int ticketId) {
        String sql = "Delete from Ticket where ticketId = ?";
        boolean rowDeleted = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, ticketId);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Delete fail: " + e);
        }
        return rowDeleted;
    }

    public boolean removeTicket(int ticketId) {
        String sql = "Update Ticket set ticketStatusId = 3 where ticketId = ?";
        boolean rowUpdated = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, ticketId);
            rowUpdated = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Delete fail: " + e);
        }
        return rowUpdated;
    }

    public boolean updateTicketStatus(int ticketId, int status) {
        String sql = "Update Ticket set ticketStatusId = ? where ticketId = ?";
        boolean rowUpdated = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, status);
            statement.setInt(2, ticketId);
            rowUpdated = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Update fail: " + e);
        }
        return rowUpdated;
    }

    public boolean setBackupQRCode(int ticketId, String code) {
        String sql = "Update Ticket set code = ? where ticketId = ?";
        boolean rowInserted = false;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, code);
            statement.setInt(2, ticketId);
            rowInserted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Insert code: " + e);
        }
        return rowInserted;
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
    
    public List<Ticket> getPaidTicketByUser(int userId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n"
                + "FROM Ticket t\n"
                + "JOIN Seat s ON t.seatId = s.seatId\n"
                + "JOIN Area a ON s.areaId = a.areaId\n"
                + "JOIN Match m ON t.matchId = m.matchId\n"
                + "JOIN Club c1 ON m.club1 = c1.clubId\n"
                + "JOIN Club c2 ON m.club2 = c2.clubId\n"
                + "JOIN Cart cr ON t.cartId = cr.cartId\n"
                + "JOIN Pitch p ON m.pitchId = p.pitchId\n"
                + "WHERE t.ticketStatusId = 1 and cr.accountId=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                tickets.add(new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match));
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public List<Ticket> getTicketListByUser(int userId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo, TS.statusName\n"
                + "FROM Ticket t\n"
                + "JOIN Seat s ON t.seatId = s.seatId\n"
                + "JOIN Area a ON s.areaId = a.areaId\n"
                + "JOIN Match m ON t.matchId = m.matchId\n"
                + "JOIN Club c1 ON m.club1 = c1.clubId\n"
                + "JOIN Club c2 ON m.club2 = c2.clubId\n"
                + "JOIN Cart cr ON t.cartId = cr.cartId\n"
                + "JOIN Pitch p ON m.pitchId = p.pitchId\n"
                + "JOIN ticketStatus as TS on TS.ticketStatusId = t.ticketStatusId\n"
                + "WHERE cr.accountId=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketId = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));
                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);
                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));
                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));
                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));
                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));
                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);
                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");
                int matchId = rs.getInt("matchId");
                String seatNumber = rs.getString("seatNumber");
                double price = rs.getDouble("price");
                String areaName = rs.getString("areaName");
                String club1Name = rs.getString("club1Name");
                String club2Name = rs.getString("club2Name");
                Ticket ticket = new Ticket(ticketId, code, date, seat, ticketStatusId, cartId, match);
                ticket.setStatus(rs.getString("statusName"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println("Select tickets by accountId: " + e);
        }
        return tickets;
    }

    public Ticket getTicketByIdQR(int ticketId) {
        String sql = "SELECT *, c1.clubName as club1Name, c2.clubName as club2Name, c1.clubId as club1Id, c2.clubId as club2Id, c1.logo as club1Logo, c2.logo as club2Logo\n"
                + "FROM Ticket t\n"
                + "JOIN Seat s ON t.seatId = s.seatId\n"
                + "JOIN Area a ON s.areaId = a.areaId\n"
                + "JOIN Match m ON t.matchId = m.matchId\n"
                + "JOIN Club c1 ON m.club1 = c1.clubId\n"
                + "JOIN Club c2 ON m.club2 = c2.clubId\n"
                + "JOIN Cart cr ON t.cartId = cr.cartId\n"
                + "JOIN Pitch p ON m.pitchId = p.pitchId\n"
                + "WHERE t.ticketId = ?";

        try (PreparedStatement st = connect.prepareStatement(sql)) {
            st.setInt(1, ticketId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int ticketIdResult = rs.getInt("ticketId");
                String code = rs.getString("code");
                Date date = rs.getDate("date");

                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seatId"));
                seat.setSeatNumber(rs.getInt("seatNumber"));
                seat.setPrice(rs.getInt("price"));
                seat.setSeatStatusId(rs.getInt("seatStatusId"));
                seat.setRow(rs.getInt("row"));

                Area area = new Area();
                area.setId(rs.getInt("areaId"));
                area.setAreaName(rs.getString("areaName"));
                seat.setArea(area);

                Match match = new Match();
                match.setMatchId(rs.getInt("matchId"));

                Club club1 = new Club();
                club1.setClubId(rs.getInt("club1Id"));
                club1.setClubName(rs.getString("club1Name"));
                club1.setClubLogo(rs.getString("club1Logo"));

                Club club2 = new Club();
                club2.setClubId(rs.getInt("club2Id"));
                club2.setClubName(rs.getString("club2Name"));
                club2.setClubLogo(rs.getString("club2Logo"));

                match.setClub1(club1);
                match.setClub2(club2);
                match.setSchedule(rs.getTimestamp("schedule"));
                match.setMatchStatusId(rs.getInt("matchStatusId"));

                Address address = new Address();
                address.setAddressName(rs.getString("addressName"));
                address.setAddressURL(rs.getString("addressURL"));
                match.setAddress(address);

                match.setPitchId(rs.getInt("pitchId"));
                int ticketStatusId = rs.getInt("ticketStatusId");
                int cartId = rs.getInt("cartId");

                return new Ticket(ticketIdResult, code, date, seat, ticketStatusId, cartId, match);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching ticket by ticketId: " + e.getMessage());
        }
        return null;
    }

    public void updateTicketStatusHistory(int ticketId, int newStatusId) {
        try {
            String sql = "UPDATE Ticket SET ticketStatusId = ? WHERE ticketId = ?";
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, newStatusId);
            ps.setInt(2, ticketId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating ticket status: " + e.getMessage());
        }
    }

    public void updateSeatStatusAvailable(int seatId) {
        try {
            String sql = "UPDATE Seat SET seatStatusId = 1 WHERE seatId = ?";
            PreparedStatement ps = connect.prepareStatement(sql);
            ps.setInt(1, seatId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating seat status: " + e.getMessage());
        }
    }

    public int getPendingOrderIds(int id) {
        String sql = "SELECT DISTINCT O.orderId "
                + "FROM [Order] AS O "
                + "JOIN [OrderLine] AS OL ON O.orderId = OL.orderId "
                + "JOIN Ticket AS T ON T.ticketId = OL.ticketId "
                + "JOIN [OrderStatus] AS OS ON OS.orderStatusId = O.orderStatusId "
                + "WHERE OL.ticketId=?";

        try {
            PreparedStatement stmt = connect.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("orderId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public int getTotalOrderIds(int id) {
        String sql = "SELECT DISTINCT O.totalAmount "
                + "FROM [Order] AS O "
                + "JOIN [OrderLine] AS OL ON O.orderId = OL.orderId "
                + "JOIN Ticket AS T ON T.ticketId = OL.ticketId "
                + "JOIN [OrderStatus] AS OS ON OS.orderStatusId = O.orderStatusId "
                + "WHERE OL.ticketId=?";

        try {
            PreparedStatement stmt = connect.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalAmount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

}
