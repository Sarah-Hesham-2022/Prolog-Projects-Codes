clean(Open,Goal):-
   append(Open,[start],NewOpen),
   append(Goal,_,NewGoal),
   clean([NewOpen],[],[NewGoal]).

clean(Goal,Closed,Goal):-
    write("Done"),!,
    nl,
    append(Closed,Goal,NewClosed),
    getMoves(NewClosed,[],Moves),
    append(Moves,[stop],NewMoves),
    write(NewMoves).

clean(Open,Closed,Goal):-
    Open=[State|RestOfOpen],
    getAllValidChildren(State,Open,Closed,Children),
    append(RestOfOpen,Children,NewOpen), %We append the rest then the children as it is BFS ,in this line you can control the type of search of Prolog
    append(Closed,[State],NewClosed),
    clean(NewOpen,NewClosed,Goal).

getAllValidChildren(State,Open,Closed,Children):-
    findall(X,getNextState(State,Open,Closed,X),Children).

getNextState(State,Open,Closed,NextState):-
    move(State,NextState),
    not(member(NextState,Open)),
    not(member(NextState,Closed)),
    isOkay(NextState).

isOkay(_).

move([dirty,clean,1,_],[clean,clean,1,clean1]).
move([dirty,dirty,1,_],[clean,dirty,1,clean1]).
move([dirty,clean,2,_],[dirty,clean,1,move1]).
move([dirty,dirty,2,_],[dirty,clean,2,clean2]).
move([clean,dirty,1,_],[clean,dirty,2,move2]).
move([clean,dirty,2,_],[clean,clean,2,clean2]).

getMoves([List|Tail],NewList,Final):-
   List=[_,_,_,T],
   append(NewList,[T],New),
   getMoves(Tail,New,Final).
getMoves([],R,R).
