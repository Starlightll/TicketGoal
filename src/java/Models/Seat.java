package Models;


public class Seat {
    private int seatId;
    private int seatNumber;
    private int row;
    private int price;
    private int areaId;
    private int seatStatusId;

    public Seat() {
    }

    public Seat(int seatId, int seatNumber, int row, int price, int areaId, int seatStatusId) {
        this.seatId = seatId;
        this.seatNumber = seatNumber;
        this.row = row;
        this.price = price;
        this.areaId = areaId;
        this.seatStatusId = seatStatusId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public int getSeatStatusId() {
        return seatStatusId;
    }

    public void setSeatStatusId(int seatStatusId) {
        this.seatStatusId = seatStatusId;
    }
}
