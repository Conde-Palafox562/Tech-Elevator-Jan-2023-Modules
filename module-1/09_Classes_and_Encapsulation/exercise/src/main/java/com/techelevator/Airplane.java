package com.techelevator;

public class Airplane {

    private String planeNumber;
    private int bookedFirstClassSeats;
    private int totalFirstClassSeats;
    private int bookedCoachSeats;
    private int totalCoachSeats;

    public Airplane(String planeNumber, int totalFirstClassSeats, int totalCoachSeats) {
        this.planeNumber = planeNumber;
        this.totalFirstClassSeats = totalFirstClassSeats;
        this.totalCoachSeats = totalCoachSeats;
    }

    public String getPlaneNumber() {
        return planeNumber;
    }

    public int getBookedFirstClassSeats() {
        return bookedFirstClassSeats;
    }

    public int getTotalFirstClassSeats() {
        return totalFirstClassSeats;
    }

    public int getBookedCoachSeats() {
        return bookedCoachSeats;
    }

    public int getTotalCoachSeats() {
        return totalCoachSeats;
    }

    public int getAvailableFirstClassSeats() {
        return totalFirstClassSeats - bookedFirstClassSeats;
    }

    public int getAvailableCoachSeats() {
        return totalCoachSeats - bookedCoachSeats;
    }

    //Method
    public boolean reserveSeats(boolean forFirstClass, int totalNumberOfSeats) {

        if (forFirstClass && getAvailableFirstClassSeats() >= totalNumberOfSeats) {
            bookedFirstClassSeats += totalNumberOfSeats;
            return true;

        } else if

        (!forFirstClass && getAvailableCoachSeats() >= totalNumberOfSeats) {
            bookedCoachSeats += totalNumberOfSeats;
            return true;

        } else return false;
    }
}
