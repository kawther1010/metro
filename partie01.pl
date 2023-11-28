% EXERCICE 01
addh([H1, M1], Minutes, [H2, M2]) :-
    TotalMinutes is H1 * 60 + M1 + Minutes,
    H2 is TotalMinutes // 60,
    M2 is TotalMinutes mod 60.

affiche([X, Y]) :-
    (X >= 0, X =< 23),
    (Y >= 0, Y =< 59),
    format('~|~`0t~d~2+:~|~`0t~d~2+', [X, Y]).

% EXERCICE 02
lig(Arret1,Arret2,Ligne):- ligne(Ligne,_,L1,_,_), lig1(Arret1,L1),lig1(Arret2,L1),!.
lig1(Arret,[[Arret,_]|_]).				
lig1(Arret,[Arret1|Y]):- Arret\= Arret1 , lig1(Arret,Y).

ligtot(Ar1, Ar2, Ligne, [H,M]) :-
    ligne(Ligne, _, _, [[DH,DM], _, _], _),
    lig(Ar1,Ar2,Ligne),
    (DH >H ;(DH=:=H,DM>=M) ).

ligtard(Ar1, Ar2, Ligne, [H, M]) :-
    ligne(Ligne, _, _, [[DH, DM], _, _], _),
    lig(Ar1, Ar2, Ligne),
    (DH < H ; (DH =:= H, DM =< M)).