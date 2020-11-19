:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').

:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(aggregate)).
:- use_module(library(random)).

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    abolish(state/2),
    input_menu(G, N),
    G \= exit,
    N \= exit,
    start_game(G, N).
    

play :- nl, write('Exiting Game...'), nl.

input_menu(G, N) :-
    display_players_menu,
    input(G, 0, 3, 'Type of game? ', players),
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions).

start_game(1, N) :-
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(Player, CurrentBoard)),
        display_game(CurrentBoard, Player),
        makeMove(Player, CurrentBoard, NextPlayer, NextBoard, player),
        assert(state(NextPlayer, NextBoard)),
        endOfGame(NextBoard),
    showFinalBoard(NextBoard),
    showResult(NextBoard),
    !.

start_game(2, N) :-
    display_ai_level,
    input(Difficulty, 1, 2, 'AI difficulty? ', difficulty),
    display_color_menu,
    input(Color, 1, 2, 'Player Color? ', color),
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(PlayerColor, CurrentBoard)),
        display_game(CurrentBoard, PlayerColor),
        return_player_type(Color, PlayerColor, PlayerType),
        write('PLAYERTYPE: '), write(PlayerType), nl,
        makeMove(PlayerColor, CurrentBoard, NextPlayerColor, NextBoard, PlayerType),
        assert(state(NextPlayerColor, NextBoard)),
        endOfGame(NextBoard),
    showFinalBoard(NextBoard),
    showResult(NextBoard),
    !.

start_game(3, N) :-
    display_ai_level,
    input(Difficulty, 1, 2, 'AI difficulty? ', difficulty),
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(PlayerColor, CurrentBoard)),
        display_game(CurrentBoard, PlayerColor),
        makeMove(PlayerColor, CurrentBoard, NextPlayerColor, NextBoard, bot),
        assert(state(NextPlayerColor, NextBoard)),
        endOfGame(NextBoard),
    showFinalBoard(NextBoard),
    showResult(NextBoard),
    !.