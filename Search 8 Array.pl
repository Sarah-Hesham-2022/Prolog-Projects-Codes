% Query ?- go([2,4,3,1,0,5,7,8,6],[1,2,3,4,5,6,7,8,0]).
substitute(_,[],_, []).
substitute(O,[O|T],R,[R|T2]) :- substitute(O,T,R, T2).
substitute(O,[H|T],R, [H|T2]) :- H \= O, substitute(O,T,R, T2).


move(S,Snew):-
	up(S,Snew).
move(S,Snew):-
	down(S,Snew).
move(S,Snew):-
	left(S,Snew).
move(S,Snew):-
	right(S,Snew).
up([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R1>0,
	R2>0,
	R3>0,
	blank_up([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_up([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
% get position of blank cell
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N-3,
% get element in pos Z
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
%substitute element of pos Z with blank cell “0”
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).


%Rule 2: Moving blank cell down
down([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R7>0,
	R8>0,
	R9>0,
	blank_down([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_down([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N+3,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

%Rule 3: Moving blank cell left

left([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R1>0,
	R4>0,
	R7>0,
	blank_left([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_left([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N-1,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

%Rule 4: Moving blank cell right.

right([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R3>0,
	R6>0,
	R9>0,
	blank_right([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_right([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N+1,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

%Step#3:  Implement the search program

go(Start,Goal):-
		path([[Start,null]],[],Goal).


path([],_,_):-
		write('No solution'),nl,!.
path([[Goal,Parent] | _], Closed, Goal):-
		write('A solution is found'), nl ,
		printsolution([Goal,Parent],Closed),!.
path(Open, Closed, Goal):-
		removeFromOpen(Open, [State, Parent], RestOfOpen),
		getchildren(State, Open, Closed, Children),
		addListToOpen(Children , RestOfOpen, NewOpen),
		path(NewOpen, [[State, Parent] | Closed], Goal).


getchildren(State, Open ,Closed , Children):-
		bagof(X, moves( State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).


addListToOpen(Children,[],Children).
addListToOpen(L, [H|Open], [H|NewOpen]):-
		addListToOpen(L, Open, NewOpen).


removeFromOpen([State|RestOpen], State, RestOpen).


moves( State, Open, Closed,[Next,State]):-
		move(State,Next),
		\+ member([Next,_],Open),
		\+ member([Next,_],Closed).

printsolution([State, null],_):-
		write(State),nl.
printsolution([State, Parent], Closed):-
		member([Parent, GrandParent], Closed),
		printsolution([Parent, GrandParent], Closed),
		write(State), nl.


