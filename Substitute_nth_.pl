substitute(X,L,Y,R):-
    substitute(X,L,Y,[],R).

substitute(X,[H|T],Y,R,F):-
    H==X,
    myAppend(R,[Y],NewR),
    substitute(X,T,Y,NewR,F).

substitute(X,[H|T],Y,R,F):-
    myAppend(R,[H],NewR),
    substitute(X,T,Y,NewR,F).

substitute(_,[],_,R,R).

myAppend([],R,R).

myAppend([H|T],T2,[H|T3]):-
    myAppend(T,T2,T3).

nth(0,[Element|_], Element):- !.
nth(Index,[_|Tail],Element):-
  nth(Index1,Tail, Element),
  !,
  Index is Index1+1.

replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).
