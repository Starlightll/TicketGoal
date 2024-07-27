/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author mosdd
 */
public class Match {
    public int matchId;
    public String matchTitle;
    public Date schedule;
    public int pitchId;
    public int matchStatusId;
    public Club club1;
    public Club club2;
    public Address address;

    public Match() {
    }

    public Match(int matchId, String matchTitle, Date schedule, int pitchId, int matchStatusId, Club club1, Club club2, Address address) {
        this.matchId = matchId;
        this.matchTitle = matchTitle;
        this.schedule = schedule;
        this.pitchId = pitchId;
        this.matchStatusId = matchStatusId;
        this.club1 = club1;
        this.club2 = club2;
        this.address = address;
    }

    public int getMatchId() {
        return matchId;
    }

    public void setMatchId(int matchId) {
        this.matchId = matchId;
    }

    public String getMatchTitle() {
        return matchTitle;
    }

    public void setMatchTitle(String matchTitle) {
        this.matchTitle = matchTitle;
    }

    public Date getSchedule() {
        return schedule;
    }

    public void setSchedule(Date schedule) {
        this.schedule = schedule;
    }

    public int getPitchId() {
        return pitchId;
    }

    public void setPitchId(int pitchId) {
        this.pitchId = pitchId;
    }

    public int getMatchStatusId() {
        return matchStatusId;
    }

    public void setMatchStatusId(int matchStatusId) {
        this.matchStatusId = matchStatusId;
    }

    public Club getClub1() {
        return club1;
    }

    public void setClub1(Club club1) {
        this.club1 = club1;
    }

    public Club getClub2() {
        return club2;
    }

    public void setClub2(Club club2) {
        this.club2 = club2;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getDateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(schedule);
    }

    public String getMonth() {
        SimpleDateFormat sdf = new SimpleDateFormat("MM");
        return new DateFormatSymbols().getMonths()[Integer.parseInt(sdf.format(schedule)) - 1].substring(0, 3);
    }

    public String getDay() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd");
        return sdf.format(schedule);
    }

    public String getYear() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        return sdf.format(schedule);
    }

    public String getTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        return sdf.format(schedule);
    }


}
