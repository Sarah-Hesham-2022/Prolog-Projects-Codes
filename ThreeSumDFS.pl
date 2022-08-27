threeSum([H1,H2,H3|T],N,R):-
    threeSum([H1,H2,H3|T],[],N,R).

threeSum([H|T],VisitedList,N,R):-
    setof(NextState,getNext([H|T],NextState,N),NextState),!,
    append(VisitedList,NextState,NewVisitedList),
    threeSum(T,NewVisitedList,N,R).

threeSum([_|T],Visited,N,R):-
    threeSum(T,Visited,N,R).

threeSum([],R,_,R):-
    not(R=[]),!.

getNext([H1,H2,H3|_],[H1,H2,H3],N):-
    isGoal([H1,H2,H3],N),!.

getNext([H1,H2,_|T],R,N):-
   getNext([H1,H2|T],R,N).

getNext([H1,_,H3|T],R,N):-
   getNext([H1,H3|T],R,N).

getNext([H1,_,_|T],R,N):-
   getNext([H1|T],R,N).

isGoal([H1,H2,H3],N):-
    N is H1+H2+H3 ,!.
