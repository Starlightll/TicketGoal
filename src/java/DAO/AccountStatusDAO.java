package DAO;

import DB.DBContext;
import Models.AccountStatus;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountStatusDAO {

    private static AccountStatusDAO INSTANCE;
    private final Connection connect;
    private final String getAllAccountStatusQuery = "SELECT * FROM accountStatus";
    private final String getAllRoleQuery = "SELECT * FROM Role";

    public AccountStatusDAO() {
        connect = new DBContext().getConnection();
    }

    public static void main(String[] args) {
        System.out.println(new AccountStatusDAO().getAllAccountStatus());
    }

    private AccountStatusDAO getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new AccountStatusDAO();
        }
        return INSTANCE;
    }

    public List<AccountStatus> getAllAccountStatus() {
        List<AccountStatus> accountStatusList = new ArrayList<>();
        try (PreparedStatement ps = connect.prepareStatement(getAllAccountStatusQuery); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AccountStatus accountStatus = new AccountStatus();
                accountStatus.setAccountStatusId(rs.getInt("accountStatusId"));
                accountStatus.setStatusName(rs.getString("statusName"));
                accountStatusList.add(accountStatus);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountStatusList;
    }
}
