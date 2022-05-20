package de.dhbw;

import org.chocosolver.solver.Model;
import org.chocosolver.solver.variables.IntVar;

public class Scheduling {
    public static void main(String[] args) {
        Model model = new Model("scheduling-dhbw");

        IntVar[] lectures = new IntVar[21];
        for(int l = 0; l < 21; l++){
            lectures[l] = model.intVar("L_"+l, 1, 15);
        }

        for(int i = 0 ; i< 7;i++){
            for(int j = i+1; i<7;i++){
                model.arithm(lectures[i],"!=",lectures[j]);
            }
        }
        for(int i = 7 ; i< 14;i++){
            for(int j = i+1; i<14;i++){
                model.arithm(lectures[i],"!=",lectures[j]);
            }
        }
        for(int i = 14 ; i< 21;i++){
            for(int j = i+1; i<21;i++){
                model.arithm(lectures[i],"!=",lectures[j]);
            }
        }
    }
}
