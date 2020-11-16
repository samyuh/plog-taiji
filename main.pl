:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').

:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(aggregate)).

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    abolish(state/2),
    input_menu(G, N),
    G \= exit,
    N \= exit,
    start_game(G).
    

play :- nl, write('Exiting Game...'), nl.

input_menu(G, N) :-
    display_players_menu,
    input(G, 0, 3, 'Type of game? ', players),
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions).

start_game(1) :-
    %nl, initial(N, InitialBoard), assert(state(white, InitialBoard)), display_game(InitialBoard, white),
    nl, testBoard(InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(Player, CurrentBoard)),
        display_game(CurrentBoard, Player),
        makeMove(Player, CurrentBoard, NextPlayer, NextBoard),
        assert(state(NextPlayer, NextBoard)),
        endOfGame(NextBoard),
    showFinalBoard(NextBoard),
    showResult(NextBoard),
    !.

start_game(2) :-
    write('2 option: to do').

start_game(3) :-
    write('3 option: to do').