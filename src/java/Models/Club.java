package Models;

public class Club {
    private int clubId;
    private String clubName;
    private String clubLogo;

    public Club() {
    }

    public Club(int clubId, String clubName, String clubLogo) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.clubLogo = clubLogo;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubLogo() {
        return clubLogo;
    }

    public void setClubLogo(String clubLogo) {
        this.clubLogo = clubLogo;
    }
}
