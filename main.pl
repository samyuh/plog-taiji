% play -> Starts the game
play :- initial_board(7, M), nl, write(' '), print_limits(7 * 4 - 1), nl, nl, print_matrix(M), write(' '), print_limits(7 * 4 - 1),  nl, nl.

% ----------------------------------------------------------------------------------------
% initial_board(N, M) -> creates the initial matrix M for the board, with dimensions N x N
initial_board(N, M) :- init_board(N, N, [], M).

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
    create_line(N1, ['T'|MI], M).

% ----------------------------------------------------------------------------------------

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
print_matrix([]).
print_matrix([L|M]) :-
    write('| '), print_line(L),nl,
    print_matrix(M).

print_line([]).
print_line([C|L]) :-
    write(C), write(' | '),
    print_line(L).
% ------------------------------------------------