% -------------------------------------------------------------------------
% character(Name, Symbol) -> returns the Symbol for the cell with name Name
character(empty, ' ').
character(black, 'X').    
character(white, 'O').

% -------------------------------------------------------------------------
% player(Name, Symbol) -> returns the Symbol for the cell with name Name
player(white, 'White Player').
player(black, 'Black Player').

/*
 display_game(Gamestate, Player) -> display the current Gamestate, and it's Player's turn
*/

display_game(Gamestate, Player) :- display_board(Gamestate), display_turn(Player).

% display_board(Gamestate) -> display the current board (Gamestate), with NxN dimensions
display_board(Gamestate) :-
    length(Gamestate, N),
    nl, write('      '), print_numbers(1, N), nl,
    write('   _'), print_limits(N * 4), nl, nl,
    print_matrix(Gamestate, 1, N),
    write('   _'), print_limits(N * 4),  nl, nl.

display_turn(Player) :-
    player(Player, Name),
    write(Name), write(' turn.'), nl.

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

% ------------------------------------------------
% print_matrix(M) -> prints matrix M to the screen
print_matrix([], _, _).
print_matrix([L|M], Acc, N) :-  % write becomes more clean when Acc has 2 digits (no deformatting)
    Acc > 9,
    write(Acc), write('| '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N), !.
print_matrix([L|M], Acc, N) :-
    write(' '), write(Acc), write('| '),
    print_line(L), nl,
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N).

% print_matrix(M) -> prints a single line of the board to the screen
print_line([]) :- write('|').
print_line([Cell|L]) :-
    character(Cell, C),
    write('| '), write(C), write(' '),
    print_line(L).
% ------------------------------------------------

% ----------------------------------------------------------------------------------
% print_limits(N) -> prints a line of "_", making top and bottom limits of the board
print_limits(0).
print_limits(N) :-
    N > 0,
    N1 is N - 1,
    write('_'),
    print_limits(N1).
% ----------------------------------------------------------------------------------