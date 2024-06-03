package DAO;

import DB.DBContext;
import Models.Account;
import static Utils.Common.addToCommandIfNotDefault;
import static Utils.Common.addToCommandIfNotNull;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {

    private static AccountDAO INSTANCE;
    private final Connection connect;
    private final String getAccountByRoleQuery = "SELECT * FROM Account WHERE roleId = ?";
    private final String getAccountByIdQuery = "SELECT * FROM Account WHERE accountId = ?";
    private final String createNewAccountQuery = "INSERT INTO Account (username, password, email, phoneNumber, gender, address, roleId, accountStatusId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private final String getAccountByEmail = "SELECT * FROM Account WHERE email = ?";

    public AccountDAO() {
        connect = new DBContext().getConnection();
    }

    private AccountDAO getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new AccountDAO();
        }
        return INSTANCE;
    }

    public List<Account> getAccountByRole(int roleId) {
        List<Account> accounts = new ArrayList<>();
        try (PreparedStatement ps = connect.prepareStatement(getAccountByRoleQuery)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Account account = new Account();
                    account.setAccountId(rs.getInt("accountId"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setEmail(rs.getString("email"));
                    account.setPhoneNumber(rs.getString("phoneNumber"));
                    account.setGender((Integer) rs.getObject("gender"));
                    account.setAddress(rs.getString("address"));
                    account.setRoleId(rs.getInt("roleId"));
                    account.setAccountStatusId(rs.getInt("accountStatusId"));
                    accounts.add(account);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accounts;
    }

    public Account getAccountById(int id) {
        Account account = null;
        try (PreparedStatement ps = connect.prepareStatement(getAccountByIdQuery)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    account = new Account();
                    account.setAccountId(rs.getInt("accountId"));
                    account.setUsername(rs.getString("username"));
//                    account.setPassword(rs.getString("password"));
                    account.setEmail(rs.getString("email"));
                    account.setPhoneNumber(rs.getString("phoneNumber"));
                    account.setGender((Integer) rs.getObject("gender"));
                    account.setAddress(rs.getString("address"));
                    account.setRoleId(rs.getInt("roleId"));
                    account.setAccountStatusId(rs.getInt("accountStatusId"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }

    public Account getAccountByEmail(String email) {
        Account account = null;
        try (PreparedStatement ps = connect.prepareStatement(getAccountByEmail)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    account = new Account();
                    account.setAccountId(rs.getInt("accountId"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(rs.getString("password"));
                    account.setEmail(rs.getString("email"));
                    account.setPhoneNumber(rs.getString("phoneNumber"));
                    account.setGender((Integer) rs.getObject("gender"));
                    account.setAddress(rs.getString("address"));
                    account.setRoleId(rs.getInt("roleId"));
                    account.setAccountStatusId(rs.getInt("accountStatusId"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }

    public Account createNewAccount(Account account) {
        String createNewAccountQuery = "INSERT INTO account (username, password, email, phoneNumber, gender, address, roleId, accountStatusId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connect.prepareStatement(createNewAccountQuery, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, account.getUsername());
            ps.setString(2, account.getPassword());
            ps.setString(3, account.getEmail());
            ps.setString(4, account.getPhoneNumber());
            ps.setInt(5, account.getGender());
            ps.setString(6, account.getAddress());
            ps.setInt(7, account.getRoleId());
            ps.setInt(8, account.getAccountStatusId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int generatedId = generatedKeys.getInt(1);
                        account.setAccountId(generatedId);
                        return account;
                    } else {
                        throw new SQLException("Creating account failed, no ID obtained.");
                    }
                }
            } else {
                throw new SQLException("Creating account failed, no rows affected.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Account updateUserById(Account account) {
        System.out.println("1" + account);
        StringBuilder sqlCommandBuilder = new StringBuilder("UPDATE Account SET\n");

        addToCommandIfNotNull(sqlCommandBuilder, "username", account.getUsername());
        addToCommandIfNotNull(sqlCommandBuilder, "email", account.getEmail());
        addToCommandIfNotNull(sqlCommandBuilder, "password", account.getPassword());
        addToCommandIfNotNull(sqlCommandBuilder, "phoneNumber", account.getPhoneNumber());
        addToCommandIfNotNull(sqlCommandBuilder, "gender", account.getGender());
        addToCommandIfNotNull(sqlCommandBuilder, "address", account.getAddress());
        addToCommandIfNotDefault(sqlCommandBuilder, "roleId", account.getRoleId(), -1);
        addToCommandIfNotDefault(sqlCommandBuilder, "accountStatusId", account.getAccountStatusId(), -1);

        if (sqlCommandBuilder.toString().endsWith(", ")) {
            sqlCommandBuilder.setLength(sqlCommandBuilder.length() - 2);
        }

        sqlCommandBuilder.append("\n WHERE accountId = ").append(account.getAccountId());
        String sqlCommand = sqlCommandBuilder.toString();
        System.out.println(sqlCommand);

        try (PreparedStatement ps = connect.prepareStatement(sqlCommand)) {
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return getAccountById(account.getAccountId());
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        System.out.println(new AccountDAO().getAccountByRole(2));
    }
}
