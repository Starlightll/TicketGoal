/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Contact;
import Models.ContactCategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class ContactDAO {

    public static final ContactDAO INSTANCE = new ContactDAO();
    private Connection connect;

    public ContactDAO() {
        try {
            connect = new DBContext().getConnection();
        } catch (Exception e) {
        }
    }

    public List<Contact> getContactList(String cate) {
        List<Contact> list = new ArrayList<>();
        String sql = """
                     SELECT c.[contactId]
                                                  ,c.[message]
                                                  ,c.[name]
                                                  ,c.[createDate]
                                                  ,c.[title]
                                                  ,c.[Email]
                                              FROM [TicketGoal].[dbo].[Contact] c""";
        if (cate != null && !cate.isEmpty()) {
            sql += " join Contact_Cate cc on c.contactId = cc.contactID where cc.categoryID = " + cate;
        }
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt(1));
                contact.setMessage(rs.getString(2));
                contact.setName(rs.getString(3));
                contact.setCreatedDate(rs.getDate(4));
                contact.setTitle(rs.getString(5));
                contact.setEmail(rs.getString(6));
                contact.setList(getListByContactID(contact.getId()));
                list.add(contact);
            }
        } catch (SQLException e) {
            return null;
        }
        return list;
    }

    public Contact getContactByID(int id) {
        List<Contact> list = new ArrayList<>();
        String sql = """
                     SELECT [contactId]
                           ,[message]
                           ,[name]
                           ,[createDate]
                           ,[title]
                           ,[Email]
                       FROM [TicketGoal].[dbo].[Contact] where [contactId] = ?""";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt(1));
                contact.setMessage(rs.getString(2));
                contact.setName(rs.getString(3));
                contact.setCreatedDate(rs.getDate(4));
                contact.setTitle(rs.getString(5));
                contact.setEmail(rs.getString(6));
                contact.setList(getListByContactID(contact.getId()));
                return contact;
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }

    public Contact getNewContact() {
        String sql = """
                     SELECT top 1 [contactId]
                           ,[message]
                           ,[name]
                           ,[createDate]
                           ,[title]
                           ,[Email]               
                       FROM [TicketGoal].[dbo].[Contact] order by [contactId] desc""";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt(1));
                contact.setMessage(rs.getString(2));
                contact.setName(rs.getString(3));
                contact.setCreatedDate(rs.getDate(4));
                contact.setTitle(rs.getString(5));
                contact.setEmail(rs.getString(6));
                contact.setList(getListByContactID(contact.getId()));
                return contact;
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }

    public void insert(String name, String email, String title, String message) {
        String sql = """
                     INSERT INTO [dbo].[Contact]
                                ([message]
                                ,[name]
                                ,[createDate]
                                ,[title]
                                ,[email])
                          VALUES
                                (?,?,GETDATE(),?,?)
                     """;
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, message);
            statement.setString(2, name);
            statement.setString(3, title);
            statement.setString(4, email);
            statement.executeUpdate();
            Contact contact = getNewContact();
            String xSQL = """
                          INSERT INTO [dbo].[Contact_Cate]
                                     ([contactID]
                                     ,[categoryID])
                               VALUES
                                     (?,2)""";
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(1, contact.getId());
            qtm.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public List<ContactCategory> getListByContactID(int id) {
        List<ContactCategory> list = new ArrayList<>();
        String sql = """
                     SELECT cc.[id]
                           ,cc.[name]
                       FROM [dbo].[Contact_Category] cc join Contact_Cate c on cc.id = c.categoryID 
                       where c.contactID = ?""";
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                list.add(new ContactCategory(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            return null;
        }
        return list;
    }

    public void updateContact(int contactID) {
        try {
            String xSQL = """
                          UPDATE [dbo].[Contact_Cate]
                             SET [categoryID] = ?
                           WHERE contactID = ? and categoryID = ?
                          """;
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(2, contactID);
            qtm.setInt(1, 1);
            qtm.setInt(3, 2);
            qtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delete(int id) {
        try {
            String xSQL = """
                          delete from Contact_Cate where contactID = ?
                          """;
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(1, id);
            qtm.executeUpdate();
            String sql = "delete from Contact where contactID = ?";
            PreparedStatement xtm = connect.prepareStatement(sql);
            xtm.setInt(1, id);
            xtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateReadContact(String status, String[] checked) {
        try {
            String xSQL = """
                          UPDATE [dbo].[Contact_Cate]
                             SET [categoryID] = ?
                           WHERE categoryID = ?
                          """;
            if (checked != null) {
                xSQL += " and contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    xSQL += checked[i];
                    if (i < checked.length - 1) {
                        xSQL += ", ";
                    }
                }
                xSQL += ")";
            }
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(2, 2);
            qtm.setInt(1, Integer.parseInt(status));
            qtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateUnReadContact(String status, String[] checked) {
        try {
            String xSQL = """
                          UPDATE [dbo].[Contact_Cate]
                             SET [categoryID] = ?
                           WHERE categoryID = ?
                          """;
            if (checked != null) {
                xSQL += " and contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    xSQL += checked[i];
                    if (i < checked.length - 1) {
                        xSQL += ", ";
                    }
                }
                xSQL += ")";
            }
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(2, 1);
            qtm.setInt(1, Integer.parseInt(status));
            qtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateImportantContact(String status, String[] checked) {
        try {
            String xSQL = """
                          delete from Contact_Cate where categoryID = ?
                          """;
            if (checked != null) {
                xSQL += " and contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    xSQL += checked[i];
                    if (i < checked.length - 1) {
                        xSQL += ", ";
                    }
                }
                xSQL += ")";
            }
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(1, Integer.parseInt(status));
            qtm.executeUpdate();
            String sql = """
                         INSERT INTO [dbo].[Contact_Cate]
                                    ([contactID]
                                    ,[categoryID])
                                    (select contactId,3 from Contact)""";
            sql = sql.substring(0,sql.length() - 1);
            if (checked != null) {
                sql += " where contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    sql += checked[i];
                    if (i < checked.length - 1) {
                        sql += ", ";
                    }
                }
                sql += ")";
                sql += ")";
            }
            PreparedStatement xtm = connect.prepareStatement(sql);
            xtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateStarredContact(String status, String[] checked) {
        try {
            String xSQL = """
                          delete from Contact_Cate where categoryID = ?
                          """;
            if (checked != null) {
                xSQL += " and contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    xSQL += checked[i];
                    if (i < checked.length - 1) {
                        xSQL += ", ";
                    }
                }
                xSQL += ")";
            }
            PreparedStatement qtm = connect.prepareStatement(xSQL);
            qtm.setInt(1, Integer.parseInt(status));
            qtm.executeUpdate();
            String sql = """
                         INSERT INTO [dbo].[Contact_Cate]
                                    ([contactID]
                                    ,[categoryID])
                                    (select contactId,4 from Contact)""";
            sql = sql.substring(0,sql.length() - 1);
            if (checked != null) {
                sql += " where contactID IN (";
                for (int i = 0; i < checked.length; i++) {
                    sql += checked[i];
                    if (i < checked.length - 1) {
                        sql += ", ";
                    }
                }
                sql += ")";
                sql += ")";
            }
            PreparedStatement xtm = connect.prepareStatement(sql);
            xtm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
