valuable(gold).
gives(john,book,mary).
female(sarah).
female(farah).
female(mary).
male(carl).
male(john).
likes(john,mary).
likes(john,gold).
likes(mary,gold).
likes(mary,carl).
likes(john,carl).
likes(mary,X):-likes(john,X).
grandfather(john,Y):-mother(mary,Y).
owns(mary,book(love,givenby(father))).
parent(john,mary).
parent(mary,carl).
parent(mary,sarah).
parent(mary,farah).
parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jam).
offspring(X,Y):-parent(Y,X).
grandparent(X,Y):-parent(X,Z),parent(Z,Y).
predecessor(X,Y):-parent(X,Y).
predecessor(X,Y):-(parent(X,Z),predecessor(Z,Y)).
father(X,Y):-parent(X,Y),male(X).
mother(X,Y):-parent(X,Y),female(X).
brother(X,Y):-parent(Z,X),parent(Z,Y),male(X),X\==Y.
sister(X,Y):-parent(Z,X),parent(Z,Y),female(X),X\==Y.
big(bear).
big(elephant).
small(cat).
brown(bear).
black(cat).
gray(elephant).
dark(Z):-black(Z).
dark(Z):-brown(Z).
even(X):- X mod 2 =:=0.
odd(X):- X mod 2 =\=0.








