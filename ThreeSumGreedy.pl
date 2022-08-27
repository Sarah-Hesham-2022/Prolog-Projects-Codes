threeSum([H1,H2,H3|T],N,R):-
    threeSum([H1,H2,H3|T],[],N,R).

threeSum([H|T],VisitedList,N,R):-
    setof(OpenList,getNext([H|T],OpenList),OpenList),!,
    calcHeuristic(OpenList,N,Heuristic),
    getBestChild(Heuristic,Best),
    append(VisitedList,Best,NewVisitedList),
    removeDup(NewVisitedList,NewVisitedList2),
    threeSum(T,NewVisitedList2,N,R).

threeSum([_|T],Visited,N,R):-
  threeSum(T,Visited,N,R),!.

threeSum([],R,_,R):-
    not(R=[]),!.

getNext([H1,H2,H3|_],[H1,H2,H3]).

getNext([H1,H2,_|T],R):-
   getNext([H1,H2|T],R).

getNext([H1,_,H3|T],R):-
   getNext([H1,H3|T],R).

getNext([H1,_,_|T],R):-
   getNext([H1|T],R).

getHeuristic(State,N,H):-
    State=[H1,H2,H3],
    S is H1+H2+H3,
    H is abs(N-S).

calcHeuristic(L,N,R):-
    calcHeuristic(L,N,R,[]).

calcHeuristic([H|T],N,R,Heuristic):-
    getHeuristic(H,N,V),
    append(Heuristic,[[H,V]],New),
    calcHeuristic(T,N,R,New).

calcHeuristic([],_,R,R):-!.


getBestChild([],[]):-!.
getBestChild([[Children,V]|T],Best):-
    V =0,!,
    append([Children],New,Best),
    getBestChild(T,New).

getBestChild([_|T],B):-
    getBestChild(T,B).

removeDup([],[]).
removeDup([H|T],R):-
    member(H,T),
    !,
    removeDup(T,R).
removeDup([H|T],R):-
    R = [H|NewTail],
    removeDup(T,NewTail).
