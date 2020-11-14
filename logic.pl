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
    get_value(L, C, CurrentBoard, empty),
    orientation(O, L, C, BL, BC),
    get_value(BL, BC, CurrentBoard, empty).

% get_value(Row, Column, CurrentBoard, Value) -> returns the Value of the cell with row Row and column Column in the CurrentBoard
get_value(Row, Column, CurrentBoard, Value) :-
    nth1(Row, CurrentBoard, RowList),
    nth1(Column, RowList, Value).

% orientation(O, L, C, BL, BC) -> returns the line (BL) and collumn (BC) of the black part of the Taijitu, based on the line (L) and collumn (C) of the white part, and on the orientation (O) of the Taijitu
orientation(O, L, C, BL, BC) :- O == up, BL is L - 1, BC = C.
orientation(O, L, C, BL, BC) :- O == down, BL is L + 1, BC = C.
orientation(O, L, C, BL, BC) :- O == left, BL = L, BC is C - 1.
orientation(O, L, C, BL, BC) :- O == right, BL = L, BC is C + 1.

% place_taijitu(CurrentBoard, L, C, O, NextBoard) -> places a Taijitu with the white part in cell with row L and collumn C, and orientation O, in CurrentBoard, resulting in NextBoard
place_taijitu(CurrentBoard, L, C, O, NextBoard) :-
    orientation(O, L, C, BL, BC),
    nth1(L, CurrentBoard, RowBeforeWhite),
    replace(RowBeforeWhite, C, white, RowPlacedWhite),
    replace(CurrentBoard, L, RowPlacedWhite, BoardPlacedWhite),
    nth1(BL, BoardPlacedWhite, RowBeforeBlack),
    replace(RowBeforeBlack, BC, black, RowPlacedBlack),
    replace(BoardPlacedWhite, BL, RowPlacedBlack, NextBoard).

% replace(OriginalList, Index, Element, NewList) -> Replace the element at the index Index of the OriginalList for the element Element, resulting in NewList
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

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