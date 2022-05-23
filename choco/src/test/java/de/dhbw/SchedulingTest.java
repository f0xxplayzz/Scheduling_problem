package de.dhbw;

import org.junit.Test;
import de.dhbw.Scheduling;

public class SchedulingTest {

    @Test
    public void test(){
        Scheduling s = new Scheduling();
        s.schedule();
    }

    @Test
    public void testImperative(){
        Imperative.run();
    }

    @Test
    public void backtracking(){
        Backtracking.run();
    }
}
