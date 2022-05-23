package de.dhbw;

public class Lecture {
    int i;
    int room;
    int time;
    int day;

    public Lecture(int i, int room, int time, int day) {
        this.i = i;
        this.room = room;
        this.time = time;
        this.day = day;
    }

    public void print() {
        String val = "lecture: " + i + "| room: " + room + "| time: " + time + "| day: " + day;
        System.out.println(val);
    }
}
