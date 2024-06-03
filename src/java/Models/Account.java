/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class Account {

    private int accountId;
    private String username;
    private String password;
    private String email;
    private String phoneNumber;
    private Integer gender;
    private String address;
    private int roleId;
    private int accountStatusId;

    public Account() {
    }

    public Account(int accountId, String username, String password, String email, String phoneNumber, Integer gender, String address, int roleId, int accountStatusId) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.address = address;
        this.roleId = roleId;
        this.accountStatusId = accountStatusId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getAccountStatusId() {
        return accountStatusId;
    }

    public void setAccountStatusId(int accountStatusId) {
        this.accountStatusId = accountStatusId;
    }

    @Override
    public String toString() {
        return "Account{"
                + "accountId=" + accountId
                + ", username='" + username + '\''
                + ", password='" + password + '\''
                + ", email='" + email + '\''
                + ", phoneNumber='" + phoneNumber + '\''
                + ", gender=" + gender
                + ", address='" + address + '\''
                + ", roleId=" + roleId
                + ", accountStatusId=" + accountStatusId
                + '}';
    }
}
