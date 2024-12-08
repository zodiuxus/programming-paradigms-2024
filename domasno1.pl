% Zadacha 1
dolzina([], 0).
dolzina([_|O], N):-dolzina(O, N1), N is N1+1.

neparen(L):-dolzina(L,N), N mod 2 =:= 1. 

dodadi([], L, L).
dodadi([X|O], L, [X|NL]):-dodadi(O, L, NL).

prevrti([], []).
prevrti([X|L1], L2):-prevrti(L1, L), dodadi(L,[X],L2).
palindrom(L):-prevrti(L, L1), L1 = L.

neparen_palindrom(L):-neparen(L), palindrom(L).

% Zadacha 3

parovi([_], N).
parovi([X, Y|R], N):-N=0, Y>X, C is N+1, parovi([Y|R], C).
parovi([X, Y|R], N):-N=1, X>Y, C is N-1, parovi([Y|R], C).

prov_parovi([X, Y]):-Y>X.
prov_parovi(L):-N is 0, parovi(L, N).

proveri(L):-dolzina(L, N), N >= 2, prov_parovi(L).

% Zadacha 4

izberi_perm(X, [X|R], R).
izberi_perm(X, [Prv|Opa], [Prv|Ost]):- izberi_perm(X, Opa, Ost).

permutacii([], []).
permutacii(L1, [X|L2]):- izberi_perm(X, L1, O), permutacii(O, L2).

% Zadacha 5

bin_dec([], 0).
bin_dec([Bit|Ost], Dec):- bin_dec(Ost, OstDec), length(Ost, Stepen), Dec is Bit*2^Stepen+OstDec.

dec_bin(Dec, Bin):- dec_bin(Dec, [], Bin).
dec_bin(0, Temp, [0|Temp]).
dec_bin(1, Temp, [1|Temp]).
dec_bin(Dec, Temp, Bin):-
  Dec > 1, 
  Ost is Dec // 2, 
  Bit is Dec mod 2, 
  dec_bin(Ost, [Bit|Temp], Bin).

sobiranje(Bin1, Bin2, Rezultat) :-
    bin_dec(Bin1, Dec1),
    bin_dec(Bin2, Dec2),
    Sum is Dec1 + Dec2,
    dec_bin(Sum, Rezultat).

mnozhenje(Bin1, Bin2, Rezultat) :-
    bin_dec(Bin1, Dec1),
    bin_dec(Bin2, Dec2),
    Proizvod is Dec1 * Dec2,
    dec_bin(Proizvod, Rezultat).

odzemanje(Bin1, Bin2, Rezultat) :-
    bin_dec(Bin1, Dec1),
    bin_dec(Bin2, Dec2),
    Razlika is Dec1 - Dec2,
    (   Razlika < 0
    ->  Rezultat = [0]
    ;   dec_bin(Razlika, Rezultat)
    ).

delenje(Bin1, Bin2, Rezultat) :-
    bin_dec(Bin1, Dec1),
    bin_dec(Bin2, Dec2),
    Kolichnik is Dec1 // Dec2,
    dec_bin(Kolichnik, Rezultat).

% Zadacha 6
otstrani_glava([_|R], R).

transponirana([], []).
transponirana([Red|Redici], MT):-transponirana(Red, [Red|Redici], MT).

transponirana([], _, []).
transponirana([_|OstKoloni], Redici, [Kolona|MT]):-
  maplist(nth1(1), Redici, Kolona),
  maplist(otstrani_glava, Redici, OstRedici),
  transponirana(OstKoloni, OstRedici, MT).

mat_proizvod(X, Y, Proizvod):- Proizvod is X*Y.

dot_product(R1, R2, Proizvod):-
  maplist(mat_proizvod, R1, R2, Proizvodi),
  sum_list(Proizvodi, Proizvod).

redica_mnozhenje(M1, Redica, RezRed):-
  maplist(dot_product(Redica), M1, RezRed).

mat_mnozhenje(Matrica, MatT, Rezultat):-
  maplist(redica_mnozhenje(Matrica), MatT, Rezultat).

presmetaj(Matrica, Rezultat):- mat_mnozhenje(Matrica, Matrica, Rezultat).

% Zadacha 7

otstrani_duplikati([], []).
otstrani_duplikati([SubL|L], O):-
  member(SubL, L), !,
  otstrani_duplikati(L, O).
otstrani_duplikati([SubL|L], [SubL|O]):-
  otstrani_duplikati(L, O).

redosled_pomoshnik([], []).
redosled_pomoshnik([E1|L1], [E2|L2]):-
  (E1 > E2; (E1 =:= E2, redosled_pomoshnik(L1, L2))).

proveri_redosled(L1, L2):-
  length(L1, D1),
  length(L2, D2),
  (D1 > D2 ; D1 =:= D2, redosled_pomoshnik(L1, L2)).

insert_opagjachki(L, [], [L]).
insert_opagjachki(L, [F|R], [L, F|R]):-
  proveri_redosled(L, F), !.
insert_opagjachki(L, [F|R], [F|Sortirana]):-
  insert_opagjachki(L, R, Sortirana).

sortiraj_opagjachki([], []).
sortiraj_opagjachki([SubL|L], O):-
  sortiraj_opagjachki(L, Temp),
  insert_opagjachki(SubL, Temp, O).

transform(Input, Output):- otstrani_duplikati(Input, PoedinechniListi), sortiraj_opagjachki(PoedinechniListi, Output).
