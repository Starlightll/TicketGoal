package DAO;

import DB.DBContext;
import Models.Account;
import Models.Order;
import Models.Ticket;
import vnpay.common.Config;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public static OrderDAO INSTANCE = new OrderDAO();
    private Connection connect;

    private OrderDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
    }

    public Order createOrder(Account account, List<Ticket> tickets, int statusId) {
        String sql = "INSERT INTO [Order] (totalAmount, accountId, orderStatusId, orderDate) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement statement = connect.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            double totalAmount = 0;
            for (Ticket ticket : tickets) {
                totalAmount += ticket.getSeat().getPrice();
            }
            statement.setDouble(1, totalAmount);
            statement.setInt(2, account.getAccountId());
            statement.setInt(3, statusId);
            statement.setDate(4, new java.sql.Date(System.currentTimeMillis()));
            int rowInserted = statement.executeUpdate();
            int orderId = 0;
            if (rowInserted > 0) {
                ResultSet rs = statement.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            statement.close();
            // Insert ticket to OrderLine
            for (Ticket ticket : tickets) {
                createOrderLine(orderId, ticket.getTicketId());
            }
            return getOrderById(orderId);
        } catch (SQLException e) {
            return null;
        }
    }

    public boolean createOrderLine(int orderId, int ticketId) {
        String sql = "INSERT INTO OrderLine (orderId, ticketId) VALUES (?, ?)";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, orderId);
            statement.setInt(2, ticketId);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public Order getOrderById(int orderId) {
        Order order = new Order();
        String sql = "SELECT * FROM [Order] o WHERE o.orderId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, orderId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                order.setOrderId(rs.getInt("orderId"));
                order.setCustomerId(rs.getInt("accountId"));
                order.setTotalAmount(rs.getInt("totalAmount"));
                order.setOrderDate(rs.getDate("orderDate"));
                List<Ticket> tickets = new ArrayList<>();
                List<Integer> ticketId = getOrderLines(orderId);
                for (int id : ticketId) {
                    Ticket ticket = new TicketDAO().getTicketById(id);
                    tickets.add(ticket);
                }
                order.setTickets(tickets);
                order.setStatusId(rs.getInt("orderStatusId"));
            }
            statement.close();
            return order;
        } catch (SQLException e) {
            return null;
        }
    }

    public List<Integer> getOrderLines(int orderId) {
        List<Integer> tickets = new ArrayList<>();
        String sql = "SELECT * FROM OrderLine ol WHERE ol.orderId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, orderId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                tickets.add(rs.getInt("ticketId"));
            }
        } catch (SQLException e) {
            return null;
        }
        return tickets;
    }

    public boolean updateOrderStatus(int orderId, int statusId) {
        String sql = "UPDATE [Order] SET orderStatusId = ? WHERE orderId = ?";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, statusId);
            statement.setInt(2, orderId);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public static String genCode(int orderId, Ticket ticket, String secretKey) {
        String code = "";
        try {
            int ticketId = ticket.getTicketId();
            String randomNumber = Config.getRandomNumber(3);
            String data = orderId + "_" + ticketId + "_" + randomNumber + "_" + secretKey;
            code = Config.md5(data);
        } catch (Exception e) {
            return "";
        }
        return code;
    }


}
