:- consult('board.pl').
:- consult('menus.pl').
:- consult('display.pl').
:- consult('logic.pl').

:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
:- use_module(library(system)).

% play -> Starts the game, with a N x N board. Player1 (white color) starts playing.
play :-
    abolish(state/2),
    display_players_menu,
    input(G, 0, 3, 'Type of game? ', players),
    G \= exit,
    display_dimensions_menu,
    input(N, 0, 3, 'Board Dimensions? ', dimensions),
    N \= exit,
    start_game(G, N).

play :- nl, write('Exiting Game...'), nl.

start_game(1, N) :-
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(Player, CurrentBoard)),
        display_game(CurrentBoard, Player),
        makeMove(Player, CurrentBoard, NextPlayer, NextBoard, player),
        assert(state(NextPlayer, NextBoard)),
        game_over(NextBoard, Winner-Number),
    showResult(Winner, Number),
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
        return_player_type(Color, PlayerColor, PlayerType, Difficulty),
        makeMove(PlayerColor, CurrentBoard, NextPlayerColor, NextBoard, PlayerType),
        assert(state(NextPlayerColor, NextBoard)),
        game_over(NextBoard, Winner-Number),
    showResult(Winner, Number),
    !.

start_game(3, N) :-
    display_ai_level,
    write('White Color Bot Level? (1-random, 2-intelligent): '),
    input(DifficultyWhite, 1, 2, 'White Color Bot Level? ', difficulty),
    write('Black Color Bot Level? (1-random, 2-intelligent): '),
    input(DifficultyBlack, 1, 2, 'Black Color Bot Level? ', difficulty),
    nl, initial(N, InitialBoard), assert(state(white, InitialBoard)),
    repeat,
        retract(state(PlayerColor, CurrentBoard)),
        display_game(CurrentBoard, PlayerColor),
        next_difficulty(PlayerColor, DifficultyWhite, DifficultyBlack, Difficulty),
        makeMove(PlayerColor, CurrentBoard, NextPlayerColor, NextBoard, Difficulty),
        assert(state(NextPlayerColor, NextBoard)),
        sleep(1),
        game_over(NextBoard, Winner-Number),
    showResult(Winner, Number).