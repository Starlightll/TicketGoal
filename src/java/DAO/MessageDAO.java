/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class MessageDAO {
    public static final ContactDAO INSTANCE = new ContactDAO();
    private Connection connect;

    public MessageDAO() {
        try {
            connect = new DBContext().getConnection();
        } catch (Exception e) {
        }
    }
    
    public List<Message> getMessages() {
        List<Message> list = new ArrayList<>();
        String sql = """
                     SELECT [id]
                           ,[email]
                           ,[subject]
                           ,[message]
                           ,[createDate]
                       FROM [TicketGoal].[dbo].[Message]
                     """;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt(1));
                message.setEmail(rs.getString(2));
                message.setSubject(rs.getString(3));
                message.setMessage(rs.getString(4));
                message.setCreatedDate(rs.getDate(5));
                list.add(message);
            }
        } catch (SQLException e) {
            return null;
        }
        return list;
    }
    
    public Message getMessagesByID(int id) {
        String sql = """
                     SELECT [id]
                           ,[email]
                           ,[subject]
                           ,[message]
                           ,[createDate]
                       FROM [TicketGoal].[dbo].[Message] where id = ?
                     """;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt(1));
                message.setEmail(rs.getString(2));
                message.setSubject(rs.getString(3));
                message.setMessage(rs.getString(4));
                message.setCreatedDate(rs.getDate(5));
                return message;
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }
    
    public void insert(String email,String subject,String message) {
        String sql = """
                     INSERT INTO [dbo].[Message]
                                ([email]
                                ,[subject]
                                ,[message]
                                ,[createDate])
                          VALUES
                                (?,?,?,getdate())
                     """;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, subject);
            statement.setString(3, message);
            statement.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void delete(int id) {
        String sql = """
                     DELETE FROM [dbo].[Message]
                                      WHERE id = ?
                     """;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
