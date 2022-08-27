power(X,1,X).

%Power with exponent minus
power(X,N,R):-
    NewN is N-1,
    power(X,NewN,NewR),
    R is NewR*X.

%If the power was even division
power(X, Y, Output):-
   0 is Y mod 2,
   Y2 is div(Y,2),
   power(X, Y2, Output2),
   Output is Output2 * Output2.

% If the power was odd division
power(X, Y, Output):-
  Y2 is div(Y,2),
  power(X, Y2, Output2),
  Output is X * Output2 * Output2.


%s(s(s(s(0))))
isS(0).
isS(s(X)):-
    isS(X).

%Fcatorial with normal recursion
factorial(1,1).
factorial(0,1).
factorial(X,R):-
    NewX is X-1,
    factorial(NewX,NewR),
    R is X*NewR.

%Factorial program re-written using tail recursion
factorial(N,Result) :- fact_iter(N,1,Result).
fact_iter(0,Result,Result).
fact_iter(N,Acc,Result) :-
  NewN is N-1,
  NewAcc is N *Acc,
  fact_iter(NewN,NewAcc,Result).


%Sum from 1 to N with normal recursion
sum(1,1).
sum(0,0).
sum(N,R):-
    NewN is N-1,
    sum(NewN,NewR),
    R is NewR+N.

%Sum from 1 to N with tail recursion
sumtail(N,R):-mysum(N,R,0).
mysum(0,R,R).
mysum(N,R,A):-
    NewN is N-1,
    NewA is A+N,
    mysum(NewN,R,NewA).







