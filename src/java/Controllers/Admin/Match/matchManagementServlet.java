/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.Match;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import DAO.ClubDAO;
import Models.Address;
import Models.Club;
import Models.Match;
import Models.Pitch;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author mosdd
 */
public class matchManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            List<Match> matchList = getMatches();
            for (Match match : matchList) {
                out.println("<form>\n" +
                        "                        <div class=\"match\">\n" +
                        "                            <div class=\"match__date\">\n" +
                        "                                <img src=\"./img/matches/DateBanner.png\" alt=\"\">\n" +
                        "                                <div class=\"match__date__day\">" + match.getDay() + "</div>\n" +
                        "                                <div class=\"match__date__month\">" + match.getMonth() + "</div>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"match__content\">\n" +
                        "                                <div class=\"club__section\">\n" +
                        "                                    <div class=\"club\">\n" +
                        "                                        <img src=\"data:image/jpeg;base64," + match.club1.getClubLogo() + "\" alt=\"\">\n" +
                        "                                        <p>" + match.club1.getClubName() + "</p>\n" +
                        "                                    </div>\n" +
                        "                                    <div class=\"vs\"><p>VS</p></div>\n" +
                        "                                    <div class=\"club\">\n" +
                        "                                        <img src=\"data:image/jpeg;base64," + match.club2.getClubLogo() + "\" alt=\"\">\n" +
                        "                                        <p>" + match.club2.getClubName() + "</p>\n" +
                        "                                    </div>\n" +
                        "                                </div>\n" +
                        "                                <div class=\"match__location\">\n" +
                        "                                    <i class=\"ri-map-pin-2-fill\"></i>\n" +
                        "                                    <p>" + match.address.getAddressName() + " / " + match.getTime() + "-</p>\n" +
                        "                                   <div class=\"match__status\">\n");
                if (match.getMatchStatusId() == 1) {
                    out.println("<p style=\"color: #ffbc3e\">Upcoming</p>");
                } else if (match.getMatchStatusId() == 2) {
                    out.println("<p style=\"color: #69e635\">Ongoing</p>");
                } else if (match.getMatchStatusId() == 3) {
                    out.println("<p style=\"color: #ff3e3e\">Finished</p>");
                } else if (match.getMatchStatusId() == 4) {
                    out.println("<p style=\"color: #ff3e3e\">Cancelled</p>");
                }
                out.println(
                        "                                    </div>" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                            <div class=\"option\">\n" +
                                "                                <button class=\"update__button\" type=\"button\" onclick=\"showUpdate("+match.matchId+", '"+match.getDateTime()+"', "+match.pitchId+", "+match.matchStatusId+", "+match.club1.getClubId()+", "+match.club2.getClubId()+")\">Update</button>" +
                                "                                <button class=\"delete__button\" type=\"button\" onclick=\"deleteMatch(" + match.matchId + ")\">Delete</button>\n" +
                                "                            </div>\n" +
                                "                        </div>\n" +
                                "                    </form>");
            }

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Get all matches
        List<Match> matchList = getMatches();
        request.setAttribute("matches", matchList);

        //Get all clubs
        List<Club> clubList = getClubs();
        request.setAttribute("clubs", clubList);

        //Get all stadiums
        List<Pitch> pitchList = DAO.PitchDAO.INSTANCE.getPitchList();
        request.setAttribute("stadiums", pitchList);

        //set css
        request.setAttribute("dropdownMenu", "block");
        request.setAttribute("matchManagementDropdown", "style=\"background-color: #00C767; pointer-events: none;\"");
        request.setAttribute("page", "/Views/Admin/Match/MatchManagement.jsp");
        request.getRequestDispatcher("/Views/Admin/AdminPanel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String option = request.getParameter("option");
        switch (option) {
            case "addMatch":
                int club1Id = Integer.parseInt(request.getParameter("club1Id"));
                int club2Id = Integer.parseInt(request.getParameter("club2Id"));
                int pitchId = Integer.parseInt(request.getParameter("pitchId"));
                SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date schedule = null;
                //Parse schedule
                try {
                    schedule = sdf.parse(request.getParameter("schedule"));
                } catch (java.text.ParseException e) {
                    e.printStackTrace();
                }
                Models.Match match = new Models.Match();
                match.setSchedule(schedule);
                match.setPitchId(pitchId);
                //Set club1 and club2
                Club club1 = new Club();
                club1.setClubId(club1Id);
                match.setClub1(club1);
                Club club2 = new Club();
                club2.setClubId(club2Id);
                match.setClub2(club2);
                //If match is after current time, set status to 1 (upcoming)
                if (match.getSchedule().after(new java.util.Date())) {
                    match.setMatchStatusId(1);
                } else {
                    match.setMatchStatusId(2);
                }
                DAO.MatchDAO.INSTANCE.addMatch(match);
                break;
            case "updateMatch":
                Match matchUpdate = new Match();
                try{
                    matchUpdate.setMatchId(Integer.parseInt(request.getParameter("matchId")));
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    matchUpdate.setSchedule(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(request.getParameter("schedule")));
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    matchUpdate.setPitchId(Integer.parseInt(request.getParameter("pitchId")));
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    matchUpdate.setMatchStatusId(Integer.parseInt(request.getParameter("status")));
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    Club club1Update = new Club();
                    club1Update.setClubId(Integer.parseInt(request.getParameter("club1Id")));
                    matchUpdate.setClub1(club1Update);
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    Club club2Update = new Club();
                    club2Update.setClubId(Integer.parseInt(request.getParameter("club2Id")));
                    matchUpdate.setClub2(club2Update);
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                try{
                    Address addressUpdate = new Address();
                    addressUpdate.setAddressName(request.getParameter("addressName"));
                    addressUpdate.setAddressURL(request.getParameter("addressURL"));
                    matchUpdate.setAddress(addressUpdate);
                }catch(Exception e){
                    System.out.println("Update match error: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Update match error: " + e.getMessage());
                }
                if(updateMatch(matchUpdate)){
                    response.setStatus(HttpServletResponse.SC_OK);
                }else{
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Update match error: Internal server error");
                }
                break;
            case "deleteMatch":
                int matchId = Integer.parseInt(request.getParameter("matchId"));
                DAO.MatchDAO.INSTANCE.deleteMatch(matchId);
                break;
            default:
                break;
        }
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public List<Match> getMatches() {
        ResultSet matches = DAO.MatchDAO.INSTANCE.getMatches();
        List<Match> matchList = new java.util.ArrayList<>();
        try {
            while (matches.next()) {
                Match match = new Match();
                match.setMatchId(matches.getInt("matchId"));
                match.setSchedule(new Date(matches.getTimestamp("schedule").getTime()));
                match.setPitchId(matches.getInt("pitchId"));
                match.setMatchStatusId(matches.getInt("matchStatusId"));
                //Get club1 and club2
                Club club1 = ClubDAO.INSTANCE.getClub(matches.getInt("club1"));
                match.setClub1(club1);
                Club club2 = ClubDAO.INSTANCE.getClub(matches.getInt("club2"));
                match.setClub2(club2);
                //Get address
                Address address = new Address();
                address.setAddressName(matches.getString("addressName"));
                address.setAddressURL(matches.getString("addressURL"));
                match.setAddress(address);
                matchList.add(match);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return matchList;
    }

    public List<Club> getClubs() {
        ResultSet clubs = DAO.ClubDAO.INSTANCE.getClubs();
        List<Club> clubList = new java.util.ArrayList<>();
        try {
            while (clubs.next()) {
                Club club = new Club();
                club.setClubId(clubs.getInt("clubId"));
                club.setClubName(clubs.getString("clubName"));
                club.setClubLogo(clubs.getString("logo"));
                clubList.add(club);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return clubList;
    }

    public boolean updateMatch(Match match) {
        return DAO.MatchDAO.INSTANCE.updateMatch(match);
    }


}
