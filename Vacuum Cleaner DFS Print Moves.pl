clean(CurrentState,Goal):-
    clean(CurrentState,Goal,[CurrentState],[]).

clean(CurrentState,Goal,VisitedList,Moves):-
    move(CurrentState,NextState,CurrentMove),
    not(member(NextState,VisitedList)),
    isOkay(NextState),
    append(VisitedList,[NextState],NewVisitedList),
    append(Moves,CurrentMove,NewMoves),
    clean(NextState,Goal,NewVisitedList,NewMoves).


clean(Goal,Goal,Visited,Moves):-
   write("Done"),
   nl,
   write(Visited),
   nl,
   write(Moves),!.

move([dirty,clean,1],[clean,clean,1],[clean1]).
move([dirty,dirty,1],[clean,dirty,1],[clean1]).
move([dirty,clean,2],[dirty,clean,1],[move1]).
move([dirty,dirty,2],[dirty,clean,2],[clean2]).
move([clean,dirty,1],[clean,dirty,2],[move2]).
move([clean,dirty,2],[clean,clean,2],[clean2]).

isOkay(_).

