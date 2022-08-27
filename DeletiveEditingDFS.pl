deletiveEditing(G,G):-!.

deletiveEditing(L,G):-
    nextState(L,G,R),
    getChildren(R,G),!.


nextState([],_,[]):-!.
nextState([H|L],G,R):-
    member(H,G),!,
    R=[H|NewR],
    nextState(L,G,NewR).


nextState([_|L],G,R):-
    nextState(L,G,R).

myDelete([C|T],R):-
     member(C,T),!,
     R=T.
myDelete([H|T],R):-
    R=[H|NewR],
    myDelete(T,NewR).

getChildren([],[]):-!.
getChildren([H|T1],[H|T2]):-
       getChildren(T1,T2),!.
getChildren([H1|T1],[H2|T2]):-
    myDelete([H1|T1],R),
    getChildren(R,[H2|T2]).

