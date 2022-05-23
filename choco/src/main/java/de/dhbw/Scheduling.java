package de.dhbw;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.Solution;
import org.chocosolver.solver.variables.IntVar;

public class Scheduling {
    public static void main(String[] args) {
        Model model = new Model("scheduling-dhbw");

        IntVar[] rooms = new IntVar[21];
        IntVar[] lectRoomComb = new IntVar[21];

        IntVar[] lectures = new IntVar[21];
        IntVar[] days = new IntVar[21];

        int[] dayValues = {0,1,2,3,4};
        IntVar[] studDayValues = new IntVar[5];
        IntVar[] dozDayValues = new IntVar[5];

        IntVar[] days2019 = new IntVar[7];
        IntVar[] days2020 = new IntVar[7];
        IntVar[] days2021 = new IntVar[7];

        IntVar[] daysB = new IntVar[4];
        IntVar[] daysC = new IntVar[3];
        IntVar[] daysG = new IntVar[3];

        for(int i = 0;i<studDayValues.length;i++){
            studDayValues[i] = model.intVar(1,3);
            dozDayValues[i] = model.intVar(0,2);
        }

        for(int l = 0; l < 21; l++){
            lectures[l] = model.intVar("L_"+l, 0, 14);
            days[l] = model.intVar("D_"+l,0,4);
            model.div(lectures[l],model.intVar(3),days[l]).post();
            rooms[l] = model.intVar("Room_Lect_" + l,1,5);
            IntVar temp = model.intVar(15,75);
            model.times(rooms[l],15,temp).post();
            lectRoomComb[l] = model.intVar(15,90);
            model.arithm(lectRoomComb[l],"=",temp,"+",lectures[l]).post();
        }


        //Kurse
        for(int i = 0 ; i< 7;i++){
            days2019[i] = days[i];
            for(int j = i+1; j<7;j++){
                model.arithm(lectures[i],"!=",lectures[j]).post();
            }
        }

        for(int i = 7 ; i< 14;i++){
            days2020[i-7] = days[i];
            for(int j = i+1; j<14;j++){
                model.arithm(lectures[i],"!=",lectures[j]).post();
            }
        }
        for(int i = 14 ; i< 21;i++){
            days2021[i-14] = days[i];
            for(int j = i+1; j<21;j++){
                model.arithm(lectures[i],"!=",lectures[j]).post();
            }
        }

        //Dozierende
        model.arithm(lectures[0],"!=",lectures[7]).post(); //A

        //B
        IntVar[] dozB = {lectures[2],lectures[3],lectures[5],lectures[15]};
        System.arraycopy(dozB, 0, daysB, 0, dozB.length);

        model.allDifferent(dozB).post();

        //C
        IntVar[] dozC = {lectures[4],lectures[8],lectures[17]};
        System.arraycopy(dozC, 0, daysC, 0, dozC.length);

        model.allDifferent(dozC).post();

        //D
        model.arithm(lectures[19],"!=",lectures[20]).post();

        //E
        model.arithm(lectures[9],"!=",lectures[11]).post();

        //G
        IntVar[] dozG = {lectures[12],lectures[13],lectures[14]};
        System.arraycopy(dozG, 0, daysG, 0, dozG.length);

        model.allDifferent(dozG).post();

        //H
        model.arithm(lectures[1],"!=",lectures[6]).post();

        //I
        model.arithm(lectures[10],"!=",lectures[16]).post();

        model.globalCardinality(days2019,dayValues,studDayValues,false).post();
        model.globalCardinality(days2020,dayValues,studDayValues,false).post();
        model.globalCardinality(days2021,dayValues,studDayValues,false).post();

        model.globalCardinality(daysB,dayValues,dozDayValues,false).post();
        model.globalCardinality(daysC,dayValues,dozDayValues,false).post();
        model.globalCardinality(daysG,dayValues,dozDayValues,false).post();

        model.allDifferent(lectRoomComb).post();

        Solution solution = model.getSolver().findSolution();

        if(solution != null){
            for(IntVar i: lectures){
                int temp = solution.getIntVal(i);
                System.out.println(i.getName() + ":" + temp);
            }
            for(IntVar i: rooms){
                int temp = solution.getIntVal(i);
                System.out.println(i.getName() + ":" + temp);
            }
        } else {
            System.out.println("problem");
        }
    }
}