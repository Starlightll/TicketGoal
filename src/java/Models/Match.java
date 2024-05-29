/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.text.DateFormatSymbols;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 *
 * @author mosdd
 */
public class Match {
    public int matchId;
    public Date schedule;
    public int pitchId;
    public int matchStatusId;
    public int club1;
    public int club2;
    public String location;

    public Match() {
    }

    public Match(int matchId, Date schedule, int pitchId, int matchStatusId, int club1, int club2, String location) {
        this.matchId = matchId;
        this.schedule = schedule;
        this.pitchId = pitchId;
        this.matchStatusId = matchStatusId;
        this.club1 = club1;
        this.club2 = club2;
        this.location = location;
    }

    public int getMatchId() {
        return matchId;
    }

    public void setMatchId(int matchId) {
        this.matchId = matchId;
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

    public int getClub1() {
        return club1;
    }

    public void setClub1(int club1) {
        this.club1 = club1;
    }

    public int getClub2() {
        return club2;
    }

    public void setClub2(int club2) {
        this.club2 = club2;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    
     public int getDay() {
        LocalDateTime localDateTime = schedule.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        return localDateTime.getDayOfMonth();
    }

    public int getMonth() {
        LocalDateTime localDateTime = schedule.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        return localDateTime.getMonthValue();
    }

    public int getYear() {
        LocalDateTime localDateTime = schedule.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        return localDateTime.getYear();
    }

    public String getTime() {
        LocalDateTime localDateTime = schedule.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        int hour = localDateTime.getHour();
        int minute = localDateTime.getMinute();
        int second = localDateTime.getSecond();
        return String.format("%02d:%02d:%02d", hour, minute, second);
    }
    
    public String getMonthName() {
        DateFormatSymbols dfs = new DateFormatSymbols();
        String[] months = dfs.getMonths();
        LocalDateTime localDateTime = schedule.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        int month = localDateTime.getMonthValue();
        return months[month];
    }
    
    
    
}
