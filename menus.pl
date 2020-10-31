% ----------------------------------------------------------------------
% display_start_menu -> displays the starting menu of the game, with board dimensions options
display_start_menu :-
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
% ----------------------------------------------------------------------

% -------------------------------------------------------------------------
% input_dimensions(N) -> Asks the user for the dimensions of the board (initial) // OLD INPUT_DIMENSIONS
input(N) :-
    write('Option: '), read(O),
    check_option(O, N).

% check_dimensions_option(O, N) -> Check if option chosen by the user (O) is valid, return the dimensions chosen (N) if so. // OLD check_dimensions_option
check_option(O, N) :- O >= 0, O =< 3, option(O, N), !.
check_option(_, N) :-
    write('Invalid Option. Board Dimensions?'),
    read(NewO),
    check_option(NewO, N).

% get_dimensions(O, N) -> Returns the dimensions of the board (N) based on the option chosen by the user (O) // OLD get_dimensions
option(0, exit).
option(1, 7).
option(2, 9).
option(3, 11).
% -------------------------------------------------------------------------