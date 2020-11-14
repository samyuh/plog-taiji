% ----------------------------------------------------------------------------------------------------------
% display_players_menu -> displays the menu of the game in which the user can choose the type of game he wants
display_players_menu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                           _____     _  _ _                            |'),nl,
    write('|                          |_   _|_ _(_)(_|_)                           |'),nl,
    write('|                            | |/ _` | || | |                           |'),nl,
    write('|                            |_|\\__,_|_|/ |_|                           |'),nl,
    write('|                                     |__/                              |'),nl,
    write('|                                                                       |'),nl,
    write('|                              Game Mode?                               |'),nl,
    write('|                                                                       |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [1]   Player vs Player          |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [2]  Computer vs Player         |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [3]  Computer vs Computer       |              |'),nl,
	write('|               |                                        |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |             [0] Exit Game              |              |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|                                                                       |'),nl,
    write('|_______________________________________________________________________|'),nl,nl,nl.
% ----------------------------------------------------------------------------------------------------------

% ----------------------------------------------------------------------------------------------------------
% display_dimensions_menu -> displays the menu of the game in which the user can choose the board dimensions
display_dimensions_menu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                           _____     _  _ _                            |'),nl,
    write('|                          |_   _|_ _(_)(_|_)                           |'),nl,
    write('|                            | |/ _` | || | |                           |'),nl,
    write('|                            |_|\\__,_|_|/ |_|                           |'),nl,
    write('|                                     |__/                              |'),nl,
    write('|                                                                       |'),nl,
    write('|                           Board Dimensions?                           |'),nl,
    write('|                                                                       |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |               [1]  7x7                 |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |               [2]  9x9                 |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |               [3]  11x11               |              |'),nl,
	write('|               |                                        |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |             [0] Exit Game              |              |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|                                                                       |'),nl,
    write('|_______________________________________________________________________|'),nl,nl,nl.
% ----------------------------------------------------------------------------------------------------------

% -------------------------------------------------------------------------
% input(N, FirstOpt, LastOpt, String, Type) -> Asks the user for an input N of type Type, which must be in the range [FirstOpt, LastOpt], or else a warning is shown, containing the explanation String
input(N, FirstOpt, LastOpt, String, Type) :-
    write('Option: '), read(O),
    check_option(O, N, FirstOpt, LastOpt, String, Type).

% check_option(O, N, FirstOpt, LastOpt, String) -> Check if option chosen by the user (O) is valid, return the value of the option chosen (N) if so.
check_option(O, N, FirstOpt, LastOpt, _, Type) :- O >= FirstOpt, O =< LastOpt, option(O, N, Type), !.
check_option(_, N, FirstOpt, LastOpt, String, Type) :-
    write('Invalid Option. '),
    write(String),
    read(NewO),
    check_option(NewO, N, FirstOpt, LastOpt, String, Type).

% option(O, N, Type) -> Returns the dimensions of the board (N) based on the option chosen by the user (O), considering its type (Type)
option(0, exit, dimensions).
option(0, exit, players).
option(1, 7, dimensions).
option(2, 9, dimensions).
option(3, 11, dimensions).
option(Option, Option, players).
option(Option, Option, move).
option(1, up, orientation).
option(2, down, orientation).
option(3, left, orientation).
option(4, right, orientation).
% -------------------------------------------------------------------------