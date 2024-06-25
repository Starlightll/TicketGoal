package DAO;

import DB.DBContext;
import Models.Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static Utils.Common.addToCommandIfNotDefault;
import static Utils.Common.addToCommandIfNotNull;

public class AccountDAO {
    public static AccountDAO INSTANCE = new AccountDAO();
    private Connection connect;
    private final String getAccountByRoleQuery = "SELECT * FROM Account WHERE roleId = ?";
    private final String getAccountByIdQuery = "SELECT * FROM Account WHERE accountId = ?";
    private final String getAccountByEmail = "SELECT * FROM Account WHERE email = ?";

    private AccountDAO() {
        if (INSTANCE == null) {
            connect = new DBContext().getConnection();
        } else {
            INSTANCE = this;
        }
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

    public Account createNewAccount(Account acc) {
        String sqlCommand = "INSERT INTO account (";
        StringBuilder columnsBuilder = new StringBuilder();
        StringBuilder valuesBuilder = new StringBuilder(") VALUES (");
        ArrayList<Object> parameters = new ArrayList<>();

        // Danh sách các thuộc tính của Account
        String[] fields = {"username", "email", "password", "phoneNumber", "gender", "address", "roleId", "accountStatusId"};

        // Lặp qua từng thuộc tính và giá trị tương ứng
        for (int i = 0; i < fields.length; i++) {
            Object value = getFieldValue(acc, fields[i]);
            if (value != null && !value.equals(-1)) {
                columnsBuilder.append(fields[i]);
                valuesBuilder.append("?");
                parameters.add(value);
                if (i < fields.length - 1) {
                    columnsBuilder.append(", ");
                    valuesBuilder.append(", ");
                }
            }
        }
        if (columnsBuilder.toString().endsWith(", ")) {
            columnsBuilder.setLength(columnsBuilder.length() - 2);
        }
        if (valuesBuilder.toString().endsWith(", ")) {
            valuesBuilder.setLength(valuesBuilder.length() - 2);
        }

        sqlCommand += columnsBuilder.toString() + valuesBuilder.toString() + ")";
        System.out.println(sqlCommand);
        try (PreparedStatement ps = connect.prepareStatement(sqlCommand, Statement.RETURN_GENERATED_KEYS)) {
            // Thiết lập các tham số cho câu lệnh SQL
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            // Thực thi câu lệnh SQL
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Lấy dữ liệu sau khi thêm vào bằng khóa được tạo tự động
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int generatedId = generatedKeys.getInt(1);
                        acc.setAccountId(generatedId);
                        createCart(generatedId);
                        return acc;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createCart(int accountId) {
        String sqlCommand = "INSERT INTO cart (accountId) VALUES (?)";
        try (PreparedStatement ps = connect.prepareStatement(sqlCommand)) {
            ps.setInt(1, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getCartIdByAccountId(int accountId) {
        String sqlCommand = "SELECT cartId FROM cart WHERE accountId = ?";
        try (PreparedStatement ps = connect.prepareStatement(sqlCommand)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cartId");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    private Object getFieldValue(Account acc, String fieldName) {
        switch (fieldName) {
            case "username":
                return acc.getUsername();
            case "email":
                return acc.getEmail();
            case "password":
                return acc.getPassword();
            case "phoneNumber":
                return acc.getPhoneNumber();
            case "gender":
                return acc.getGender();
            case "address":
                return acc.getAddress();
            case "roleId":
                return acc.getRoleId();
            case "accountStatusId":
                return acc.getAccountStatusId();
            default:
                return null;
        }
    }

    public Account signIn(String email, String password) {
        Account account = getAccountByEmail(email);
        System.out.println(account);
        if (account != null && account.getPassword().equals(password)) {
            return account;
        }
        return null;
    }

    public Account updateUserById(Account account) {
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
    public Account updateUserByEmail(Account account) {
        StringBuilder sqlCommandBuilder = new StringBuilder("UPDATE Account SET\n");

        addToCommandIfNotNull(sqlCommandBuilder, "username", account.getUsername());
        addToCommandIfNotNull(sqlCommandBuilder, "password", account.getPassword());
        addToCommandIfNotNull(sqlCommandBuilder, "phoneNumber", account.getPhoneNumber());
        addToCommandIfNotNull(sqlCommandBuilder, "gender", account.getGender());
        addToCommandIfNotNull(sqlCommandBuilder, "address", account.getAddress());
        addToCommandIfNotDefault(sqlCommandBuilder, "roleId", account.getRoleId(), -1);
        addToCommandIfNotDefault(sqlCommandBuilder, "accountStatusId", account.getAccountStatusId(), -1);

        if (sqlCommandBuilder.toString().endsWith(", ")) {
            sqlCommandBuilder.setLength(sqlCommandBuilder.length() - 2);
        }

        sqlCommandBuilder.append("\n WHERE email = '").append(account.getEmail() + "'");
        String sqlCommand = sqlCommandBuilder.toString();
        System.out.println(sqlCommand);

        try (PreparedStatement ps = connect.prepareStatement(sqlCommand)) {
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                return getAccountByEmail(account.getEmail());
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public static void main(String[] args) {
        System.out.println(new AccountDAO().updateUserByEmail(new Account("trinhtiendat25102@gmail.com", "123",-1,-1)));
    }
}