% character(Name, Symbol) -> returns the Symbol for the cell with name Name
character(empty, ' ').
character(black, 'X').    
character(white, 'O').

% player(Player, String) -> returns the String of Player to present to the screen 
player(white, 'White Player').
player(black, 'Black Player').

% display_game(Gamestate, Player) -> display the current Gamestate, and it's Player's turn
display_game(Gamestate, Player) :- display_board(Gamestate), display_turn(Player).

% display_board(Gamestate) -> display the current board (Gamestate), with NxN dimensions
display_board(Gamestate) :-
    length(Gamestate, N),
    nl, write('      '), print_numbers(1, N), 
    nl,
    write('    \x250c\'), print_top(N),
    nl, 
    print_matrix(Gamestate, 1, N),
    write('    \x2514\'), print_bot(N),
    nl, 
    !.

% display_turn(Player) -> display the Player to play in the current turn
display_turn(Player) :-
    player(Player, Name),
    character(Player, Symbol),
    nl, write(Name), write(' turn. ('), write(Symbol), write(')'), nl.

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
    write(Acc), write('  '),
    print_line(L), write('\n'),
    print_limits(Acc, N),
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N), !.
print_matrix([L|M], Acc, N) :-
    write(' '), write(Acc), write('  '),
    print_line(L), write('\n'),
    print_limits(Acc, N),
    NewAcc is Acc + 1,
    print_matrix(M, NewAcc, N).

% print_matrix(M) -> prints a single line of the board to the screen
print_line([]) :- write('\x2502\').
print_line([Cell|L]) :-
    character(Cell, C),
    write('\x2502\ '), write(C), write(' '),
    print_line(L).

% ------------------------------------------------

% ----------------------------------------------------------------------------------
% print_limits(N) -> prints a line of "_", making top and bottom limits of the board
print_limits(A, A).
print_limits(_, 0) :- nl.
print_limits(_, N) :-
    write('    \x251c\'), 
    print_middle(N).

print_middle(0) :- nl.
print_middle(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'),
    print_middle_intersect(N),
    print_middle(N1).

print_top(0).
print_top(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'),
    print_top_intersect(N),
    print_top(N1).

print_bot(0).
print_bot(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'),
    print_bot_intersect(N),
    print_bot(N1).

print_middle_intersect(1) :-
    write('\x2524\').
print_middle_intersect(_) :-
    write('\x253c\').

print_top_intersect(1) :-
    write('\x2510\').
print_top_intersect(_) :-
    write('\x252c\').

print_bot_intersect(1) :-
    write('\x2518\').
print_bot_intersect(_) :-
    write('\x2534\').

% ----------------------------------------------------------------------------------

% showFinalBoard(NextBoard) -> displays the FinalBoard, with no more possible moves left
showFinalBoard(FinalBoard) :-
    length(FinalBoard, 7),
    nl, write('\t     Final Board'), nl,
    display_board(FinalBoard).

showFinalBoard(FinalBoard) :-
    length(FinalBoard, 9),
    nl, write('\t\t Final Board'), nl,
    display_board(FinalBoard).

showFinalBoard(FinalBoard) :-
    length(FinalBoard, 11),
    nl, write('\t\t     Final Board'), nl,
    display_board(FinalBoard).

% ----------------------------------------------------------------------------------