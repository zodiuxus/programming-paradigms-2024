% Zadacha 1
dolzina([], 0).
dolzina([A|O], N):-dolzina(O, N1), N is N1+1.

neparen(L):-dolzina(L,N), N mod 2 =:= 1. 

dodadi([], L, L).
dodadi([X|O], L, [X|NL]):-dodadi(O, L, NL).

prevrti([], []).
prevrti([X|L1], L2):-prevrti(L1, L), dodadi(L,[X],L2).
palindrom(L):-prevrti(L, L1), L1 = L.

neparen_palindrom(L):-neparen(L), palindrom(L).

% Zadacha 2
podlista([X|L1], [X|L2]):-prefiks(L1, L2).
podlista(L1, [_|L2]):-podlista(L1, L2),!.
prefiks([], _):-!.
prefiks([x|L1], [X|L2]):-prefiks(L1, L2).

broj_pojav([],X,0).


naj_podniza(L1, N, L2):-podlista(L1, N, L2).

% Zadacha 3

parovi([_], N).
parovi([X, Y|R], N):-N=0, Y>X, C is N+1, parovi([Y|R], C).
parovi([X, Y|R], N):-N=1, X>Y, C is N-1, parovi([Y|R], C).

prov_parovi([X, Y]):-Y>X.
prov_parovi(L):-N is 0, parovi(L, N).

proveri(L):-dolzina(L, N), N >= 2, prov_parovi(L).

% Zadacha 4


