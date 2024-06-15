        /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Contact;
import Models.Player;
import Models.PlayerRole;
import java.io.InputStream;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.sql.*;
import java.util.Base64;

/**
 *
 * @author mosdd
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
        public List<Contact> getAllContact() {
        List<Contact> list = new ArrayList<>();
        String query = "select contactId, message, mail,date\n" +
                         "from Contact";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("contactId"));
                c.setMessage(rs.getNString("message"));
                c.setMail(rs.getNString("mail"));
                c.setDate(rs.getDate("date"));
            }
        } catch (SQLException e) {
            System.out.println("Fail");
        }
        return list;
    }
        
}
