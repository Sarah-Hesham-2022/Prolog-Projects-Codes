nQueens(N, Solution):-
    generateVariables(N, Variables),
    generateDomains(N, Variables, Domains),
    solveFC(Variables, Domains, Solution),!.

generateDomains(0, _ , []):- !.
generateDomains(N, DomainVariable, [DomainVariable|T]) :-
	NewN is N-1,
	generateDomains(NewN, DomainVariable, T).

generateVariables(0,[]):- !.
generateVariables(N, Variables):-
    N > 0,
    NewN is N-1,
    generateVariables(NewN, TmpVariables),
    append(TmpVariables, [N], Variables).


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

propagateForVar([PreVar,Value], Var, Domain, NewDomain):-
	delete(Domain,Value,TmpDomain),
        Diff is PreVar - Var,
        InvalidValue1 is Value - Diff,
        InvalidValue2 is Value + Diff,
        delete(TmpDomain,InvalidValue1,TmpDomain2),
        delete(TmpDomain2,InvalidValue2,NewDomain).

