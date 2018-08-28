/*
Predicates can be defined recursively.
A predicate is recursively defined
if one or more rules in its definition refers to itself.
*/

descend(X,Y) :- child(X, Y).
descend(X,Y) :- child(X, Z), child(Z,Y).
child(ibrahim, ismail).
child(ibrahim, ishaq).
child(ishaq, yaqub).
child(yaqub, yusuf).
child(yaqub, binyamin).
child(binyamin, abumata).
child(abumata, matta).
child(matta, yunus).
