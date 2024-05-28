/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author pc
 */
public class PlayerRole {
    private int playerRoleId;
    private String roleName;

    public PlayerRole(int playerRoleId, String roleName) {
        this.playerRoleId = playerRoleId;
        this.roleName = roleName;
    }

    public int getPlayerRoleId() {
        return playerRoleId;
    }

    public void setPlayerRoleId(int playerRoleId) {
        this.playerRoleId = playerRoleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public String toString() {
        return "PlayerRole{" + "playerRoleId=" + playerRoleId + ", roleName=" + roleName + '}';
    }
    
}