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

% ------------------------------------------------

% ------------------------------------------------
% Intermediate Board Matrix 9x9
/*intermediateBoard([
    [black, white, empty, empty, empty, empty, empty, empty, empty],
    [black, white, black, empty, empty, empty, empty, empty, empty],
    [white, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, white, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, black, empty, empty, empty, empty],
    [empty, empty, empty, empty, white, white, black, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty]
]).*/
% ------------------------------------------------

% ------------------------------------------------
% Final Board Matrix 9x9
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


% TEST Board Matrix 9x9
testBoard([
    [black, white, empty, white, black, empty, black, empty, empty],
    [black, white, empty, white, empty, white, black, black, white],
    [white, white, black, black, black, white, empty, white, white],
    [white, black, white, black, white, white, black, black, black],
    [black, black, white, white, empty, white, white, black, empty],
    [empty, black, white, black, black, black, empty, white, white],
    [white, black, black, black, white, white, black, black, black],
    [black, black, black, white, white, black, white, black, empty],
    [black, black, black, black, white, black, white, white, black]
]).
