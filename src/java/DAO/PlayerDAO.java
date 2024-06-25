/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import Models.Player;
import Models.PlayerRole;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

/**
 *
 * @author mosdd
 */
public class PlayerDAO {

    public static final PlayerDAO INSTANCE = new PlayerDAO();
    private Connection connect;

    public PlayerDAO() {
        try {
            connect = new DBContext().getConnection();
        } catch (Exception e) {
        }
    }

    public Player getPlayer(String PlayerId) {
        String sql = "Select * from Player  inner join Performance ON Player.playerId = Performance.playerId left join PlayerRole ON Player.playerRoleId = PlayerRole.playerRoleId Where Player.playerId = ?";
        Player p = new Player();
        try {
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(PlayerId));
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                p.setPlayerId(rs.getInt("playerId"));
                p.setPlayerName(rs.getNString("playerName"));
                p.setPlayerNumber(rs.getInt("playerNumber"));
                p.setDateOfBirth(rs.getDate("dateOfBirth"));
                p.setHeight(rs.getFloat("height"));
                p.setWeight(rs.getFloat("weight"));
                p.setBiography(rs.getNString("biography"));
                String playerImage = Base64.getEncoder().encodeToString(rs.getBytes("playerImage"));
                p.setImage(playerImage);
                p.setCountryId(rs.getInt("countryId"));
                p.setRoleName(rs.getNString("roleName"));
                p.setATK(rs.getInt("atk"));
                p.setDEF(rs.getInt("def"));
                p.setSPD(rs.getInt("spd"));
            }
        } catch (SQLException e) {
            return null;
        }
        return p;
    }

    public List<Player> getAllPlayer() {
        List<Player> list = new ArrayList<>();
        String query = "Select * from Player  inner join Performance ON Player.playerId = Performance.playerId left join PlayerRole ON Player.playerRoleId = PlayerRole.playerRoleId";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Player p = new Player();
                p.setPlayerId(rs.getInt("playerId"));
                p.setPlayerName(rs.getNString("playerName"));
                p.setPlayerNumber(rs.getInt("playerNumber"));
                p.setDateOfBirth(rs.getDate("dateOfBirth"));
                p.setHeight(rs.getFloat("height"));
                p.setWeight(rs.getFloat("weight"));
                p.setBiography(rs.getNString("biography"));
                String playerImage = Base64.getEncoder().encodeToString(rs.getBytes("playerImage"));
                p.setImage(playerImage);
                p.setCountryId(rs.getInt("countryId"));
                p.setRoleName(rs.getNString("roleName"));
                p.setATK(rs.getInt("atk"));
                p.setDEF(rs.getInt("def"));
                p.setSPD(rs.getInt("spd"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Fail");
        }
        return list;
    }

    public int deletePlayer(String playerId) {
        String sql1 = "delete from Performance where playerId =?";
        String sql2 = "delete from Player where playerId=?";
        int n = 0;
        try {
            PreparedStatement p1 = connect.prepareStatement(sql1);
            p1.setString(1, playerId);
            p1.executeUpdate();
            PreparedStatement p2 = connect.prepareStatement(sql2);
            p2.setString(1, playerId);
            n = p2.executeUpdate();

        } catch (SQLException e) {
        }
        return n;
    }

    public void addPlayer(String playerName, String playerNumber, String dateOfBirth, String height, String weight, String biography, InputStream image, String countryId, String playerRoleId, String atk, String def, String spd) {
        String query = "INSERT INTO Player (playerName, playerNumber, dateOfBirth, height, weight, biography, playerImage, countryId, playerRoleId)\n"
                + "VALUES (?, ? ,? ,? ,? ,? ,? ,? ,?)";

        try {
            // Check for duplicate player number
            String checkDuplicateQuery = "SELECT COUNT(*) FROM Player WHERE playerNumber = ?";
            PreparedStatement checkPs = connect.prepareStatement(checkDuplicateQuery);
            checkPs.setString(1, playerNumber);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new SQLException("Player number already exists.");
            }
            PreparedStatement ps = connect.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setNString(1, playerName);
            ps.setString(2, playerNumber);
            ps.setString(3, dateOfBirth);
            ps.setString(4, height);
            ps.setString(5, weight);
            ps.setString(6, biography);
            if (image != null) {
                ps.setBlob(7, image);
            } else {
                ps.setNull(7, java.sql.Types.BLOB);
            }
            ps.setString(8, countryId);
            ps.setString(9, playerRoleId);

            int resultInserted = ps.executeUpdate();
            if (resultInserted > 0) {
                ResultSet generatedKey = ps.getGeneratedKeys();
                if (generatedKey.next()) {
                    int playerId = generatedKey.getInt(1);
                    String sql = "INSERT INTO Performance VALUES (? ,? , ?, ?)";
                    ps = connect.prepareStatement(sql);
                    ps.setString(1, atk);
                    ps.setString(2, def);
                    ps.setString(3, spd);
                    ps.setInt(4, playerId);
                }
            }
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<Player> searchPlayerByName(String name) {
        List<Player> list = new ArrayList<>();

        String query = "SELECT * FROM Player AS P JOIN Performance AS PE ON P.playerId=PE.playerId left join PlayerRole ON P.playerRoleId = PlayerRole.playerRoleId WHERE playerName LIKE ?";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            name = "%" + name + "%";
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Player p = new Player();
                p.setPlayerId(rs.getInt("playerId"));
                p.setPlayerName(rs.getNString("playerName"));
                p.setPlayerNumber(rs.getInt("playerNumber"));
                p.setDateOfBirth(rs.getDate("dateOfBirth"));
                p.setHeight(rs.getFloat("height"));
                p.setWeight(rs.getFloat("weight"));
                p.setBiography(rs.getNString("biography"));
                String playerImage = Base64.getEncoder().encodeToString(rs.getBytes("playerImage"));
                p.setImage(playerImage);
                p.setCountryId(rs.getInt("countryId"));
                p.setRoleName(rs.getNString("roleName"));
                p.setATK(rs.getInt("atk"));
                p.setDEF(rs.getInt("def"));
                p.setSPD(rs.getInt("spd"));

                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("fail");
        }
        return list;
    }

    public void UpdatePlayer(String playerId, String playerName, String playerNumber, String dateOfBirth, String height, String weight, String biography, InputStream newImage, String oldImage, String countryId, String playerRoleId, String atk, String def, String spd) {
        // Kiểm tra xem playerNumber có bị trùng không
        if (isPlayerNumberUnique(playerNumber, playerId)) {
            String query = "UPDATE Player\n"
                    + "SET playerName = ?,\n"
                    + "    playerNumber = ?,\n"
                    + "    dateOfBirth = ?,\n"
                    + "    height = ?,\n"
                    + "    weight = ?,\n"
                    + "    biography = ?,\n"
                    + "    playerImage = ?,\n"
                    + "    countryId = ?,\n"
                    + "    playerRoleId = ?\n"
                    + "WHERE playerId = ?;";
            try {
                PreparedStatement ps = connect.prepareStatement(query);
                ps.setNString(1, playerName);
                ps.setString(2, playerNumber);
                ps.setString(3, dateOfBirth);
                ps.setString(4, height);
                ps.setString(5, weight);
                ps.setString(6, biography);
                if (newImage != null) {
                    ps.setBlob(7, newImage);
                } else {
                    byte[] decodedImage = Base64.getDecoder().decode(oldImage);
                    ps.setBytes(7, decodedImage);
                }
                ps.setString(8, countryId);
                ps.setString(9, playerRoleId);
                ps.setString(10, playerId);
                int resultInserted = ps.executeUpdate();
                String sql = "UPDATE Performance\n"
                        + "SET atk = ?,\n"
                        + "    def = ?,\n"
                        + "    spd = ?\n"
                        + "WHERE playerId = ?;";
                ps = connect.prepareStatement(sql);
                ps.setString(1, atk);
                ps.setString(2, def);
                ps.setString(3, spd);
                ps.setString(4, playerId);
                ps.executeUpdate();
            } catch (SQLException e) {
                // Xử lý ngoại lệ SQL
                e.printStackTrace();
            }
        } else {
            // Xử lý khi playerNumber bị trùng
            // Ví dụ: Hiển thị thông báo cho người dùng
            System.out.println("Player number is not unique.");
        }
    }
    // Phương thức kiểm tra playerNumber có trùng lặp không

    private boolean isPlayerNumberUnique(String playerNumber, String playerId) {
        String query = "SELECT COUNT(*) FROM Player WHERE playerNumber = ? AND playerId != ?";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setString(1, playerNumber);
            ps.setString(2, playerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count == 0; // Trả về true nếu không có playerNumber nào khác trùng
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ SQL
            e.printStackTrace();
        }
        return false;
    }

    public List<PlayerRole> getAllRole() {
        List<PlayerRole> list = new ArrayList<>();
        String query = "select * from PlayerRole";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PlayerRole(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Player> getAllPlayerByID(String playerId) {
        List<Player> list = new ArrayList<>();
        String query = "select * from Player inner join Performance ON Player.playerId = Performance.playerId where player.playerId = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setString(1, playerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Player p = new Player();
                p.setPlayerId(rs.getInt("playerId"));
                p.setPlayerName(rs.getNString("playerName"));
                p.setPlayerNumber(rs.getInt("playerNumber"));
                p.setDateOfBirth(rs.getDate("dateOfBirth"));
                p.setHeight(rs.getFloat("height"));
                p.setWeight(rs.getFloat("weight"));
                p.setBiography(rs.getNString("biography"));
                String playerImage = Base64.getEncoder().encodeToString(rs.getBytes("playerImage"));
                p.setImage(playerImage);
                p.setCountryId(rs.getInt("countryId"));
                p.setRoleName(rs.getNString("roleName"));
                p.setATK(rs.getInt("atk"));
                p.setDEF(rs.getInt("def"));
                p.setSPD(rs.getInt("spd"));
                list.add(p);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Player> getAllPlayerByRole(String playerRole) {
        List<Player> list = new ArrayList<>();
        String query = "select * from Player  "
                + "join Performance ON Player.playerId = Performance.playerId "
                + "join PlayerRole on PlayerRole.playerRoleId=Player.playerRoleId "
                + "where player.playerRoleId = ?";
        try {
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setString(1, playerRole);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Player p = new Player();
                p.setPlayerId(rs.getInt("playerId"));
                p.setPlayerName(rs.getNString("playerName"));
                p.setPlayerNumber(rs.getInt("playerNumber"));
                p.setDateOfBirth(rs.getDate("dateOfBirth"));
                p.setHeight(rs.getFloat("height"));
                p.setWeight(rs.getFloat("weight"));
                p.setBiography(rs.getNString("biography"));
                String playerImage = Base64.getEncoder().encodeToString(rs.getBytes("playerImage"));
                p.setImage(playerImage);
                p.setCountryId(rs.getInt("countryId"));
                p.setRoleName(rs.getNString("roleName"));
                p.setATK(rs.getInt("atk"));
                p.setDEF(rs.getInt("def"));
                p.setSPD(rs.getInt("spd"));
                list.add(p);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public static void main(String[] args) {
        PlayerDAO dao = new PlayerDAO();

        List<Player> p = dao.getAllPlayer();

    }
}
