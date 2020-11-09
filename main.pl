:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').


% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    display_players_menu,
    input(_, 0, 3, 'Type of game? ', players),
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions),
    N \= exit,
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)), display_game(InitialBoard, white),
    repeat,
        retract(state(Player, CurrentBoard)),
        makeMove(Player, CurrentBoard, NextPlayer, NextBoard),
        display_game(NextBoard, Player),
        assert(state(NextPlayer, NextBoard)),
        fail,
        %endOfGame,
    %showResult,
    !.

play :- nl, write('Exiting Game...'), nl.

%repeat.
%repeat :- repeat.