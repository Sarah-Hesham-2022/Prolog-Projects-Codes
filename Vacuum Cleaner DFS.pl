clean(CurrentState,Goal):-
    clean(CurrentState,Goal,[CurrentState]).

clean(CurrentState,Goal,VisitedList):-
    move(CurrentState,NextState),
    not(member(NextState,VisitedList)),
    isOkay(NextState),
    append(VisitedList,[NextState],NewVisitedList),
    clean(NextState,Goal,NewVisitedList).


clean(Goal,Goal,Visited):-
   write("Done"),
   nl,
   write(Visited),!.

move([dirty,clean,1],[clean,clean,1]).
move([dirty,dirty,1],[clean,dirty,1]).
move([dirty,clean,2],[dirty,clean,1]).
move([dirty,dirty,2],[dirty,clean,2]).
move([clean,dirty,1],[clean,dirty,2]).
move([clean,dirty,2],[clean,clean,2]).

isOkay(_).
