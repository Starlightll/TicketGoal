/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.List;


public class SearchData {

    private String club;
    private List<String> selectedTickets;

    // Các phương thức getter và setter
    public String getClub() {
        return club;
    }

    public void setClub(String club) {
        this.club = club;
    }

    public List<String> getSelectedTickets() {
        return selectedTickets;
    }

    public void setSelectedTickets(List<String> selectedTickets) {
        this.selectedTickets = selectedTickets;
    }
}
