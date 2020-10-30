:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    display_start_menu,
    input_dimensions(N),
    N \= exit,
    nl, write('Initial board:'), nl, display_game('initial', N, 'Player1'), nl,
    write('Intermediate board:'), nl, display_game('intermediate', 9, 'Player1'), nl,
    write('Final board:'), nl, display_game('final', 9, 'Player1'), nl, !.

play :- nl, write('Exiting Game...'), nl.
