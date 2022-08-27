clean(Open,Goal):-
   clean([Open],[],[Goal]).

clean(Open,Closed,Goal):-
    Open=[State|RestOfOpen],
    getAllValidChildren(State,Open,Closed,Children),
    append(RestOfOpen,Children,NewOpen), %We append the rest then the children as it is BFS ,in this line you can control the type of search of Prolog
    append(Closed,[State],NewClosed),
    clean(NewOpen,NewClosed,Goal).

clean(Goal,Closed,Goal):-
    write("Done"),
    nl,
    append(Closed,Goal,NewClosed),
    write(NewClosed).

getAllValidChildren(State,Open,Closed,Children):-
    findall(X,getNextState(State,Open,Closed,X),Children).

getNextState(State,Open,Closed,NextState):-
    move(State,NextState),
    not(member(NextState,Open)),
    not(member(NextState,Closed)),
    isOkay(NextState).

isOkay(_).

move([dirty,clean,1],[clean,clean,1]).
move([dirty,dirty,1],[clean,dirty,1]).
move([dirty,clean,2],[dirty,clean,1]).
move([dirty,dirty,2],[dirty,clean,2]).
move([clean,dirty,1],[clean,dirty,2]).
move([clean,dirty,2],[clean,clean,2]).
