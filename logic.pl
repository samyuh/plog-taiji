% ------------------------------------------------------------------------------------------------------------------------- %
%                                                        Make a move                                                        %
%   Prototype:                                                                                                              %
%       makeMove(+Color, +CurrentBoard, -NextPlayer, -NextBoard, +PlayerType)                                               %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Color -> The color of the player to play in the current turn                                                        %
%       CurrentBoard -> The state of the current board, before the move chosen by the player                                %
%       PlayerType -> Type of the player to play in the current turn (player or bot)                                        %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%       NextPlayer -> The color of the player to play in the next turn                                                      %
%       NextBoard -> The state of the next board, after the move chosen by the player                                       %
% ------------------------------------------------------------------------------------------------------------------------- %

makeMove(Color, CurrentBoard, NextColor, NextBoard, player) :-
    length(CurrentBoard, Length),
    next_player(Color, NextColor),
    nl, write('Choose a cell for the '), write(Color), write(' part of the Taijitu:'), nl, nl,
    write('Row? '),
    input(L, 1, Length, 'Row? ', move),
    write('Column? '),
    input(C, 1, Length, 'Column? ', move),
    write('Orientation of the '), write(NextColor), write(' part (Up-1, Down-2, Left-3, Right-4)? '),
    atom_concat('Orientation of the ', NextColor, HalfString),
    atom_concat(HalfString, ' part? ', String),
    input(O, 1, 4, String, orientation),
    write('Chosen cell ['), write(L), write(', '), write(C), write(', '), write(O), write(']'), nl,
    valid_move(L, C, O, CurrentBoard),
    move(CurrentBoard, L-C-O-Color, NextBoard), !.

makeMove(Color, CurrentBoard, NextColor, NextBoard, random) :-
    choose_move(CurrentBoard, Color, random, L-C-O),
    write('Chosen cell ['), write(L), write(', '), write(C), write(', '), write(O), write(']'), nl,
    move(CurrentBoard, L-C-O-Color, NextBoard),
    next_player(Color, NextColor), !.

makeMove(Color, CurrentBoard, NextColor, NextBoard, intelligent) :-
    choose_move(CurrentBoard, Color, intelligent, L-C-O),
    write('Chosen cell ['), write(L), write(', '), write(C), write(', '), write(O), write(']'), nl,
    move(CurrentBoard, L-C-O-Color, NextBoard),
    next_player(Color, NextColor), !.

makeMove(Color, CurrentBoard, NextColor, NextBoard, PlayerType) :-
    write('Invalid move!'), nl,
    makeMove(Color, CurrentBoard, NextColor, NextBoard, PlayerType).

% ------------------------------------------------------------------------------------------------------------------------- %

% valid_move(L, C, O, CurrentBoard) -> checks if the chosen location for the Taijitu (Line L, Collumn C, Orientation O) is valid in the CurrentBoard
valid_move(L, C, O, CurrentBoard) :-
    get_value(L, C, CurrentBoard, empty),
    orientation(O, L-C, BL-BC),
    get_value(BL, BC, CurrentBoard, empty).

% get_value(Row, Column, CurrentBoard, Value) -> returns the Value of the cell with row Row and column Column in the CurrentBoard
get_value(Row, Column, CurrentBoard, Value) :-
    nth1(Row, CurrentBoard, RowList),
    nth1(Column, RowList, Value), !.

get_value(_, _, _, off_limits).

% orientation(O, L, C, BL, BC) -> returns the line (BL) and collumn (BC) of the black part of the Taijitu, based on the line (L) and collumn (C) of the white part, and on the orientation (O) of the Taijitu
orientation(O, L-C, BL-BC) :- O == up, BL is L - 1, BC = C.
orientation(O, L-C, BL-BC) :- O == down, BL is L + 1, BC = C.
orientation(O, L-C, BL-BC) :- O == left, BL = L, BC is C - 1.
orientation(O, L-C, BL-BC) :- O == right, BL = L, BC is C + 1.

% move(GameState, L-C-O, NewGameState) -> places a Taijitu with the white part in cell with row L and collumn C, and orientation O, in the current GameState, resulting in NewGameState
move(GameState, L-C-O-Color, NewGameState) :-
    orientation(O, L-C, BL-BC),
    nth1(L, GameState, RowBeforeWhite),
    replace(RowBeforeWhite, C, Color, RowPlacedWhite),
    replace(GameState, L, RowPlacedWhite, BoardPlacedWhite),
    nth1(BL, BoardPlacedWhite, RowBeforeBlack),
    next_player(Color, NextColor),
    replace(RowBeforeBlack, BC, NextColor, RowPlacedBlack),
    replace(BoardPlacedWhite, BL, RowPlacedBlack, NewGameState).

% replace(OriginalList, Index, Element, NewList) -> Replace the element at the index Index of the OriginalList for the element Element, resulting in NewList
replace([_|T], 1, X, [X|T]):- !.
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

% ----------------------------------------------------------- Move Bot ----------------------------------------------------------------
% lista_ate(N, L) -> devolve a lista L de todos os números inteiros entre 1 e N -> APAGAR E USAR BETWEEN? Nao funciona o between...
lista_ate(1, [1]).
lista_ate(N, L) :-
    N > 1,
    N1 is N-1,
    lista_ate(N1, L2),
    append(L2, [N], L).

% Prototype in the Project Enunciate -> valid_moves(+GameState, +Player, -ListOfMoves)
valid_moves(GameState, _, ListOfMoves) :-
    length(GameState, Length),
    lista_ate(Length, RangeList),
    % numlist(Length, NumList),
    % write(RangeList), nl,
    % write(NumList), nl,
    findall(L-C-O, (member(O, [up, down, left, right]), member(L, RangeList), member(C, RangeList), valid_move(L, C, O, GameState)), ListOfMoves).

% choose_move(+GameState, +Player, +Level, -Move)
choose_move(GameState, Player, random, L-C-O) :-
    valid_moves(GameState, Player, PossibleMoves),
    length(PossibleMoves, NumberMoves),
    LimitRandom is NumberMoves + 1,
    random(1, LimitRandom, R),
    nth1(R, PossibleMoves, L-C-O).

choose_move(GameState, Player, intelligent, L-C-O) :-
    valid_moves(GameState, Player, PossibleMoves),
    length(GameState, Length),
    lista_ate(Length, RangeList),
    setof(Move, calculateValueMove(GameState, Player, RangeList, PossibleMoves, Move), Moves),
    select_best_moves(Moves, [], BestMoves, _),
    length(BestMoves, NumberMoves),
    LimitRandom is NumberMoves + 1,
    random(1, LimitRandom, R),
    nth1(R, BestMoves, _-L-C-O).

calculateValueMove(GameState, Color, RangeList, PossibleMoves, SymmetricalValue-L-C-O) :-
    member(L, RangeList),
    member(C, RangeList),
    member(O, [up, down, left, right]),
    member(L-C-O, PossibleMoves),
    move(GameState, L-C-O-Color, NewGameState),
    best_possible_value(NewGameState, Color, Value, _),
    SymmetricalValue is -Value.

select_best_moves([V-L-C-O|Moves], [], BestMoves, _) :-
    select_best_moves(Moves, [V-L-C-O], BestMoves, V), !.

select_best_moves([], BestMoves, BestMoves, _) :- !.

select_best_moves([V-_-_-_|_], BestMoves, BestMoves, BestValue) :-
    V > BestValue, !.

select_best_moves([V-L-C-O|Moves], AccMoves, BestMoves, BestValue) :-
    append(AccMoves, [V-L-C-O], NewAccMoves),
    select_best_moves(Moves, NewAccMoves, BestMoves, BestValue).

% -------------------------------------------------------------------------------------------------------------------------------------


% ------------------------------------------------------ Change Player ------------------------------------------------------

% next_player(Player, NextPlayer) -> returns the NextPlayer to place a Taijitu, based on the current Player
next_player(white, black).
next_player(black, white).

% return_player_type(Color, PlayerColor, player) -> returns the type of player to play in the current turn (player or bot), by comparing the current Color in the turn and the color chosen by the player
return_player_type(PlayerColor, PlayerColor, player, _) :-!.
return_player_type(_, _, Difficulty, Difficulty).

% -------------------------------------------------------------------------------------------------------------------------

% ------------------------------------------------------ End of game ------------------------------------------------------

game_over(GameState, Player-Number) :-
    endOfGame(GameState),
    showFinalBoard(GameState),
    calculateWinner(GameState, Player, Number).                                                          

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

% ------------------------------------------------------ Calculate Results and Show Winner ------------------------------------------------------

% showResult(Board) -> Calculates the results of the final Board and show the winner of the game
showResult(Winner, Number) :-
    nl, write('The winner of the game is the '),
    player(Winner, String),
    write(String),
    write(' with a maximum group of '),
    write(Number), write(' Taijitus.'), nl.

% calculateWinner(Board, Player) -> Analyze the final Board and return the Player who has won the game
calculateWinner(Board, Player, Number) :-
    value(Board, white, NumberWhite),
    value(Board, black, NumberBlack),
    get_winner(NumberWhite, NumberBlack, Player, Number).

get_winner(NumberWhite, NumberBlack, Player, Number) :-
    NumberWhite > NumberBlack,
    Player = white, Number = NumberWhite, !.

get_winner(_, NumberBlack, Player, Number) :-
    Player = black, Number = NumberBlack.

% value(Color,  Board, NumberColor) -> Return in NumberColor the number of cells of the biggest group with color Color, in the Board
value(Board, Color, NumberColor) :-
    abolish(processed/2),
    assert(processed(-1, -1)),      % MELHOR MANEIRA DO QUE ESTA PARA PREDICADO EXISTIR??
    calculateLargestGroup(Color, 1-1, [], Board, 0, 0, NumberColor).

% value(Color,  Board, NumberColor) -> Return in NumberColor the number of cells of the biggest group with color Color, in the Board, which can be extended (it is not surrounded by other color)
best_possible_value(Board, Color, NumberColor, BiggestGroup) :-
    abolish(processed/2),
    assert(processed(-1, -1)),      % MELHOR MANEIRA DO QUE ESTA PARA PREDICADO EXISTIR??
    calculateLargestPossibleGroup(Color, 1-1, [], Board, 0, 0, NumberColor, [], BiggestGroup).

% calculateLargestGroup(Color, Cell, Queue, Board, AccNumber, MaxNumber, NumberColor) -> Searching groups of color Color, Cell being explored (format: Line-Column), Queue has the cells to process in the currnt group,
% Board is the final board, AccNumber has the number of cells processed of the current group, MaxNumber has the maximum number of cells of a group with color Color until the moment, NumberColor will have the number of cells of the biggest group of color Color

% Final Case -> Cell being explored is the last in the Board ([Length, Length]) : Copy BiggestNumber to NumberColor
calculateLargestGroup(_, Length-Length, [], Board, _, NumberColor, NumberColor) :-
    length(Board, Length).

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a not-processed cell with the desired Color : Process Cell and fill Queue with the next Cells of the group to process
calculateLargestGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor) :-
    get_value(L, C, Board, Color),
    \+ processed(L, C),
    assert(processed(L, C)),
    get_next_cells(Color, L, C, Board, List),
    List \= [],
    calculateLargestGroup(Color, L-C, List, Board, 1, BiggestNumber, NumberColor), !.

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a not-processed cell with different color of Color : Process Cell and explore the next cell
calculateLargestGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor) :-
    \+ get_value(L, C, Board, Color),
    \+ processed(L, C),
    assert(processed(L, C)),
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestGroup(Color, NewL-NewC, [], Board, 0, BiggestNumber, NumberColor), !.

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a cell already processed : Ignore cell, and explore next cell
calculateLargestGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor) :-
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestGroup(Color, NewL-NewC, [], Board, 0, BiggestNumber, NumberColor).

% Case where we're processing a group (Queue not empty, AccNumber \= 0), and adjacent cell is not processed : Process adjacent cell, increase AccNumber and add its adjacent cells to Queue
calculateLargestGroup(Color, L-C, [[OL, OC]|List], Board, AccNumber, BiggestNumber, NumberColor) :-
    \+ processed(OL, OC),
    assert(processed(OL, OC)),
    get_next_cells(Color, OL, OC, Board, NewCells),
    append(List, NewCells, NewList),                                                
    NewAccNumber is AccNumber + 1,
    calculateLargestGroup(Color, L-C, NewList, Board, NewAccNumber, BiggestNumber, NumberColor), !.

% Case where we're processing a group (Queue not empty, AccNumber \= 0), and adjacent cell is already processed : Ignore adjacent cell
calculateLargestGroup(Color, L-C, [[OL, OC]|List], Board, AccNumber, BiggestNumber, NumberColor) :-
    processed(OL, OC),
    calculateLargestGroup(Color, L-C, List, Board, AccNumber, BiggestNumber, NumberColor), !.

% Case where we finished processing a group (Empty Queue, AccNumber \= 0) : Substitute BiggestNumber, since the group found has a larger number of cells, and explore next cell
calculateLargestGroup(Color, L-C, [], Board, AccNumber, BiggestNumber, NumberColor) :-
    AccNumber > BiggestNumber,
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestGroup(Color, NewL-NewC, [], Board, 0, AccNumber, NumberColor), !.

% get_next_cells(Color, Row, Column, Board, List) -> return in List the adjacent cells to the cell [Row, Column] in the Board, with color Color
get_next_cells(Color, L, C, Board, List) :-
    NextL is L + 1, PreviousL is L - 1, NextC is C + 1, PreviousC is C - 1,
    get_value(PreviousL, C, Board, UpValue),
    get_value(NextL, C, Board, DownValue),
    get_value(L, PreviousC, Board, LeftValue),
    get_value(L, NextC, Board, RightValue),
    get_next([[PreviousL, C, UpValue], [NextL, C, DownValue], [L, PreviousC, LeftValue], [L, NextC, RightValue]], Color, [], List).

get_next([], _, List, List).
get_next([[L, C, Color]|Rest], Color, AccList, List) :-
    append(AccList, [[L, C]], NewList),
    \+ processed(L, C),
    get_next(Rest, Color, NewList, List), !.
get_next([[_, _, _]|Rest], Color, AccList, List) :-
    get_next(Rest, Color, AccList, List).

% -------------------------------------------------------------------------------------------------------------------------

next_difficulty(white, DifficultyWhite, _, DifficultyWhite).
next_difficulty(black, _, DifficultyBlack, DifficultyBlack).

% ----------------------------------------------------------- SE DER BORRADA APAGAR - TENTATIVA BOT MAIS INTELIGENTE --------------------------------------------------------------

% calculateLargestGroup(Color, Cell, Queue, Board, AccNumber, MaxNumber, NumberColor) -> Searching groups of color Color, Cell being explored (format: Line-Column), Queue has the cells to process in the currnt group,
% Board is the final board, AccNumber has the number of cells processed of the current group, MaxNumber has the maximum number of cells of a group with color Color until the moment, NumberColor will have the number of cells of the biggest group of color Color

% Final Case -> Cell being explored is the last in the Board ([Length, Length]) : Copy BiggestNumber to NumberColor
calculateLargestPossibleGroup(_, Length-Length, [], Board, _, NumberColor, NumberColor, _, _) :-
    length(Board, Length).

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a not-processed cell with the desired Color : Process Cell and fill Queue with the next Cells of the group to process
calculateLargestPossibleGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor, AccGroup, BiggestGroup) :-
    get_value(L, C, Board, Color),
    \+ processed(L, C),
    assert(processed(L, C)),
    get_next_cells(Color, L, C, Board, List),
    List \= [],
    calculateLargestPossibleGroup(Color, L-C, List, Board, 1, BiggestNumber, NumberColor, [L-C|AccGroup], BiggestGroup), !.

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a not-processed cell with different color of Color : Process Cell and explore the next cell
calculateLargestPossibleGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor, AccGroup, BiggestGroup) :-
    \+ get_value(L, C, Board, Color),
    \+ processed(L, C),
    assert(processed(L, C)),
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestPossibleGroup(Color, NewL-NewC, [], Board, 0, BiggestNumber, NumberColor, AccGroup, BiggestGroup), !.

% Case where we're not processing any group (Empty Queue, AccNumber = 0), and we find a cell already processed : Ignore cell, and explore next cell
calculateLargestPossibleGroup(Color, L-C, [], Board, 0, BiggestNumber, NumberColor, AccGroup, BiggestGroup) :-
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestPossibleGroup(Color, NewL-NewC, [], Board, 0, BiggestNumber, NumberColor, AccGroup, BiggestGroup).

% Case where we're processing a group (Queue not empty, AccNumber \= 0), and adjacent cell is not processed : Process adjacent cell, increase AccNumber and add its adjacent cells to Queue
calculateLargestPossibleGroup(Color, L-C, [[OL, OC]|List], Board, AccNumber, BiggestNumber, NumberColor, AccGroup, BiggestGroup) :-
    \+ processed(OL, OC),
    assert(processed(OL, OC)),
    get_next_cells(Color, OL, OC, Board, NewCells),
    append(List, NewCells, NewList),                                                
    NewAccNumber is AccNumber + 1,
    calculateLargestPossibleGroup(Color, L-C, NewList, Board, NewAccNumber, BiggestNumber, NumberColor, [OL-OC|AccGroup], BiggestGroup), !.

% Case where we're processing a group (Queue not empty, AccNumber \= 0), and adjacent cell is already processed : Ignore adjacent cell
calculateLargestPossibleGroup(Color, L-C, [[OL, OC]|List], Board, AccNumber, BiggestNumber, NumberColor, AccGroup, BiggestGroup) :-
    processed(OL, OC),
    calculateLargestPossibleGroup(Color, L-C, List, Board, AccNumber, BiggestNumber, NumberColor, AccGroup, BiggestGroup), !.

% Case where we finished processing a group (Empty Queue, AccNumber \= 0) : Substitute BiggestNumber, since the group found has a larger number of cells, and explore next cell
calculateLargestPossibleGroup(Color, L-C, [], Board, AccNumber, BiggestNumber, NumberColor, AccGroup, _) :-
    AccNumber > BiggestNumber,
    possible_to_increase(AccGroup, Board),
    length(Board, Length),
    Mod is mod(C, Length), NewC is Mod + 1,
    DivInt is div(C, Length), NewL is L + DivInt,
    calculateLargestPossibleGroup(Color, NewL-NewC, [], Board, 0, AccNumber, NumberColor, [], AccGroup), !.

possible_to_increase([], _) :- fail.
possible_to_increase([Cell|_], Board) :-
    possible_to_extend(Cell, Board), !.
possible_to_increase([_|BiggestGroup], Board) :-
    possible_to_increase(BiggestGroup, Board).

possible_to_extend(Cell, Board) :-
    adjacent_cell_empty(Cell, Board, Adjacent),
    adjacent_cell_empty(Adjacent, Board, _).

adjacent_cell_empty(L-C, Board, Adjacent) :-
    NextL is L + 1, PreviousL is L - 1, NextC is C + 1, PreviousC is C - 1,
    get_value(PreviousL, C, Board, UpValue),
    get_value(NextL, C, Board, DownValue),
    get_value(L, PreviousC, Board, LeftValue),
    get_value(L, NextC, Board, RightValue),
    ((UpValue == empty, Adjacent = PreviousL-C) ; (DownValue == empty, Adjacent = NextL-C) ; (LeftValue == empty, Adjacent = L-PreviousC) ; (RightValue == empty, Adjacent = L-NextC)).