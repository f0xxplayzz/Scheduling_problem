nonIdentic(_,[]).
nonIdentic(A,[H|T]):-notSameTime(A,H), nonIdentic(A,T).

addToSchedule(Vl,[],[Vl]).
addToSchedule(Vl,Vls,[Vl|Vls]):-nonIdentic(Vl,Vls).

genLectures([X],Times,Days,[vl(X,A,B)]):-member(A,Times),member(B,Days).
genLectures([Vl|Vls],Times,Days,Result):-
    member(A,Times),
    member(B,Days),
    genLectures(Vls,Times,Days,T),
    addToSchedule(vl(Vl,A,B),T,Result).

notSameTime(vl(_,Time,Day),vl(_,Time2,Day2)):- Time =\= Time2; Day =\= Day2.

genNums(0,[]).
genNums(A,[A|T]):-B is A-1,genNums(B,T).

genNums(A,B,[A|T]):-A>B,C is A-1,genNums(C,B,T).
genNums(A,B,[B]):- A == B.

onePerDay_([vl(_,_,D)],[D]).
onePerDay_([vl(_,_,D)|T],[D|Ds]):- onePerDay_(T,Ds),not(member(D,Ds)).
onePerDay_([vl(_,_,D)|T],Ds):- onePerDay_(T,Ds),member(D,Ds).


onePerDay(Vs):-onePerDay_(Vs,Check),length(Check,5).

maxTwoPerDay(Vs):-maxTwoPerDay_(Vs,[0,0,0,0,0],Xs),max_list(Xs,A), A < 3.

maxTwoPerDay_([vl(_,_,Day)|T],In,[ResA,B,C,D,E]):- Day == 1, maxTwoPerDay_(T,In,[A,B,C,D,E]) , ResA is A +1.
maxTwoPerDay_([vl(_,_,Day)|T],In,[A,ResB,C,D,E]):- Day == 2, maxTwoPerDay_(T,In,[A,B,C,D,E]) , ResB is B +1.
maxTwoPerDay_([vl(_,_,Day)|T],In,[A,B,ResC,D,E]):- Day == 3, maxTwoPerDay_(T,In,[A,B,C,D,E]) , ResC is C +1.
maxTwoPerDay_([vl(_,_,Day)|T],In,[A,B,C,ResD,E]):- Day == 4, maxTwoPerDay_(T,In,[A,B,C,D,E]) , ResD is D +1.
maxTwoPerDay_([vl(_,_,Day)|T],In,[A,B,C,D,ResE]):- Day == 5, maxTwoPerDay_(T,In,[A,B,C,D,E]) , ResE is E +1. 
maxTwoPerDay_([],A,A).

selectLect([],_,[]).
selectLect(_,[],[]).
selectLect([vl(L,A,B)|T],Selects,[vl(L,A,B)|T2]):-
    member(L,Selects),
    select(L, Selects, Sels2),
    selectLect(T,Sels2,T2).
selectLect([vl(L,_,_)|T],Selects,T2):-
    not(member(L,Selects)),
    selectLect(T,Selects,T2).

putRooms([],_,[]).
putRooms([vl(A,B,C)|T],Rooms,[vl_r(A,B,C,R)|T2]):-member(R,Rooms),putRooms(T,Rooms,T2).

nonOverlapping(Vs):-nonOverlapping_(Vs,_).
nonOverlapping_([vl(_,B,C)],[t(B,C)]).
nonOverlapping_([vl(_,B,C)|T],[t(B,C)|T2]):-nonOverlapping_(T,T2), not(member(t(B,C),T2)).

nonOverLappingRooms(Vls):-nonOverLappingRooms_(Vls,_).

nonOverLappingRooms_([vl_r(_,A,B,R)],[r(A,B,R)]).
nonOverLappingRooms_([vl_r(_,A,B,R)|T],[r(A,B,R)|T2]):- nonOverLappingRooms_(T,T2), not(member(r(A,B,R),T2)).

solve(Vs):-
    genNums(7,Vls19),
    genNums(14,8,Vls20),
    genNums(21,15,Vls21),
    genNums(3,Times),
    genNums(5,Days),
    genNums(5,Rooms),
    genLectures(Vls19,Times,Days,Vs19),
    onePerDay(Vs19),
    genLectures(Vls20,Times,Days,Vs20),
    onePerDay(Vs20),
    genLectures(Vls21,Times,Days,Vs21),
    onePerDay(Vs21),
    append(Vs21,Vs20,T1),
    append(T1,Vs19,Vs). /*
    selectLect(Vs,[1,8],A),
    selectLect(Vs,[3,4,6,16],B),
    selectLect(Vs,[5,9,18],C),
    selectLect(Vs,[20,21],D),
    selectLect(Vs,[10,12],E),
    selectLect(Vs,[19],F),
    selectLect(Vs,[13,14,15],G),
    selectLect(Vs,[2,7],H),
    selectLect(Vs,[11,17],I),
    nonOverlapping(A),nonOverlapping(B),
    nonOverlapping(C),nonOverlapping(D),
    nonOverlapping(E),nonOverlapping(F),
    nonOverlapping(G),nonOverlapping(H),
    nonOverlapping(I),
    maxTwoPerDay(A),maxTwoPerDay(B),maxTwoPerDay(C),
    maxTwoPerDay(D),maxTwoPerDay(E),maxTwoPerDay(F),
    maxTwoPerDay(G),maxTwoPerDay(H),maxTwoPerDay(I),
    putRooms(Vs,Rooms,VRs),
    nonOverLappingRooms(VRs). 