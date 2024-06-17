/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.Match;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
                        "                                <div class=\"match__date__day\">"+match.getDay()+"</div>\n" +
                        "                                <div class=\"match__date__month\">"+match.getMonth()+"</div>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"match__content\">\n" +
                        "                                <div class=\"club__section\">\n" +
                        "                                    <div class=\"club\">\n" +
                        "                                        <img src=\"data:image/jpeg;base64,"+match.club1.getClubLogo()+"\" alt=\"\">\n" +
                        "                                        <p>"+match.club1.getClubName()+"</p>\n" +
                        "                                    </div>\n" +
                        "                                    <div class=\"vs\"><p>VS</p></div>\n" +
                        "                                    <div class=\"club\">\n" +
                        "                                        <img src=\"data:image/jpeg;base64,"+match.club2.getClubLogo()+"\" alt=\"\">\n" +
                        "                                        <p>"+match.club2.getClubName()+"</p>\n" +
                        "                                    </div>\n" +
                        "                                </div>\n" +
                        "                                <div class=\"match__location\">\n" +
                        "                                    <i class=\"ri-map-pin-2-fill\"></i>\n" +
                        "                                    <p>"+match.address.getAddressName()+", "+match.schedule+"</p>\n" +
                        "                                </div>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"option\">\n" +
                        "                                <a class=\"update__button\" href=\"\">Update</a>\n" +
                        "                                <button class=\"delete__button\" type=\"button\" onclick=\"deleteMatch("+match.matchId+")\">Delete</button>\n" +
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
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                java.util.Date schedule = null;
                try {
                    schedule = sdf.parse(request.getParameter("schedule"));
                } catch (java.text.ParseException e) {
                    e.printStackTrace();
                }
                Models.Match match = new Models.Match();
                match.setSchedule(schedule);
                match.setPitchId(pitchId);
                match.setMatchStatusId(1);
                Club club1 = new Club();
                club1.setClubId(club1Id);
                match.setClub1(club1);
                Club club2 = new Club();
                club2.setClubId(club2Id);
                match.setClub2(club2);
                DAO.MatchDAO.INSTANCE.addMatch(match);
                break;
            case "updateMatch":
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



}
