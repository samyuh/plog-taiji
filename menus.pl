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
% display_color_menu -> displays the menu of the game in which the user can choose the color vs ai
display_color_menu :-
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
    write('|                              Color                                    |'),nl,
    write('|                                                                       |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [1]   White                     |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [2]   Black                     |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |                                        |              |'),nl,
	write('|               |                                        |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |             [0] Exit Game              |              |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|                                                                       |'),nl,
    write('|_______________________________________________________________________|'),nl,nl,nl.
% ----------------------------------------------------------------------------------------------------------

% ----------------------------------------------------------------------------------------------------------
% display_ai_level -> displays the menu of the game in which the user can choose the difficulty
display_ai_level :-
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
    write('|                              Difficulty                               |'),nl,
    write('|                                                                       |'),nl,
    write('|               ------------------------------------------              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [1]   Random                    |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |        [2]   Intelligent               |              |'),nl,
    write('|               |                                        |              |'),nl,
    write('|               |                                        |              |'),nl,
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
codes_to_number([], _, Number, Number).
codes_to_number([Code|Codes], Exponent, Acc, Number) :-
    NewAcc is Acc + (10**Exponent) * (Code - 48),
    NewExponent is Exponent - 1,
    codes_to_number(Codes, NewExponent, NewAcc, Number).

read_input(Number) :-
    read_line(Codes),
    length(Codes, NrCodes),
    Exponent is NrCodes - 1,
    codes_to_number(Codes, Exponent, 0, FloatNumber),
    Number is round(FloatNumber).

% -------------------------------------------------------------------------
% input(N, FirstOpt, LastOpt, String, Type) -> Asks the user for an input N of type Type, which must be in the range [FirstOpt, LastOpt], or else a warning is shown, containing the explanation String
input(N, FirstOpt, LastOpt, String, Type) :-
    write('Option: '),
    read_input(Number),
    check_option(Number, N, FirstOpt, LastOpt, String, Type).

% check_option(O, N, FirstOpt, LastOpt, String) -> Check if option chosen by the user (O) is valid, return the value of the option chosen (N) if so.
check_option(O, N, FirstOpt, LastOpt, _, Type) :- O >= FirstOpt, O =< LastOpt, option(O, N, Type), !.
check_option(_, N, FirstOpt, LastOpt, String, Type) :-
    write('Invalid Option. '),
    write(String),
    read_input(Number),
    check_option(Number, N, FirstOpt, LastOpt, String, Type).

% option(O, N, Type) -> Returns the dimensions of the board (N) based on the option chosen by the user (O), considering its type (Type)
option(1, 7, dimensions).
option(2, 9, dimensions).
option(3, 11, dimensions).
option(0, exit, dimensions).

option(0, exit, players).
option(Option, Option, players).

option(Option, Option, move).
option(1, up, orientation).
option(2, down, orientation).
option(3, left, orientation).
option(4, right, orientation).

option(1, white, color).
option(2, black, color).

option(1, random, difficulty).
option(2, intelligent, difficulty).
% -------------------------------------------------------------------------