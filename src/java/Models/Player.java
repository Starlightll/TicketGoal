/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author mosdd
 */
public class Player {
    private int playerId;
    private String playerName;
    private int playerNumber;
    private Date dateOfBirth;
    private float height;
    private float weight;
    private String biography;
    private int countryId;
    private int playerRoleId;
    private String image;
    private int ATK;
    private int DEF;
    private int SPD;
    public Player() {
    }

    public Player(int playerId, String playerName, int playerNumber, Date dateOfBirth, float height, float weight, String biography, int countryId, int playerRoleId, String image, int ATK, int DEF, int SPD) {
        this.playerId = playerId;
        this.playerName = playerName;
        this.playerNumber = playerNumber;
        this.dateOfBirth = dateOfBirth;
        this.height = height;
        this.weight = weight;
        this.biography = biography;
        this.countryId = countryId;
        this.playerRoleId = playerRoleId;
        this.image = image;
        this.ATK = ATK;
        this.DEF = DEF;
        this.SPD = SPD;
    }

    public int getPlayerId() {
        return playerId;
    }

    public void setPlayerId(int playerId) {
        this.playerId = playerId;
    }

    public String getPlayerName() {
        return playerName;
    }

    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }

    public int getPlayerNumber() {
        return playerNumber;
    }

    public void setPlayerNumber(int playerNumber) {
        this.playerNumber = playerNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public int getCountryId() {
        return countryId;
    }

    public void setCountryId(int countryId) {
        this.countryId = countryId;
    }

    public int getPlayerRoleId() {
        return playerRoleId;
    }

    public void setPlayerRoleId(int playerRoleId) {
        this.playerRoleId = playerRoleId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getATK() {
        return ATK;
    }

    public void setATK(int ATK) {
        this.ATK = ATK;
    }

    public int getDEF() {
        return DEF;
    }

    public void setDEF(int DEF) {
        this.DEF = DEF;
    }

    public int getSPD() {
        return SPD;
    }

    public void setSPD(int SPD) {
        this.SPD = SPD;
    }   
}