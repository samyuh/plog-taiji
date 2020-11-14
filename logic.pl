% ------------------------------------------------------ Make a move ------------------------------------------------------

% makeMove(Player, CurrentBoard, NextPlayer, NextBoard) -> 
makeMove(Player, CurrentBoard, NextPlayer, NextBoard) :-
    length(CurrentBoard, Length),
    nl, write('Choose a cell for the white part of the Taijitu :'), nl, nl,
    write('Row? '),
    input(L, 1, Length, 'Row? ', move),
    write('Column? '),
    input(C, 1, Length, 'Column? ', move),
    write('Orientation of the black part (Up-1, Down-2, Left-3, Right-4)? '),
    input(O, 1, 4, 'Orientation of the black part? ', orientation),
    write('Chosen cell ['), write(L), write(', '), write(C), write(', '), write(O), write(']'), nl,
    valid_move(L, C, O, CurrentBoard),
    place_taijitu(CurrentBoard, L, C, O, NextBoard),
    next_player(Player, NextPlayer), !.

makeMove(Player, CurrentBoard, NextPlayer, NextBoard) :- write('Invalid move!'), nl, makeMove(Player, CurrentBoard, NextPlayer, NextBoard).

% valid_move(L, C, O, CurrentBoard) -> checks if the chosen location for the Taijitu (Line L, Collumn C, Orientation O) is valid in the CurrentBoard
valid_move(L, C, O, CurrentBoard) :-
    cell_is_empty(L, C, CurrentBoard),
    orientation(O, L, C, BL, BC),
    cell_is_empty(BL, BC, CurrentBoard).

% orientation(O, L, C, BL, BC) -> returns the line (BL) and collumn (BC) of the black part of the Taijitu, based on the line (L) and collumn (C) of the white part, and on the orientation (O) of the Taijitu
orientation(O, L, C, BL, BC) :- O == up, BL is L - 1, BC = C.
orientation(O, L, C, BL, BC) :- O == down, BL is L + 1, BC = C.
orientation(O, L, C, BL, BC) :- O == left, BL = L, BC is C - 1.
orientation(O, L, C, BL, BC) :- O == right, BL = L, BC is C + 1.

% cell_is_empty(L, C, CurrentBoard) -> true if the cell with row L and collumn C of the CurrentBoard is empty
cell_is_empty(L, C, CurrentBoard) :-
    get_cell_row(L, CurrentBoard, Row, 1),
    get_cell_value(C, Row, Value, 1),
    Value == empty.

% get_cell_row(L, CurrentBoard, Row, Acc) -> returns the Row with number L from CurrentBoard
get_cell_row(L, [Row|_], Row, L).
get_cell_row(L, [_|CurrentBoard], Row, Acc) :-
    NewAcc is Acc + 1,
    get_cell_row(L, CurrentBoard, Row, NewAcc).

% get_cell_value(C, Row, Value, Acc) -> returns the value (Value) of the row Row with collumn C
get_cell_value(C, [Value|_], Value, C).
get_cell_value(C, [_|Row], Value, Acc) :-
    NewAcc is Acc + 1,
    get_cell_value(C, Row, Value, NewAcc).

% place_taijitu(CurrentBoard, L, C, O, NextBoard) -> places a Taijitu with the white part in cell with row L and collumn C, and orientation O, in CurrentBoard, resulting in NextBoard
place_taijitu(CurrentBoard, L, C, O, NextBoard) :-
    orientation(O, L, C, BL, BC),
    add_row_board(L, C, CurrentBoard, 1, white, [], NextWhiteBoard),
    add_row_board(BL, BC, NextWhiteBoard, 1, black, [], NextBoard).

% add_row_board(L, C, CurrentBoard, AccL, Symbol, AccNextBoard, NextWhiteBoard) -> adds a row to AccNextBoard, based on CurrentBoard rows, and in the changed cell, with row L and collumn C
add_row_board(_, _, [], _, _, NextBoard, NextBoard).
add_row_board(L, C, [Row|CurrentBoard], L, Symbol, AccNextBoard, NextBoard) :-
    change_cell_value(C, Row, Symbol, 1, [], NewRow),
    NewAccL is L + 1,
    append(AccNextBoard, [NewRow], NewNextBoard),
    add_row_board(L, C, CurrentBoard, NewAccL, Symbol, NewNextBoard, NextBoard), !.
add_row_board(L, C, [Row|CurrentBoard], AccL, Symbol, AccNextBoard, NextBoard) :-
    NewAccL is AccL + 1,
    append(AccNextBoard, [Row], NewNextBoard),
    add_row_board(L, C, CurrentBoard, NewAccL, Symbol, NewNextBoard, NextBoard).

% change_cell_value(C, Row, Symbol, AccC, AccRow, NewRow) -> adds the cell values of row Row to AccRow, changing the value of cell with column C, to value Symbol, resulting in NewRow
change_cell_value(_, [], _, _, NewRow, NewRow).
change_cell_value(C, [_|CurrentRow], Symbol, C, AccRow, NewRow) :-
    NewAccC is C + 1,
    append(AccRow, [Symbol], NewAccRow),
    change_cell_value(C, CurrentRow, Symbol, NewAccC, NewAccRow, NewRow), !.
change_cell_value(C, [Elem|CurrentRow], Symbol, AccC, AccRow, NewRow) :-
    NewAccC is AccC + 1,
    append(AccRow, [Elem], NewAccRow),
    change_cell_value(C, CurrentRow, Symbol, NewAccC, NewAccRow, NewRow).

% -------------------------------------------------------------------------------------------------------------------------

% ------------------------------------------------------ Change Player ------------------------------------------------------

% next_player(Player, NextPlayer) -> returns the NextPlayer to place a Taijitu, based on the current Player
next_player(white, black).
next_player(black, white).

% -------------------------------------------------------------------------------------------------------------------------

% ------------------------------------------------------ End of game ------------------------------------------------------

% endOfGame(Board) -> sucess if there's no more possible moves in the Board, fail otherwise
endOfGame(Board) :-
    (\+ search_move_rows(Board) ; \+ search_move_columns(Board)),
    !, fail.

endOfGame(_).

% search_move_rows(Board) -> checks all rows of the Board, to find any horizontal placements of a Taijitu. Sucess if it found any possible move
search_move_rows([]).
search_move_rows([Row|Board]) :-
    \+ row_move(Row),
    search_move_rows(Board).

% row_move(Row) -> sucess if a possible move was found in the given Row
row_move([_]) :- fail.
row_move([Elem1, Elem2|_]) :-
    Elem1 == empty,
    Elem2 == empty, !.
row_move([_, Elem2|RestRow]) :-
    row_move([Elem2|RestRow]).

% search_move_columns(Board) -> checks all columns of the Board, to find any vertical placements of a Taijitu. Sucess if it found any possible move
search_move_columns(Board) :-
    clpfd:transpose(Board, TransposeBoard),
    search_move_rows(TransposeBoard).

% -------------------------------------------------------------------------------------------------------------------------