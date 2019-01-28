%Patrick Quan - 10152770
%CPSC 449
%Assignment 4


%Question 1
mother(denise, anna). %Grandma = Denise, mother = Anna
mother(denise, ester). %Grandma = Dense, Mother = Ester
mother(anna, beth). %Mother = Anna, Daughter = Beth
mother(anna, cindy). %Mother = Anna, Daughter = Cindy
mother(ester, fran). %Mother = Ester, Daughter = Fran


sister(X, Y) :- mother(Z, X), mother(Z, Y), \+(X = Y).
cousin(X, Y) :- mother(Z, X), mother(W, Y), sister(Z, W).
granddaughter(X, Y) :- mother(Z, X), mother(Y, Z).
descendent(X, Y) :- mother(Y, X).
descendent(X, Y) :- mother(Z, X), descendent(Z, Y).

%Question 2
member_new(X, [X | _]).
member_new(X, [Y | Z]) :-
  member_new(X, Z).


%Question 3
subset_new([], []).
subset_new([X | Y], [X | Z]) :-
  subset_new(Y, Z).
subset_new(X, [_ | Y]) :-
  subset_new(X, Y).


%Question 4
disjoint([], _).
disjoint([X | Y], Z) :-
  \+(member_new(X, Z)),
  disjoint(Y, Z).


%Question 5
union_new(X, Y, Z) :-
  append(X, Y, Z).


%Question 6
intersection_new([], _, []).
intersection_new([X | Y], Z, A) :-
  \+(member_new(X, Z)),
  intersection_new(Y, Z, A).
intersection_new([X | Y], Z, [X | A]) :-
  (member_new(X, Z)),
  intersection_new(Y, Z, A).


%Question 7
difference([], _, []).
difference([X | Y], Z, A) :-
  member_new(X, Z),
  difference(Y, Z, A).
difference([X | Y], Z, [X | A]) :-
  \+(member_new(X, Z)),
  difference(Y, Z, A).


%Question 8
occurrences(_, [], 0).
occurrences(X, [X | Y], Z) :-
  occurrences(X, Y, A),
  Z is A + 1.
occurrences(X, [Y | Z], A) :-
  \+(X = Y),
  occurrences(X, Z, A).


%Question 9
quicksort([],[]).
quicksort([X | Y], Z) :-
  split(X, Y, Y1, Y2),
  quicksort(Y1, Z1),
  quicksort(Y2, Z2),
  append(Z1, [X | Z2], Z).

split(_, [], [], []).
  split(X, [Y  |Z], A, [Y | B]) :-
    X < Y,
    split(X, Z, A, B).
  split(X, [Y | Z], [Y | A] ,B) :-
  X >= Y,
  split(X, Z, A, B).


%Question 10
edge(1, 2).
edge(1, 4).
edge(1, 3).
edge(2, 3).
edge(2, 5).
edge(3, 4).
edge(3, 5).
edge(4, 5).

path(X, Y, Z) :-
  pathRec(X, Y, [Y], Z).
pathRec(X, Y, A, [X | A]) :-
  edge(X, Y);
  edge(Y, X).
pathRec(X, Y, A, Z) :-
  edge(B, Y),
  \+(member_new(B, A)),
  pathRec(X, B, [B | A], Z).
