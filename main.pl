% play -> Starts the game
play :- display_game('initial', 11).

% display_game(Gamestate, Player) -> display the current Gamestate, and it's Player's turn
display_game('initial', N) :- initial(N, Gamestate), display_board(Gamestate, N).

% display_board(Gamestate) -> display the current board, with NxN dimensions
display_board(Gamestate, N) :- nl, write('     '), print_numbers(1, N), nl, write('    '), print_limits(N * 4 - 1), nl, nl, print_matrix(Gamestate, 1, N), write('    '), print_limits(N * 4 - 1),  nl, nl.

% ----------------------------------------------------------------------------------------
% initial(N, M) -> creates the initial matrix M for the board, with dimensions N x N
initial(N, M) :- init_board(N, N, [], M).

init_board(0, _, M, M).
init_board(N, NC, MI, M) :-
    N > 0,
    N1 is N - 1,
    create_line(NC, [], L),
    init_board(N1, NC ,[L|MI], M).

create_line(0, M, M).
create_line(N, MI, M) :-
    N > 0,
    N1 is N - 1,
    create_line(N1, [' '|MI], M).

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
    %write(' '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N), !.
print_matrix([L|M], Acc, N) :-
    write(' '), write(Acc), write('| '),
    %write(' '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N).

print_line([]) :- write('|').
print_line([C|L]) :-
    write('['), write(C), write(']'), write(' '),
    print_line(L).
% ------------------------------------------------

% ------------------------------------------------
% mid game boarc
mid_game :-
    write('123456789'), nl,
    write('1 | '), write('[B] '), write('[W] '), write('[B] '), write('[] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('2 | '), write('[B] '), write('[W] '), write('[ ] '), write('[] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('3 | '), write('[W] '), write('[ ] '), write('[ ] '), write('[] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('4 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[ ] '), write('[W] '), write('[B] '), write('[ ] '), write('[ ] '), nl,
    write('5 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('6 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[B] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('7 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[W] '), write('[W] '), write('[B] '), write('[ ] '), write('[ ] '), nl,
    write('8 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[B] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl,
    write('9 | '), write('[ ] '), write('[ ] '), write('[ ] '), write('[] '), write('[B] '), write('[ ] '), write('[ ] '), write('[ ] '), write('[ ] '), nl.
% ------------------------------------------------

% ------------------------------------------------
% end game board
end_game :-
    write('123456789'), nl,
    write('1 | '), write('[B] '), write('[W] '), write('[B] '), write('[W] '), write('[ ] '), write('[W] '), write('[B] '), write('[B] '), write('[W] '), nl,
    write('2 | '), write('[W] '), write('[W] '), write('[B] '), write('[B] '), write('[B] '), write('[W] '), write('[ ] '), write('[W] '), write('[W] '), nl,
    write('3 | '), write('[B] '), write('[W] '), write('[ ] '), write('[W] '), write('[B] '), write('[ ] '), write('[B] '), write('[W] '), write('[ ] '), nl,
    write('4 | '), write('[W] '), write('[B] '), write('[W] '), write('[B] '), write('[W] '), write('[W] '), write('[B] '), write('[B] '), write('[B] '), nl,
    write('5 | '), write('[B] '), write('[B] '), write('[W] '), write('[W] '), write('[ ] '), write('[W] '), write('[W] '), write('[B] '), write('[ ] '), nl,
    write('6 | '), write('[ ] '), write('[B] '), write('[W] '), write('[B] '), write('[B] '), write('[B] '), write('[ ] '), write('[W] '), write('[W] '), nl,
    write('7 | '), write('[W] '), write('[W] '), write('[W] '), write('[B] '), write('[W] '), write('[W] '), write('[B] '), write('[B] '), write('[B] '), nl,
    write('8 | '), write('[B] '), write('[B] '), write('[B] '), write('[W] '), write('[B] '), write('[B] '), write('[W] '), write('[B] '), write('[ ] '), nl,
    write('9 | '), write('[ ] '), write('[W] '), write('[B] '), write('[B] '), write('[B] '), write('[B] '), write('[W] '), write('[W] '), write('[B] '), nl.
% ------------------------------------------------