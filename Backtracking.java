import java.util.Arrays;
import java.util.Date;
import java.util.Stack;

public class Backtracking {
    int inf2019[][] = new int[3][5];
    int inf2020[][] = new int[3][5];
    int inf2021[][] = new int[3][5];

    int rooms[][][] = new int[5][3][5];

    int dozA[][] = new int[3][5];
    int dozB[][] = new int[3][5];
    int dozC[][] = new int[3][5];
    int dozD[][] = new int[3][5];
    int dozE[][] = new int[3][5];
    int dozF[][] = new int[3][5];
    int dozG[][] = new int[3][5];
    int dozH[][] = new int[3][5];
    int dozI[][] = new int[3][5];

    public boolean isPossibleOneLecturePerDay(int i, int b) {
        boolean temp[] = new boolean[5];
        Arrays.fill(temp, false);
        temp[b] = true;
        if (i >= 1 && i <= 7) {
            for (int day = 0; day <= 4; day++) {
                if (inf2019[0][day] != 0 || inf2019[1][day] != 0 || inf2019[2][day] != 0) {
                    temp[day] = true;
                }
            }
            int count = 5;
            for (int entry = 0; entry <= 4; entry++) {
                if (temp[entry]) {
                    count--;
                }
            }
            int result = count - (7 - i);
            if (result > 0) {
                return false;
            } else
                return true;
        } else if (i >= 8 && i <= 14) {
            for (int day = 0; day <= 4; day++) {
                if (inf2020[0][day] != 0 || inf2020[1][day] != 0 || inf2020[2][day] != 0) {
                    temp[day] = true;
                }
            }
            int count = 5;
            for (int entry = 0; entry <= 4; entry++) {
                if (temp[entry]) {
                    count--;
                }
            }
            int result = count - (14 - i);
            if (result > 0) {
                return false;
            } else
                return true;
        } else if (i >= 15 && i <= 21) {
            for (int day = 0; day <= 4; day++) {
                if (inf2021[0][day] != 0 || inf2021[1][day] != 0 || inf2021[2][day] != 0) {
                    temp[day] = true;
                }
            }
            int count = 5;
            for (int entry = 0; entry <= 4; entry++) {
                if (temp[entry]) {
                    count--;
                }
            }
            int result = count - (21 - i);
            if (result > 0) {
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

    public boolean notThirdLecture(char c, int b) {
        int count = 0;
        switch (c) {
            case 'a':
                for (int i = 0; i <= 2; i++) {
                    if (dozA[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'b':
                for (int i = 0; i <= 2; i++) {
                    if (dozB[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'c':
                for (int i = 0; i <= 2; i++) {
                    if (dozC[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'd':
                for (int i = 0; i <= 2; i++) {
                    if (dozD[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'e':
                for (int i = 0; i <= 2; i++) {
                    if (dozE[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'f':
                for (int i = 0; i <= 2; i++) {
                    if (dozF[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'g':
                for (int i = 0; i <= 2; i++) {
                    if (dozG[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'h':
                for (int i = 0; i <= 2; i++) {
                    if (dozH[i][b] != 0) {
                        count++;
                    }
                }
                break;
            case 'i':
                for (int i = 0; i <= 2; i++) {
                    if (dozI[i][b] != 0) {
                        count++;
                    }
                }
                break;
        }
        if (count < 2) {
            return true;
        } else {
            return false;
        }
    }

    public int[][][] fill3dim(int[][][] arr, int val) {
        for (int a = 0; a < arr.length; a++) {
            for (int b = 0; b < arr[a].length; b++) {
                for (int c = 0; c < arr[a][b].length; c++) {
                    arr[a][b][c] = val;
                }
            }
        }
        return arr;
    }

    public int[][] fill2dim(int[][] arr, int val) {
        for (int a = 0; a < arr.length; a++) {
            for (int b = 0; b < arr[a].length; b++) {
                arr[a][b] = val;
            }
        }
        return arr;
    }

    public static void main(String[] args) {

        Date date = new Date();

        long t1 = date.getTime();

        Stack<Lecture> decisions = new Stack<>();

        Lecture createdSchedule[] = new Lecture[21];

        Backtracking schedule = new Backtracking();
        schedule.fill2dim(schedule.inf2019, 0);
        schedule.fill2dim(schedule.inf2020, 0);
        schedule.fill2dim(schedule.inf2021, 0);
        schedule.fill3dim(schedule.rooms, 0);
        schedule.fill2dim(schedule.dozA, 0);
        schedule.fill2dim(schedule.dozB, 0);
        schedule.fill2dim(schedule.dozC, 0);
        schedule.fill2dim(schedule.dozD, 0);
        schedule.fill2dim(schedule.dozE, 0);
        schedule.fill2dim(schedule.dozF, 0);
        schedule.fill2dim(schedule.dozG, 0);
        schedule.fill2dim(schedule.dozH, 0);
        schedule.fill2dim(schedule.dozI, 0);

        Lecture rollBack = null;

        boolean fail = false;

        for (int i = 1; i <= 21; i++) {
            int lockedRoom = -1, lockedTime = -1, lockedDay = -1;
            if (rollBack != null) {
                lockedRoom = rollBack.room;
                lockedTime = rollBack.time;
                lockedDay = rollBack.day;
            }
            boolean isSet = false;
            if (!fail) {
                for (int b = 0; b <= 4; b++) {
                    for (int a = 0; a <= 2; a++) {
                        for (int r = 0; r <= 4; r++) {
                            if (schedule.rooms[r][a][b] == 0 && !isSet
                                    && (r > lockedRoom | a > lockedTime | b > lockedDay)) {
                                switch (i) {
                                    case 1:
                                        if (schedule.dozA[a][b] == 0 && schedule.inf2019[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('a', b)) {
                                            schedule.dozA[a][b] = i;
                                            schedule.inf2019[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 2, 7:
                                        if (schedule.dozH[a][b] == 0 && schedule.inf2019[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('h', b)) {
                                            schedule.dozH[a][b] = i;
                                            schedule.inf2019[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 3, 4, 6:
                                        if (schedule.dozB[a][b] == 0 && schedule.inf2019[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('b', b)) {
                                            schedule.dozB[a][b] = i;
                                            schedule.inf2019[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 5:
                                        if (schedule.dozC[a][b] == 0 && schedule.inf2019[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('c', b)) {
                                            schedule.dozC[a][b] = i;
                                            schedule.inf2019[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 8:
                                        if (schedule.dozA[a][b] == 0 && schedule.inf2020[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('a', b)) {
                                            schedule.dozA[a][b] = i;
                                            schedule.inf2020[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 9:
                                        if (schedule.dozC[a][b] == 0 && schedule.inf2020[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('c', b)) {
                                            schedule.dozC[a][b] = i;
                                            schedule.inf2020[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            decisions.add(new Lecture(i, r, a, b));
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            isSet = true;
                                        }
                                        break;
                                    case 10, 12:
                                        if (schedule.dozE[a][b] == 0 && schedule.inf2020[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('e', b)) {
                                            schedule.dozE[a][b] = i;
                                            schedule.inf2020[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 11:
                                        if (schedule.dozI[a][b] == 0 && schedule.inf2020[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('i', b)) {
                                            schedule.dozI[a][b] = i;
                                            schedule.inf2020[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 13, 14:
                                        if (schedule.dozG[a][b] == 0 && schedule.inf2020[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('g', b)) {
                                            schedule.dozG[a][b] = i;
                                            schedule.inf2020[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 15:
                                        if (schedule.dozG[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('g', b)) {
                                            schedule.dozG[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 16:
                                        if (schedule.dozB[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('b', b)) {
                                            schedule.dozB[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 17:
                                        if (schedule.dozI[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('i', b)) {
                                            schedule.dozI[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 18:
                                        if (schedule.dozC[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('c', b)) {
                                            schedule.dozC[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 19:
                                        if (schedule.dozF[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('f', b)) {
                                            schedule.dozF[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                    case 20, 21:
                                        if (schedule.dozD[a][b] == 0 && schedule.inf2021[a][b] == 0
                                                && schedule.isPossibleOneLecturePerDay(i, b)
                                                && schedule.notThirdLecture('d', b)) {
                                            schedule.dozD[a][b] = i;
                                            schedule.inf2021[a][b] = i;
                                            schedule.rooms[r][a][b] = i;
                                            createdSchedule[i - 1] = new Lecture(i, r, a, b);
                                            decisions.add(new Lecture(i, r, a, b));
                                            isSet = true;
                                        }
                                        break;
                                }
                            }
                        }
                    }
                }
            }
            if (!isSet) {
                if (decisions.isEmpty()) {
                    fail = true;
                } else {
                    rollBack = decisions.pop();
                    int lect = rollBack.i;
                    int room = rollBack.room;
                    int time = rollBack.time;
                    int day = rollBack.day;
                    createdSchedule[lect - 1] = null;
                    schedule.rooms[room][time][day] = 0;
                    switch (lect) {
                        case 1, 2, 3, 4, 5, 6, 7:
                            schedule.inf2019[time][day] = 0;
                            break;
                        case 8, 9, 10, 11, 12, 13, 14:
                            schedule.inf2020[time][day] = 0;
                            break;
                        case 15, 16, 17, 18, 19, 20, 21:
                            schedule.inf2021[time][day] = 0;
                            break;
                    }
                    switch (lect) {
                        case 1, 8:
                            schedule.dozA[time][day] = 0;
                            break;
                        case 3, 4, 6, 16:
                            schedule.dozB[time][day] = 0;
                            break;
                        case 5, 9, 18:
                            schedule.dozC[time][day] = 0;
                            break;
                        case 20, 21:
                            schedule.dozD[time][day] = 0;
                            break;
                        case 10, 12:
                            schedule.dozE[time][day] = 0;
                            break;
                        case 19:
                            schedule.dozF[time][day] = 0;
                            break;
                        case 13, 14, 15:
                            schedule.dozG[time][day] = 0;
                            break;
                        case 2, 7:
                            schedule.dozH[time][day] = 0;
                            break;
                        case 11, 17:
                            schedule.dozI[time][day] = 0;
                            break;
                    }
                    i = lect - 1;
                }
            } else {
                rollBack = null;
            }
        }
        if (!fail) {
            for (Lecture l : createdSchedule) {
                l.print();
            }
        }

        Date date2 = new Date();

        long t2 = date2.getTime();

        System.out.println("Time needed:" + (t2 - t1));
    }
}