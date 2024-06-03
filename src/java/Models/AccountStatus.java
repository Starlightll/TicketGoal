package Models;

public class AccountStatus {

    private int accountStatusId;
    private String statusName;

    public AccountStatus() {
    }

    public AccountStatus(int accountStatusId, String statusName) {
        this.accountStatusId = accountStatusId;
        this.statusName = statusName;
    }

    public AccountStatus(String statusName) {
        this.statusName = statusName;
    }

    public int getAccountStatusId() {
        return accountStatusId;
    }

    public void setAccountStatusId(int accountStatusId) {
        this.accountStatusId = accountStatusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    @Override
    public String toString() {
        return "AccountStatus{"
                + "accountStatusId=" + accountStatusId
                + ", statusName='" + statusName + '\''
                + '}';
    }
}
