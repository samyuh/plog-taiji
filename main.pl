:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').

:- use_module(library(clpfd)).

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    abolish(state/2),
    display_players_menu,
    input(_, 0, 3, 'Type of game? ', players),
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions),
    N \= exit,
    %nl, initial(N, InitialBoard), assert(state(white, InitialBoard)), display_game(InitialBoard, white),
    nl, testBoard(InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(Player, CurrentBoard)),
        display_game(CurrentBoard, Player),
        makeMove(Player, CurrentBoard, NextPlayer, NextBoard),
        assert(state(NextPlayer, NextBoard)),
        endOfGame(NextBoard),
    showFinalBoard(NextBoard),
    %showResult,
    !.

play :- nl, write('Exiting Game...'), nl.

%repeat.
%repeat :- repeat.