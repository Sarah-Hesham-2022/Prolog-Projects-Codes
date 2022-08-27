%Tail Recusrion

listSlice1(L,[Index,Count],R):-
    listSlice1(L,[Index,Count],0,R).

listSlice1(L,[Index,Count],I,R):-
    I = Index,!,
    listSlice1(L,[Index,Count],I,0,R,[]).

listSlice1([_|T],[Index,Count],I,R):-
    NewI is I+1,
    listSlice1(T,[Index,Count],NewI,R).

listSlice1(_,[_,Count],_,Count,R,R):-!.

listSlice1([H|T],[Index,Count],I,C,R,F):-
    NewC is C+1,
    append(F,[H],NewF),
    listSlice1(T,[Index,Count],I,NewC,R,NewF).

%Head Recursion

listSlice2([_|T],[Index,Count],R):-
    NewIndex is Index-1,
    NewIndex >=0,!,
    listSlice2(T,[NewIndex,Count],R).

listSlice2([H|T],[Index,Count],[H|R]):-
    NewCount is Count-1,
    NewCount >=0,!,
    listSlice2(T,[Index,NewCount],R).

listSlice2(_,[0,0],[]):-!.
