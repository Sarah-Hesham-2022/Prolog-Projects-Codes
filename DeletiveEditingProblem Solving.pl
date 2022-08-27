isCommonElement(L,[H|_]):-
    member(H,L),!.

isCommonElement(L,[H|T]):-
    not(member(H,L)),!,
    isCommonElement(L,T).



myDelete([_|T],R):-
     R=T.


deletiveEditing(S,G):-
    deletiveEditing(S,G,G).

deletiveEditing([H|TW],[H|TG],G):-
    deletiveEditing(TW,TG,G),!.

deletiveEditing([HW|TW],[HG|TG],G):-
    myDelete([HW|TW],R),
    deletiveEditing(R,[HG|TG],G),!.


deletiveEditing(S,[],G):-
   not(isCommonElement(S,G)),!.




