%The colors in the problem specified
colors([blue,red,yellow,green]).

%The adjacent countries
adjacent(1,[2,3,5,6]).
adjacent(2,[1,3,4,5,6]).
adjacent(3, [1,2,4,6]).
adjacent(4, [2,3]).
adjacent(5,[1,2,6]).
adjacent(6,[1,2,3,5]).

mapColoring(N, Solution):-
    generateVariables(N, Variables),
    colors(X),
    generateDomains(N, X, Domains),
    solveFC(Variables, Domains, Solution),!.

generateVariables(0,[]):-!.
generateVariables(N, Variables):-
    N > 0,
    NewN is N-1,
    generateVariables(NewN, TmpVariables),
    append(TmpVariables, [N], Variables).

generateDomains(0,_,[]):-!.
generateDomains(N,Variables,Domains):-
    NewN is N-1,
    generateDomains(NewN,Variables,NewDomains),
    append([Variables],NewDomains,Domains).

solveFC([], _, []):-!.
solveFC([Var|RestOfVars], [Domain|RestOfDomains], [Result|RestOfSol]):-
    member(X, Domain),
    Result = [Var, X],
    propagateConstraints(Result, RestOfVars, RestOfDomains, NewDomains),
    solveFC(RestOfVars, NewDomains, RestOfSol).

propagateConstraints(_, [], _, []):- !.
propagateConstraints(AssignedVar, [Var|T1], [Domain|T2], [NewDomain|T3]):-
    propagateForVar(AssignedVar, Var, Domain, NewDomain),
    NewDomain \=[],
    propagateConstraints(AssignedVar, T1, T2, T3).

%Check if adjacent ,don't use color
propagateForVar([OldCountry,OldColor], Var, Domain, NewDomain):-
    adjacent(Var,L),
    member(OldCountry,L),!,
    delete(Domain,OldColor,NewDomain).

%If not adjacent, use the color
propagateForVar(_, _, Domain, Domain).

