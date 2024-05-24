/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mosdd
 */
public class Pitch {
    public int pitchId;
    public String pitchName;
    public String address;
    public String pitchStructure;
    public String image;

    public Pitch() {
    }

    public Pitch(int pitchId, String pitchName, String address, String pitchStructure, String image) {
        this.pitchId = pitchId;
        this.pitchName = pitchName;
        this.address = address;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
