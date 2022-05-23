:- use_module(library(clpfd)).

genHelpers([H|T],[H2|T2],[H3|T3]):-H3 #= H + H2*15, genHelpers(T,T2,T3).
genHelpers([],[],[]).

genDays([H|T],[H2|T2]):- H2 in 0..4, Temp #= H -1, H2 #= Temp div 3, genDays(T,T2).
genDays([],[]).

schedule(Subs,Rooms):-
    Subs = [DB2,ITS,KI,LP,FP,ASWE,SV,DB1,TINF3,SWE,M2,P2,RA,BS,DT,TINF1,M1,P1,VLA,WE,BWL],
    Rooms = [R_DB2,R_ITS,R_KI,R_LP,R_FP,R_ASWE,R_SV,R_DB1,R_TINF3,R_SWE,R_M2,R_P2,R_RA,R_BS,R_DT,R_TINF1,R_M1,R_P1,R_VLA,R_WE,R_BWL],
    Subs ins 1..15,
    Rooms ins 1..5,
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
    all_distinct(Inf2019),
    all_distinct(Inf2020),
    all_distinct(Inf2021),
    all_distinct(A),
    all_distinct(B),
    all_distinct(C),
    all_distinct(D),
    all_distinct(E),
    all_distinct(G),
    all_distinct(H),
    all_distinct(I),
    genHelpers(Subs,Rooms,Helpers),
    all_distinct(Helpers),
    genDays(Inf2019,Days19),
    genDays(Inf2020,Days20),
    genDays(Inf2021,Days21),
    genDays(B,DaysB),
    genDays(C,DaysC),
    genDays(G,DaysG),
    StudDays = [Mon19,Mon20,Mon21,Tue19,Tue20,Tue21,Wed19,Wed20,Wed21,Thu19,Thu20,Thu21,Fri19,Fri20,Fri21],
    DozDays = [MonB,MonC,MonG,TueB,TueC,TueG,WedB,WedC,WedG,ThuB,ThuC,ThuG,FriB,FriC,FriG],
    DozDays ins 0..2,
    StudDays ins 1..3,
    global_cardinality(Days19,[0-Mon19,1-Tue19,2-Wed19,3-Thu19,4-Fri19]),
    global_cardinality(Days20,[0-Mon20,1-Tue20,2-Wed20,3-Thu20,4-Fri20]),
    global_cardinality(Days21,[0-Mon21,1-Tue21,2-Wed21,3-Thu21,4-Fri21]),
    global_cardinality(DaysB,[0-MonB,1-TueB,2-WedB,3-ThuB,4-FriB]),
    global_cardinality(DaysC,[0-MonC,1-TueC,2-WedC,3-ThuC,4-FriC]),
    global_cardinality(DaysG,[0-MonG,1-TueG,2-WedG,3-ThuG,4-FriG]).

test(V,A):- schedule(V,A),label(V),label(A).