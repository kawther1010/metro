% EXERCICE 03
itintot(Arret1, Arret2, Horaire, Parcours, Transport, Long):- chercheligne(Arret1, L1), chercheligne(Arret2, L2),
						inter(L1,L2,L3), postparcours(Arret1, Arret2, 0,Horaire, L1, L2, L3, Transport, Long, Parcours).

itintard(Arret1, Arret2, Horaire, Parcours, Transport, Long):- chercheligne(Arret1, L1), chercheligne(Arret2, L2),
						inter(L1,L2,L3), postparcours(Arret1, Arret2, 1,Horaire, L1, L2, L3, Transport, Long, Parcours).
						
chercheligne(Arret, L):- findall(X, inlig(Arret, _, X) , L).

inlig(A,_,L):- ligne(L,_,[[_,_]|P],_,_),  lig1(A,P).

postparcours(A,B,D,H,_,_,L,T,Long,_):- L \= [], D = 0, ligtot1(A,B,_,H,T,Long).
postparcours(A,B,_,H,_,_,L,T,Long,_):- L \= [], ligtard1(A,B,_,H,T,Long).
postparcours(A,B,D,H,L1,L2,_,_,_,_):- D = 0, parcours(A ,B , H, L1, L2, [], L), nl, itinplustot(A,B,H,L,[]).
postparcours(A,B,_,H,L1,L2,_,_,_,_):- parcours(A ,B , H, L1, L2, [], L), nl, itinplustard(A,B,H,L,[]).


parcours(_, _, _, [], _, X, X):- !.
parcours(A, B, H, [X|Y], L, Aux, R):- ligne(X, _, P, _, _), search_parcours(P, L, [], [], Ls), 
					cross(X, Ls, R1), R3 = [R1], append(R3, Aux, R2),
					parcours(A, B, H, Y, L, R2, R).
parcours(A, B, H, [_|Y], L, Aux, R):- parcours(A, B, H, Y, L, Aux, R).

search_parcours([], _, _, L2, L2):- !.
search_parcours([[X, _]|Y], Lfin, Visit, L2, Ret):- chercheligne(X, L3),
						veriflist(L3, Lfin, R), cross(X, R, L), addlist(L, L2, L4),
						!,search_parcours(Y, Lfin, Visit, L4, Ret).
search_parcours([_|Y], Lfin, Visit, L2, Ret):- !,search_parcours(Y, Lfin, Visit, L2, Ret).

veriflist([X|_], L2, R):- member(X,L2), R = X.
veriflist([_|L1], L2, R):- veriflist(L1, L2, R).

addlist(X,L,L1):- L1=[X|L].

inter([],_,[]).
inter([X|Y],A,[X|B]):- member(X, A), inter(Y,A,B).
inter([_|Y],A,B):- inter(Y,A,B).

cross(A,B,R):- R = [A,B].

itinplustot(A,B,_,[],R):- !, itinplustot(R,T), nl, affiche_resultat_itin(A,B,T).
itinplustot(A,B,H, [[L,P]|Y], R):- totligne(A,L,P,H,[],R1), append(R1, R, R2), itinplustot(A,B,H,Y,R2).

itinplustard(A,B,_,[],R):- !, itinplustard(R,T), nl, affiche_resultat_itin(A,B,T).
itinplustard(A,B,H, [[L,P]|Y], R):- tardligne(A,L,P,H,[],R1), append(R1, R, R2), itinplustard(A,B,H,Y,R2).

totligne(_, _, [], _, Aux, R):- !, R = Aux.
totligne(A, L, [[B, L2]|Y], H, Aux, R):- itinligar(A,B,L,H,_,K,0), addlist(L2, K, L3), addlist(L3, Aux, Aux1), totligne(A,L,Y,H,Aux1,R).

tardligne(_, _, [], _, Aux, R):- !, R = Aux.
tardligne(A, L, [[B, L2]|Y], H, Aux, R):- itinligartard(A,B,L,H,_,K,1), addlist(L2, K, L3), addlist(L3, Aux, Aux1), tardligne(A,L,Y,H,Aux1,R).

itinligar(A, B, L, H, L, R, _):- ligaller(A, B, X), ligne(X, _, _, Time, _), addt(A, X, Time, H, Lr, 0), time_n_ligne(B,Lr,R1), addlist(X,R1,R).
itinligar(A, B, L, H, L, R, P):- ligne(X, _, _, _, Time), addtreverse(A, X, Time, H, Lr, P), time_n_ligne(B,Lr,R1), addlist(X,R1,R).

itinligartard(A, B, L, H, L, R, _):- ligaller(A, B, X), ligne(X, _, _, Time, _), addt(A, X, Time, H, Lr, 1), time_n_ligne(B,Lr,R1), addlist(X,R1,R).
itinligartard(A, B, L, H, L, R, P):- ligne(X, _, _, _, Time), addtreverse(A, X, Time, H, Lr, P), time_n_ligne(B,Lr,R1), addlist(X,R1,R).

itinplustot([[L1, L2, S, [H,M]]|Y], R):- itinplustot1(Y, [L1, L2, S, [H,M]], R).

itinplustot1([], A, A):- !.
itinplustot1([[L1, L2, S, [H,M]]|Y],[_,_,_,[P,Q]], R):- H =< P, M < Q,!,
					itinplustot1(Y, [L1, L2, S, [H, M]], R).
itinplustot1([_|Y], A, R):- itinplustot1(Y, A, R).


itinplustard([[L1, L2, S, [H,M]]|Y], R):- itinplustard1(Y, [L1, L2, S, [H,M]], R).

itinplustard1([], A, A):- !.
itinplustard1([[L1, L2, S, [H,M]]|Y],[_,_,_,[P,Q]], R):- H >= P, M > Q,!,
					itinplustard1(Y, [L1, L2, S, [H, M]], R).
itinplustard1([_|Y], A, R):- itinplustard1(Y, A, R).

affiche_resultat_itin(A, B, [L2, L1, S, X]):- nl, write('L horaire :  '), affiche(X), nl,
					write('------------------------------------------------------------------------'), nl,
					write('Par la ligne '), write(L1), nl, stationitin(A, S, B, L1, L2).


stationitin(A, S, B, L1, L2):- ligne(L1, _, P, _, _), affiche_station1(A, S, L1, P, R), reverse(R, R1), nl,
				write('Les stations~'), nl, affichage_stationitin(R1, 0, Tot), nl,nl,
				write('Changement de correspondance par la ligne ~ '), write(L2),nl,nl,
				write('------------------------------------------------------------------------'), nl,
				write('Les stations restantes~ '),
				ligne(L2, _, P1, _, _),
				affiche_station1(S, B, L2, P1, T), reverse(T, T1), nl, affichage_stationitin(T1, 0, Tot1),
				Totf is Tot + Tot1, nl,
				write('Durée totale du parcours: ~ '), write(Totf), write(' min').
		
affichage_stationitin([], Aux, Aux):- !.
affichage_stationitin([[A, T]|Y], Aux, R):- write('~ '), write(A), write(' de durée '), write(T), write(' min'), nl, Aux1 is Aux + T, affichage_stationitin(Y, Aux1, R).


% EXERCICE 04
ligtot1(A,B,_,H,T,O):- O == 1, findall(X,(ligne(X, T,_,_,_),lig(A,B,X)), R),
		ligar1(A, B, R, H, [], Ltot, 0),
		nl, moinstat(Ltot, Htot), !,
		nl, affiche_resultat_stat(A, B, Htot).
ligtot1(A,B,L,H,T,_):- findall(X,(ligne(X, T,_,_,_),lig(A,B,X)), R),
		ligar(A, B, R, H, [], Ltot, 0),
		nl,plustot(Ltot, Htot), !,
		nl,affiche_resultat_tot(A, B, Htot),
		verif(Htot,L).
ligtot1(_,_,_,_,T,_):- write('Pas d itineraire pour le moyen de transport demandé  ==>  '), !, write(T), nl.


ligtard1(A,B,_,H,T,O):- O == 1, findall(X,(ligne(X,T,_,_,_),lig(A,B,X)),R),
		ligar1(A, B, R, H, [], Ltard, 1),
		nl, moinstat(Ltard, Htard),!,
		nl, affiche_resultat_stat_tard(A, B, Htard).

ligtard1(A,B,L,H,T,_):- findall(X,(ligne(X,T,_,_,_),lig(A,B,X)),R),
		ligar(A, B, R, H, [], Ltard, 1),
		nl, plustard(Ltard, Htard),!,
		nl, affiche_resultat_tard(A, B, Htard),
		verif(Htard,L).
ligtard1(_,_,_,_,T,_):- write('Pas d itineraire pour le moyen de transport demandé  ==>  '), !,write(T), nl.

ligar1(_, _, [], _, L, L, _).
ligar1(A, B, [X|Y], H, L, K, P):- ligaller(A, B, X), ligne(X, _, _, Time, _), addt(A, X, Time, H, Lr, P),
				nbstation(A, B, X, Nbs),
				time_n_ligne1(X, Lr, Nbs, R),
		 		ligar1(A, B, Y, H, [R|L], K, P).
ligar1(A, B, [X|Y], H, L, K, P):- ligne(X, _, _, _, Time), addtreverse(A, X, Time, H, Lr, P),
				nbstation(A , B, X, Nbs),
				time_n_ligne1(X, Lr, Nbs, R),
		 		ligar1(A, B, Y, H, [R|L], K, P).

nbstation(A,B,L,R):- ligne(L,_,P,_,_), calc(A,P,0,R1), calc(B,P,0,R2),
			R3 is R2 - R1, R is abs(R3).

time_n_ligne1(X,[Y1,Y2], S, Z):-  Z = [X,S,[Y1,Y2]].

moinstat([[L,S,[H,M]]|Y], R):- moinstat1(Y, [L,S,[H,M]], R).

moinstat1([], A, A):- !.
moinstat1([[M1, B, [H,M]]|Y], [_, A, _], R):-  B =< A, moinstat1(Y, [M1, B, [H, M]], R).
moinstat1([_|Y], A, R):- moinstat1(Y, A, R).

affiche_resultat_stat(A, B, [M,S,X]):- write('L horaire le plus tot:  '), affiche(X),nl,
				write('------------------------------------------------------------------------'), nl,
				write('Avec le minimum de station possible '), write('est la ligne '), write(M),nl,
				write('Le nombre de station vaut: '), write(S), nl,
				station(A, B, M).

affiche_resultat_stat_tard(A, B, [M,S,X]):- write('L horaire le plus tot:  '), affiche(X),nl,
				write('------------------------------------------------------------------------'), nl,
				write('Avec le minimum de station possible '), write('est la ligne '), write(M),nl,
				write('Le nombre de station vaut: '), write(S), nl,
				station(A, B, M).