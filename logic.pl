% makeMove(Player, CurrentBoard, NextPlayer, NextBoard) -> 
makeMove(Player, CurrentBoard, NextPlayer, NextBoard) :-
    length(CurrentBoard, Length),
    nl, write('Choose a cell for the white part of the Taijitu :'), nl, nl,
    write('Row? '),
    input(L, 1, Length, 'Row? ', move),
    write('Collumn? '),
    input(C, 1, Length, 'Collumn? ', move),
    write('Orientation of the black part (Up-1, Down-2, Left-3, Right-4)? '),
    input(O, 1, 4, 'Orientation of the black part? ', move),
    write('Chosen cell ['), write(L), write(', '), write(C), write(', '), write(O), write(']'), nl,
    %valid_move(L, C, O),      IMPLEMENTAR
    NextPlayer = Player, NextBoard = CurrentBoard.