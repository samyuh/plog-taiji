% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    display_start_menu,
    input_dimensions(N),
    N \= exit,
    nl, write('Initial board:'), nl, display_game('initial', N, 'Player1'), nl,
    write('Intermediate board:'), nl, display_game('intermediate', 9, 'Player1'), nl,
    write('Final board:'), nl, display_game('final', 9, 'Player1'), nl, !.

play :- nl, write('Exiting Game...'), nl.

% display_game(Gamestate, Player) -> display the current Gamestate, and it's Player's turn
display_game('initial', N, _) :- initial(N, Gamestate), display_board(Gamestate, N).
display_game('intermediate', N, _) :- intermediateBoard(Gamestate), display_board(Gamestate, N).
display_game('final', N, _) :- finalBoard(Gamestate), display_board(Gamestate, N).

% display_board(Gamestate) -> display the current board (Gamestate), with NxN dimensions
display_board(Gamestate, N) :-
    nl, write('     '), print_numbers(1, N), nl,
    write('   _'), print_limits(N * 4), nl, nl,
    print_matrix(Gamestate, 1, N),
    write('   _'), print_limits(N * 4),  nl, nl.

% -------------------------------------------------------------------------
% character(Name, Symbol) -> returns the Symbol for the cell with name Name
character(empty, ' ').
character(black, 'B').    
character(white, 'W').

% -------------------------------------------------------------------------
% player(Name, Symbol) -> returns the Symbol for the cell with name Name
player('Player1', white).
player('Player2', black).

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
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                               [1]  7x7                                |'),nl,
    write('|                                                                       |'),nl,
    write('|                               [2]  9x9                                |'),nl,
    write('|                                                                       |'),nl,
    write('|                               [3]  11x11                              |'),nl,
	write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                             [0] Exit Game                             |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.
% ----------------------------------------------------------------------

% -------------------------------------------------------------------------
% input_dimensions(N) -> Asks the user for the dimensions of the board (initial)
input_dimensions(N) :-
    write('Option: '), read(O),
    check_dimensions_option(O, N).

% check_dimensions_option(O, N) -> Check if option chosen by the user (O) is valid, return the dimensions chosen (N) if so.
check_dimensions_option(O, N) :- O >= 0, O =< 3, get_dimensions(O, N), !.
check_dimensions_option(_, N) :-
    write('Invalid Option. Board Dimensions?'),
    read(NewO),
    check_dimensions_option(NewO, N).

% get_dimensions(O, N) -> Returns the dimensions of the board (N) based on the option chosen by the user (O)
get_dimensions(0, exit).
get_dimensions(1, 7).
get_dimensions(2, 9).
get_dimensions(3, 11).
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% initial(N, M) -> creates the initial matrix M for the board, with dimensions N x N
initial(N, M) :- init_board(N, N, [], M).

init_board(0, _, M, M).
init_board(N, NC, MI, M) :-
    N > 0,
    N1 is N - 1,
    create_line(NC, [], L),
    init_board(N1, NC , [L|MI], M).

create_line(0, M, M).
create_line(N, MI, M) :-
    N > 0,
    N1 is N - 1,
    create_line(N1, [empty|MI], M).

% ----------------------------------------------------------------------------------------

% ----------------------------------------------------------------------------------
% print_numbers(Acc, N) -> prints a line of numbers, enumerating the columns
print_numbers(N, N) :- write(N), !.
print_numbers(Acc, N) :-    % write becomes more clean when Acc has 2 digits (no deformatting)
    Acc >= 9,
    NewAcc is Acc + 1,
    write(Acc),
    write('  '),
    print_numbers(NewAcc, N), !.
print_numbers(Acc, N) :-
    NewAcc is Acc + 1,
    write(Acc),
    write('   '),
    print_numbers(NewAcc, N).
% ----------------------------------------------------------------------------------

% ----------------------------------------------------------------------------------
% print_limits(N) -> prints a line of "_", making top and bottom limits of the board
print_limits(0).
print_limits(N) :-
    N > 0,
    N1 is N - 1,
    write('_'),
    print_limits(N1).
% ----------------------------------------------------------------------------------

% ------------------------------------------------
% print_matrix(M) -> prints matrix M to the screen
print_matrix([], _, _).
print_matrix([L|M], Acc, N) :-  % write becomes more clean when Acc has 2 digits (no deformatting)
    Acc > 9,
    write(Acc), write('| '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N), !.
print_matrix([L|M], Acc, N) :-
    write(' '), write(Acc), write('| '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N).

% print_matrix(M) -> prints a single line of the board to the screen
print_line([]) :- write('|').
print_line([Cell|L]) :-
    character(Cell, C),
    write('['), write(C), write(']'), write(' '),
    print_line(L).
% ------------------------------------------------

% ------------------------------------------------
% Intermediate Board Matrix
intermediateBoard([
    [black, white, empty, empty, empty, empty, empty, empty, empty],
    [black, white, black, empty, empty, empty, empty, empty, empty],
    [white, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, white, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, white, white, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty]
]).
% ------------------------------------------------

% ------------------------------------------------
% Final Board Matrix
finalBoard([
    [black, white, empty, white, black, empty, black, white, empty],
    [black, white, black, white, empty, white, black, black, white],
    [white, white, black, black, black, white, empty, white, white],
    [white, black, white, black, white, white, black, black, black],
    [black, black, white, white, empty, white, white, black, empty],
    [empty, black, white, black, black, black, empty, white, white],
    [white, white, white, black, white, white, black, black, black],
    [black, black, black, white, white, black, white, black, empty],
    [empty, white, black, black, white, black, white, white, black]
]).
% ------------------------------------------------