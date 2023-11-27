% EXERCICE 01
addh([X,Y],_,[X,Y]).
addh([X,Y],M,[R,S]):- Y1 is (Y + M) mod 60,
			A is (Y + M) // 60,
			X1 is X + A,
			X1=R, Y1=S.

addh1([H1, M1], M, [H2, M2]) :- H3 is (M1 + M) // 60,
				H2 is (H1 + H3) mod 24,
				M2 is (M1 + M) mod 60.

affiche([H, M]) :-
    format('~|~`0t~d~2+:~|~`0t~d~2+', [H, M]).


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