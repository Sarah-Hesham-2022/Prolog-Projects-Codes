%Head Recursion
index1(0,[H|_],H):-!.

index1(I,[_|T],E):-
    NewI is I-1,
    index1(NewI,T,E).

%Tail Recursion
index2(0,[H|_],H):-!.

index2(I,L,E):-
    index2(I,L,E,0).

index2(I,[H|_],H,I):-!.

index2(I,[_|T],E,C):-
    NewC is C+1,
    index2(I,T,E,NewC).

%Tail Recursion
removeDup1(L,R):-
    removeDup1(L,R,[]).

removeDup1([],R,R):-!.

removeDup1([H|T],R,F):-
    not(member(H,T)),!,
    append(F,[H],NewF),
    removeDup1(T,R,NewF).
removeDup1([H|T],R,F):-
    member(H,T),!,
    removeDup1(T,R,F).

%Head Recursion
removeDup2([],[]).
removeDup2([H|T],R):-
    member(H,T),
    !,
    removeDup2(T,R).
removeDup2([H|T],R):-
    R = [H|NewTail],
    removeDup2(T,NewTail).

%Head Recursion
mypartition1(_,[],[],[]):-!.

mypartition1(N,[H|T],L1,L2):-
    H < N,!,
    L1 =[H|L1Tail],
    mypartition1(N,T,L1Tail,L2).

mypartition1(N,[H|T],L1,L2):-
    L2=[H|L2Tail],
    mypartition1(N,T,L1,L2Tail).

%Tail Recursion
mypartition2(N,L,L1,L2):-
    mypartition2(N,L,L1,L2,[],[]).

mypartition2(_,[],L1,L2,L1,L2):-!.

mypartition2(N,[H|T],L1,L2,LF1,LF2):-
    H < N,!,
    append(LF1,[H],NewF1),
    mypartition2(N,T,L1,L2,NewF1,LF2).

mypartition2(N,[H|T],L1,L2,LF1,LF2):-
    append(LF2,[H],NewF2),
    mypartition2(N,T,L1,L2,LF1,NewF2).


%Head Recursion
%substitute(+OldElem, +List, +NewElem, -NewList)

mySubst1(_,[],_,[]):-!.

mySubst1(X,[X|T],NewX,[NewX|NewR]):-
    mySubst1(X,T,NewX,NewR),!.

mySubst1(X,[H|T],NewX,[H|NewR]):-
    mySubst1(X,T,NewX,NewR).

%Tail Recursion
mySubst2(X,L,NewX,R):-
    mySubst2(X,L,NewX,R,[]).

mySubst2(X,[X|T],NewX,R,F):-
    append(F,[NewX],NewF),!,
    mySubst2(X,T,NewX,R,NewF).

mySubst2(X,[H|T],NewX,R,F):-
      append(F,[H],NewF),!,
      mySubst2(X,T,NewX,R,NewF).

mySubst2(_,[],_,R,R):-!.
