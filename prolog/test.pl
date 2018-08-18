likes(shehroz, football).
likes(arif, football).
likes(yasir, cricket).
friends(X,Y) :- likes(X, Z), likes(Y, Z).
