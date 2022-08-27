% Query ?- search([[[b,d,c,a,'-',e,g,h,f],null]], [], [a,b,c,d,e,f,g,h,'-']).

printSolution([State,null],_):- write(State), nl, !.
printSolution([State,Parent],Closed):-
	member([Parent, GrandParent], Closed),
	printSolution([Parent, GrandParent], Closed), !,
	write(State), nl.

search(Open,Goal):-
	search([[Open,null]],[],Goal).
search(Open, Closed, Goal):-
	Open = [[State,Parent]|_],
	State = Goal, !,
	write('Done'), nl, printSolution([State,Parent],Closed).

search(Open, Closed, Goal):-
	Open = [[State,Parent]|RestOfOpen],
	getAllValidChildren(State, Open, Closed, Children),
	append(RestOfOpen, Children, NewOpen), %BFS
	append([[State, Parent]], Closed, NewClosed),
	search(NewOpen, NewClosed, Goal).

getAllValidChildren(State, Open, Closed, Children):-
	findall(X, getNextState(State, Open, Closed, X), Children).

getNextState(State, Open, Closed, [NextState, State]):-
	move(State, NextState),
	not(member([NextState,_], Open)),
	not(member([NextState,_], Closed)),
	isOkay(NextState).

% Representation [a,b,c,d,e,f,g,h,'-'] (goal)
% Moves: blank up, down, left, right
% Rules: No rules

isOkay(_).

move(State, NextState):-
	up(State, NextState) ; down(State, NextState) ;
	left(State, NextState) ; right(State, NextState).

up(State, NextState):-
	%State = [X0, X1, X2, X3, X4, X5, X6, X7, X8],
	nth0(BlankIndex, State, '-'),
	BlankIndex > 2,
	NewIndex is BlankIndex - 3,
	nth0(NewIndex, State, Element),
	%swap
	substitute('-', State, x, TmpList1),
	substitute(Element, TmpList1, '-', TmpList2),
	substitute(x, TmpList2, Element, NextState).

down(State, NextState):-
	%State = [X0, X1, X2, X3, X4, X5, X6, X7, X8],
	nth0(BlankIndex, State, '-'),
	BlankIndex < 6,
	NewIndex is BlankIndex + 3,
	nth0(NewIndex, State, Element),
	%swap
	substitute('-', State, x, TmpList1),
	substitute(Element, TmpList1, '-', TmpList2),
	substitute(x, TmpList2, Element, NextState).

left(State, NextState):-
	%State = [X0, X1, X2, X3, X4, X5, X6, X7, X8],
	nth0(BlankIndex, State, '-'),
	not(0 is BlankIndex mod 3),
	NewIndex is BlankIndex - 1,
	nth0(NewIndex, State, Element),
	%swap
	substitute('-', State, x, TmpList1),
	substitute(Element, TmpList1, '-', TmpList2),
	substitute(x, TmpList2, Element, NextState).

right(State, NextState):-
	%State = [X0, X1, X2, X3, X4, X5, X6, X7, X8],
	nth0(BlankIndex, State, '-'),
	2 =\= BlankIndex mod 3,
	NewIndex is BlankIndex + 1,
	nth0(NewIndex, State, Element),
	%swap
	substitute('-', State, x, TmpList1),
	substitute(Element, TmpList1, '-', TmpList2),
	substitute(x, TmpList2, Element, NextState).

substitute(Old, [Old|T], New, [New|T]):- !.
substitute(Old, [H|T], New, [H|NewT]):-
	substitute(Old, T, New, NewT).



