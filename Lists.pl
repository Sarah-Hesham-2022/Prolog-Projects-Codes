present(X,[X|_]).
present(X,[_|T]):-present(X,T).

lengthlist([],0).
lengthlist([_|T],R):-
    lengthlist(T,NewR),
    R is NewR+1.

sum([],0).
sum([H|T],R):-
    sum(T,NewR),
    R is NewR+H.

sorted([]).
sorted([_]).
sorted([H,Y|T]):-
    H =< Y,
    sorted(T).

myappend([],T2,T2).
myappend([H|T], L2, [H|NT]):-
	myappend(T, L2, NT).


lengthacc(T,R):-mylength(T,R,0).
mylength([],R,R).
mylength([_|T],R,A):-
    NewA is A+1,
    mylength(T,R,NewA).

suffix( Suffixed, List):-
	myappend( _, Suffixed, List).


prefix(Prefixed,List):-
    myappend(Prefixed,_,List).

mylast(X,[X]).
mylast(X,[_|T]):-
    mylast(X,T).

lastt( Element, List):-
	append( _, [Element], List).

adddone([],[]).
adddone([H1|T1],[H2|T2]):-
    H1 =:= H2-1,
    adddone(T1,T2).


adjacent(X,Y,[X,Y|_]).
adjacent(X,Y,[_,H|T]):-
    adjacent(X,Y,[H|T]).


