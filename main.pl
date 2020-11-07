:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    display_players_menu,
    input(_, 0, 3, 'Type of game? ', players),
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions),
    N \= exit,
    nl, write('Initial board:'), nl, initial(N, Gamestate), display_game(Gamestate, white), nl,
    write('Intermediate board:'), nl, intermediateBoard(Gamestate2), display_game(Gamestate2, white), nl,
    write('Final board:'), nl, finalBoard(Gamestate3), display_game(Gamestate3, white), nl, !.

play :- nl, write('Exiting Game...'), nl.