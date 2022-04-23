:- use_module(library(chr)).
:- use_module(library(clpfd)).

:-chr_constraint nonOverlapping(?any).
:-chr_constraint nonOverlapping(?any,?any,?any).

nonOverlapping(A) <=> nonOverlapping(A,[],[]).

nonOverlapping([H|T],[],[]) <=> nonOverlapping(T,[H],[]).
nonOverlapping([H|T],[H2|T2],R) <=> H #\= H2 | nonOverlapping([H|T],T2,[H2|R]).
nonOverlapping([H|_],[H2|_],_) <=> H #= H2 | false.
nonOverlapping([H|T],[],R) <=> nonOverlapping(T,[H|R],[]).
nonOverlapping([],_,_) <=> true.

:-chr_constraint minOneLecturePerDay(?any,?int).
:-chr_constraint minOneLecturePerDay_(?any,?int).
:-chr_constraint lectures(?any,?int).
:-chr_constraint lectureDay(?int,?int).
:-chr_constraint repeat(?any,?int).

%minOneLecturePerDay([],[],[]),lectureDay(A) <=> A #= 5 | true.

minOneLecturePerDay(X,ID) <=> minOneLecturePerDay_(X,ID), repeat(0,ID).

minOneLecturePerDay_([H|T],ID),repeat(A,ID1) <=> ID #= ID1 | New #= (H-1) // 3, A2 #= A +1, lectureDay(New,ID),minOneLecturePerDay_(T,ID),repeat(A2,ID).

minOneLecturePerDay_([],ID) <=> lectures([0,0,0,0,0],ID).

lectures([A,B,C,D,E],ID), lectureDay(Day,ID2),repeat(X,ID3) <=> Day #= 0, ID #=ID2 , ID2 #= ID3| NewA #= A +1 ,lectures([NewA,B,C,D,E],ID),A2 #= X -1, repeat(A2,ID).
lectures([A,B,C,D,E],ID), lectureDay(Day,ID2),repeat(X,ID3) <=> Day #= 1, ID #=ID2 , ID2 #= ID3| NewB #= B +1 ,lectures([A,NewB,C,D,E],ID),A2 #= X -1, repeat(A2,ID).
lectures([A,B,C,D,E],ID), lectureDay(Day,ID2),repeat(X,ID3) <=> Day #= 2, ID #=ID2 , ID2 #= ID3| NewC #= C +1 ,lectures([A,B,NewC,D,E],ID),A2 #= X -1, repeat(A2,ID).
lectures([A,B,C,D,E],ID), lectureDay(Day,ID2),repeat(X,ID3) <=> Day #= 3, ID #=ID2 , ID2 #= ID3| NewD #= D +1 ,lectures([A,B,C,NewD,E],ID),A2 #= X -1, repeat(A2,ID).
lectures([A,B,C,D,E],ID), lectureDay(Day,ID2),repeat(X,ID3) <=> Day #= 4, ID #=ID2 , ID2 #= ID3| NewE #= E +1 ,lectures([A,B,C,D,NewE],ID),A2 #= X -1, repeat(A2,ID).

lectures([A|_],ID),repeat(0,ID2) <=> A #= 0, ID #= ID2 | false.
lectures([A|T],ID),repeat(0,ID2) <=> A #\= 0, ID #= ID2 | lectures(T,ID),repeat(0,ID).
lectures([],ID),repeat(0,ID2) <=> ID #= ID2 | true.

:-chr_constraint maxTwoLecturesPerDay(?any,?int).
:-chr_constraint maxTwoLecturesPerDay_(?any,?int).
:-chr_constraint lectureDayDoz(?int,?int).
:-chr_constraint lecturesDoz(?any,?int).
:-chr_constraint repeatDoz(?any,?int).

maxTwoLecturesPerDay(X,ID) <=> maxTwoLecturesPerDay_(X,ID), repeatDoz(0,ID).

maxTwoLecturesPerDay_([H|T],ID),repeatDoz(A,ID2) <=> ID #= ID2 | New #= (H-1) // 3, A2 #= A +1, lectureDayDoz(New,ID),maxTwoLecturesPerDay_(T,ID),repeatDoz(A2,ID).

maxTwoLecturesPerDay_([],ID) <=> lecturesDoz([0,0,0,0,0],ID).

lecturesDoz([A,B,C,D,E],ID), lectureDayDoz(Day,ID2),repeatDoz(X,ID3) <=> Day #= 0, ID#= ID2, ID2 #= ID3 | NewA #= A +1 ,lecturesDoz([NewA,B,C,D,E],ID),A2 #= X -1, repeatDoz(A2,ID).
lecturesDoz([A,B,C,D,E],ID), lectureDayDoz(Day,ID2),repeatDoz(X,ID3) <=> Day #= 1, ID#= ID2, ID2 #= ID3 | NewB #= B +1 ,lecturesDoz([A,NewB,C,D,E],ID),A2 #= X -1, repeatDoz(A2,ID).
lecturesDoz([A,B,C,D,E],ID), lectureDayDoz(Day,ID2),repeatDoz(X,ID3) <=> Day #= 2, ID#= ID2, ID2 #= ID3 | NewC #= C +1 ,lecturesDoz([A,B,NewC,D,E],ID),A2 #= X -1, repeatDoz(A2,ID).
lecturesDoz([A,B,C,D,E],ID), lectureDayDoz(Day,ID2),repeatDoz(X,ID3) <=> Day #= 3, ID#= ID2, ID2 #= ID3 | NewD #= D +1 ,lecturesDoz([A,B,C,NewD,E],ID),A2 #= X -1, repeatDoz(A2,ID).
lecturesDoz([A,B,C,D,E],ID), lectureDayDoz(Day,ID2),repeatDoz(X,ID3) <=> Day #= 4, ID#= ID2, ID2 #= ID3 | NewE #= E +1 ,lecturesDoz([A,B,C,D,NewE],ID),A2 #= X -1, repeatDoz(A2,ID).

lecturesDoz([A|_],ID),repeatDoz(0,ID2) <=> A #> 2, ID #= ID2 | false.
lecturesDoz([A|T],ID),repeatDoz(0,ID2) <=> A #=< 2, ID #= ID2 | lecturesDoz(T,ID),repeatDoz(0,ID).
lecturesDoz([],ID),repeatDoz(0,ID2) <=> ID #= ID2 | true.

:-chr_constraint nonOverlappingRooms(?any,?any,?int).
:-chr_constraint lectureUnit(?int,?int,?int).



nonOverlappingRooms([H|T],[H2|T2],ID) <=> lectureUnit(H,H2,ID),nonOverlappingRooms(T,T2,ID).
nonOverlappingRooms([],[],_) <=> true.
nonOverlappingRooms([],[_|_],_) ==> false.
nonOverlappingRooms([_|_],[],_) ==> false.

lectureUnit(A,B,ID),lectureUnit(C,D,ID2) <=> A #= C, B #= D, ID #= ID2 | false.

lectureUnit(A,B,ID),lectureUnit(C,D,ID) ==> A #\=C ; B #\= D | true.

schedule(Subs,Rooms) :-
    Subs = [DB2,ITS,KI,LP,FP,ASWE,SV,DB1,TINF3,SWE,M2,P2,RA,BS,DT,TINF1,M1,P1,VLA,WE,BWL],
    Rooms = [R_DB2,R_ITS,R_KI,R_LP,R_FP,R_ASWE,R_SV,R_DB1,R_TINF3,R_SWE,R_M2,R_P2,R_RA,R_BS,R_DT,R_TINF1,R_M1,R_P1,R_VLA,R_WE,R_BWL],
    Subs ins 1..15,
    Rooms ins 1..5,
    Inf2019 = [DB2,ITS,KI,LP,FP,ASWE,SV],
    Inf2020 = [DB1,TINF3,SWE,M2,P2,RA,BS],
    Inf2021 = [DT,TINF1,M1,P1,VLA,WE,BWL] ,
    nonOverlapping(Inf2019), minOneLecturePerDay(Inf2019,2), 
    nonOverlapping(Inf2020), minOneLecturePerDay(Inf2020,4),
    nonOverlapping(Inf2021), minOneLecturePerDay(Inf2021,6),
    A=[DB1,DB2],
    B=[TINF1,KI,LP,ASWE],
    C=[FP,TINF3,P1],
    D=[WE,BWL],
    E=[SWE,P2],
    G=[RA,DT,BS],
    H=[ITS,SV],
    I=[M1,M2],
    nonOverlapping(A), maxTwoLecturesPerDay(A,8),
    nonOverlapping(B), maxTwoLecturesPerDay(B,10),
    nonOverlapping(C), maxTwoLecturesPerDay(C,12),
    nonOverlapping(D), maxTwoLecturesPerDay(D,14),
    nonOverlapping(E), maxTwoLecturesPerDay(E,16),
    nonOverlapping(G), maxTwoLecturesPerDay(G,18),
    nonOverlapping(H), maxTwoLecturesPerDay(H,20),
    nonOverlapping(I), maxTwoLecturesPerDay(I,22),
    nonOverlappingRooms(Subs,Rooms,23).