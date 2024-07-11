/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 * @author mosdd
 */
public class Pitch {
    public int pitchId;
    public String pitchName;
    public String addressName;
    public String addressURL;
    public String pitchStructure;
    public String image;

    public Pitch() {
    }


    public Pitch(int pitchId, String pitchName, String addressName, String addressURL, String pitchStructure, String image) {
        this.pitchId = pitchId;
        this.pitchName = pitchName;
        this.addressName = addressName;
        this.addressURL = addressURL;
        this.pitchStructure = pitchStructure;
        this.image = image;
    }

    public int getPitchId() {
        return pitchId;
    }

    public void setPitchId(int pitchId) {
        this.pitchId = pitchId;
    }

    public String getPitchName() {
        return pitchName;
    }

    public void setPitchName(String pitchName) {
        this.pitchName = pitchName;
    }

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }

    public String getAddressURL() {
        return addressURL;
    }

    public void setAddressURL(String addressURL) {
        this.addressURL = addressURL;
    }

    public String getPitchStructure() {
        return pitchStructure;
    }

    public void setPitchStructure(String pitchStructure) {
        this.pitchStructure = pitchStructure;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


}
