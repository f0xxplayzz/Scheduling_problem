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

:-chr_constraint minOneLecturePerDay(?any).
:-chr_constraint minOneLecturePerDay_(?any).
:-chr_constraint lectures(?any).
:-chr_constraint lectureDay(?int).
:-chr_constraint repeat(?any).

%minOneLecturePerDay([],[],[]),lectureDay(A) <=> A #= 5 | true.

minOneLecturePerDay(X) <=> minOneLecturePerDay_(X), repeat(0).

minOneLecturePerDay_([H|T]),repeat(A) <=> true | New #= (H-1) // 3, A2 #= A +1, lectureDay(New),minOneLecturePerDay_(T),repeat(A2).

minOneLecturePerDay_([]) <=> lectures([0,0,0,0,0]).

lectures([A,B,C,D,E]), lectureDay(Day),repeat(X) <=> Day #= 0, true| NewA #= A +1 ,lectures([NewA,B,C,D,E]),A2 #= X -1, repeat().
lectures([A,B,C,D,E]), lectureDay(Day),repeat(X) <=> Day #= 1| NewB #= B +1 ,lectures([A,NewB,C,D,E]),A2 #= X -1, repeat(A2).
lectures([A,B,C,D,E]), lectureDay(Day),repeat(X) <=> Day #= 2| NewC #= C +1 ,lectures([A,B,NewC,D,E]),A2 #= X -1, repeat(A2).
lectures([A,B,C,D,E]), lectureDay(Day),repeat(X) <=> Day #= 3| NewD #= D +1 ,lectures([A,B,C,NewD,E]),A2 #= X -1, repeat(A2).
lectures([A,B,C,D,E]), lectureDay(Day),repeat(X) <=> Day #= 4| NewE #= E +1 ,lectures([A,B,C,D,NewE]),A2 #= X -1, repeat(A2).

lectures([A|_]),repeat(0) <=> A #= 0| false.
lectures([A|T]),repeat(0) <=> A #\= 0| lectures(T,ID),repeat(0,ID).
lectures([]),repeat(0) <=> true.

:-chr_constraint maxTwoLecturesPerDay(?any).
:-chr_constraint maxTwoLecturesPerDay_(?any).
:-chr_constraint lectureDayDoz(?int).
:-chr_constraint lecturesDoz(?any).
:-chr_constraint repeatDoz(?any).

maxTwoLecturesPerDay(X) <=> maxTwoLecturesPerDay_(X), repeatDoz(0).

maxTwoLecturesPerDay_([H|T]),repeatDoz(A) <=> true| New #= (H-1) // 3, A2 #= A +1, lectureDayDoz(New),maxTwoLecturesPerDay_(T),repeatDoz(A2).

maxTwoLecturesPerDay_([]) <=> lecturesDoz([0,0,0,0,0]).

lecturesDoz([A,B,C,D,E]), lectureDayDoz(Day),repeatDoz(X) <=> Day #= 0| NewA #= A +1 ,lecturesDoz([NewA,B,C,D,E]),A2 #= X -1, repeatDoz(A2).
lecturesDoz([A,B,C,D,E]), lectureDayDoz(Day),repeatDoz(X) <=> Day #= 1| NewB #= B +1 ,lecturesDoz([A,NewB,C,D,E]),A2 #= X -1, repeatDoz(A2).
lecturesDoz([A,B,C,D,E]), lectureDayDoz(Day),repeatDoz(X) <=> Day #= 2| NewC #= C +1 ,lecturesDoz([A,B,NewC,D,E]),A2 #= X -1, repeatDoz(A2).
lecturesDoz([A,B,C,D,E]), lectureDayDoz(Day),repeatDoz(X) <=> Day #= 3| NewD #= D +1 ,lecturesDoz([A,B,C,NewD,E]),A2 #= X -1, repeatDoz(A2).
lecturesDoz([A,B,C,D,E]), lectureDayDoz(Day),repeatDoz(X) <=> Day #= 4| NewE #= E +1 ,lecturesDoz([A,B,C,D,NewE]),A2 #= X -1, repeatDoz(A2).

lecturesDoz([A|_]),repeatDoz(0) <=> A #> 2| false.
lecturesDoz([A|T]),repeatDoz(0) <=> A #=< 2 | lecturesDoz(T),repeatDoz(0).
lecturesDoz([]),repeatDoz(0) <=> true.

:-chr_constraint nonOverlappingRooms(?any,?any).
:-chr_constraint lectureUnit(?int,?int).



nonOverlappingRooms([H|T],[H2|T2]) <=> lectureUnit(H,H2),nonOverlappingRooms(T,T2).
nonOverlappingRooms([],[]) <=> true.
nonOverlappingRooms([],[_|_]) ==> false.
nonOverlappingRooms([_|_],[]) ==> false.

lectureUnit(A,B),lectureUnit(C,D) <=> A #= C, B #= D| false.

lectureUnit(A,B),lectureUnit(C,D) ==> A #\=C ; B #\= D | true.

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