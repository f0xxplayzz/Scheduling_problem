:-lib(ic).
:-lib(gfd).

genHelpers([H|T],[H2|T2],[H3|T3]):- H + H2*15 $= H3, genHelpers(T,T2,T3).
genHelpers([],[],[]).

genDays([H|T],[H2|T2]):- H2::[0..4],R::[0..2], H2 * 3 + R $= H , genDays(T,T2).
genDays([],[]).

solve(Subs,Rooms):-
    Subs=[DB2,ITS,KI,LP,FP,ASWE,SV,DB1,TINF3,SWE,M2,P2,RA,BS,DT,TINF1,M1,P1,VLA,WE,BWL],
    Subs::[0..14],
    Rooms=[R_DB2,R_ITS,R_KI,R_LP,R_FP,R_ASWE,R_SV,R_DB1,R_TINF3,R_SWE,R_M2,R_P2,R_RA,R_BS,R_DT,R_TINF1,R_M1,R_P1,R_VLA,R_WE,R_BWL],
    Rooms::[1..5],
    Inf2019 = [DB2,ITS,KI,LP,FP,ASWE,SV],
    Inf2020 = [DB1,TINF3,SWE,M2,P2,RA,BS],
    Inf2021 = [DT,TINF1,M1,P1,VLA,WE,BWL] ,
    A=[DB1,DB2],
    B=[TINF1,KI,LP,ASWE],
    C=[FP,TINF3,P1],
    D=[WE,BWL],
    E=[SWE,P2],
    G=[RA,DT,BS],
    H=[ITS,SV],
    I=[M1,M2],
    alldifferent(Inf2019),
    alldifferent(Inf2020),
    alldifferent(Inf2021),
    alldifferent(A),
    alldifferent(B),
    alldifferent(C),
    alldifferent(D),
    alldifferent(E),
    alldifferent(G),
    alldifferent(H),
    alldifferent(I),
    genHelpers(Subs,Rooms,Helpers),
    alldifferent(Helpers),
    genDays(Inf2019,Days19),
    genDays(Inf2020,Days20),
    genDays(Inf2021,Days21),
    genDays(B,DaysB),
    genDays(C,DaysC),
    genDays(G,DaysG),
    gcc([gcc(1,3,0),gcc(1,3,1),gcc(1,3,2),gcc(1,3,3),gcc(1,3,4)],Days19),
    gcc([gcc(1,3,0),gcc(1,3,1),gcc(1,3,2),gcc(1,3,3),gcc(1,3,4)],Days20),
    gcc([gcc(1,3,0),gcc(1,3,1),gcc(1,3,2),gcc(1,3,3),gcc(1,3,4)],Days21),
    gcc([gcc(0,2,0),gcc(0,2,1),gcc(0,2,2),gcc(0,2,3),gcc(0,2,4)],DaysB),
    gcc([gcc(0,2,0),gcc(0,2,1),gcc(0,2,2),gcc(0,2,3),gcc(0,2,4)],DaysC),
    gcc([gcc(0,2,0),gcc(0,2,1),gcc(0,2,2),gcc(0,2,3),gcc(0,2,4)],DaysG).
    