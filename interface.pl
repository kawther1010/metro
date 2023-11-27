% EXERCICE 05

display_stations :-
    write('Stations: '), nl,
    forall(ligne(_, _, Stations, _, _), (
        write('Line: '), writeln(Stations)
    )).

get_station_input(Message, Station) :-
    write(Message),
    read(Station).

find_and_display_routes(StartStation, EndStation) :-
    write('Possible Routes:'),
    findall(L, (ligne(L,_,P,_,_), lig1(A,P)), R),
    nl.

user_interface :-
    display_stations,
    get_station_input('Enter the start station: ', StartStation), nl,
    get_station_input('Enter the end station: ', EndStation), nl,
    find_and_display_routes(StartStation, EndStation).

:- user_interface.