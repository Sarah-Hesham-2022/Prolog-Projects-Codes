diff(plus(A,B), X, plus(DA, DB)):-
 diff(A, X, DA),
 diff(B, X, DB).

diff(times(A,B), X, plus(times(A, DB), times(DA, B))):-
 diff(A, X, DA),
 diff(B, X, DB).

diff(X, X, 1).

diff(Y, X, 0):-
\+(X=Y). %Y is constant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Controlling Backtracking
myMember(X,[X|_]):-!.
myMember(X,[_|T]):-
 myMember(X,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myPower(X,1,X):-!.
myPower(_,0,1):-!.
myPower(X,P,R):-
 NewP is P-1,
 myPower(X,NewP,NewR),
 R is NewR*X.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
remove_duplicates([], []).
remove_duplicates([Head|Tail],Result):-
	member(Head,Tail),!,
	remove_duplicates(Tail,Result).
remove_duplicates([Head|Tail],[Head|Result]):-
	remove_duplicates(Tail,Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myAppend([],[],[]):-!.
myAppend([],T,T):-!.
myAppend(T,[],T):-!.
myAppend([H|T],T2,[H|NewT]):-
 myAppend(T,T2,NewT).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addElem(X,[],[X]).
addElem(X,L,R):-
 not(member(X,L)),!,
 myAppend([X],L,R).
addElem(_,L,L).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Way Way smarter than me, MSA :)
myAdd(E,L,L):-
	myMember(E,L),!.
myAdd(E,L,[E|L]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% when ! is removed you get true but
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rather than that you get false always
a(_):-!,fail.
a(_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myPartition(_,[],[],[]):-!.
myPartition(P,[H|T],[H|T2],L3):-
	H < P,!,
	myPartition(P,T,T2,L3).
myPartition(P,[H|T],L2,[H|T3]):-
	myPartition(P,T,L2,T3).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isDivisble(_,1):-!.
isDivisble(0,_):-!.
isDivisible(_,0):-!,fail.
isDivisible(N,D):-
  0 is N mod  D,!.
isDivisible(_,_):-fail.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

result([_, E | L], [E | M]) :- !,
result(L, M).
result(_, []).

max(X,Y,X) :- X >= Y, !.
max(_,Y,Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m(X,Y,X) :- X < Y.
m(X,Y,X) :- X1 is Y-X, m(X1,Y,_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f(0).
f(1) :- !.
f(2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myBetween(X,Y,X):-
 X=<Y.
myBetween(X,Y,R):-
 X<Y,
 NewX is X+1,
 myBetween(NewX,Y,R).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fact(1,1):-!.
fact(0,1):-!.
fact(N,R):-
 NewN is N-1,
 fact(NewN,NewR),
 R  is NewR*N.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
successor(2,1).
successor(3,2).
successor(4,3).
successor(5,4).
successor(6,5).
successor(7,6).
successor(8,7).
successor(9,8).

larger_digit(X,Y) :-
successor(X,Y).
larger_digit(X,Z) :-
successor(Y,Z),
larger_digit(X,Y).
