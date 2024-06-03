/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSI VN
 */
public class RoleDAO {

    private static RoleDAO INSTANCE;
    private final Connection connect;
    private final String getAllRoleQuery = "SELECT * FROM Role";

    public RoleDAO() {
        connect = new DBContext().getConnection();
    }

    private RoleDAO getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new RoleDAO();
        }
        return INSTANCE;
    }

    public List<Role> getAllRole() {
        List<Role> roleList = new ArrayList<>();
        try (PreparedStatement ps = connect.prepareStatement(getAllRoleQuery); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt("roleId"));
                role.setRoleName(rs.getString("roleName"));
                roleList.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roleList;
    }

}
