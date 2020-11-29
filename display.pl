% ------------------------------------------------------------------------------------------------------------------------- %
%                              Get the Symbol corresponding to each cell                                                    %
%   Prototype:                                                                                                              %
%       character(+Name, -Symbol)                                                                                           %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Name -> Name of the present Cell                                                                                    %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%       Symbol -> Symbol to be printed on screen                                                                            %
% ------------------------------------------------------------------------------------------------------------------------- %
character(empty, ' ').
character(black, 'X').    
character(white, 'O').

% ------------------------------------------------------------------------------------------------------------------------- %
%                                Get a string with the name of the current Player                                           %
%   Prototype:                                                                                                              %
%       player(+Player, -String)                                                                                            %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Name -> Name of the current Player                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%       Symbol -> String with the name of the current Player                                                                %
% ------------------------------------------------------------------------------------------------------------------------- %
player(white, 'White Player').
player(black, 'Black Player').


% ------------------------------------------------------------------------------------------------------------------------- %
%                                 Call the display_board and display_turn to be printed on screen                           %
%   Prototype:                                                                                                              %
%       display_game(+Gamestate, +Player)                                                                                   %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Gamestate -> Current board matrix                                                                                   %
%       Player -> Current Player                                                                                            %
%   Outputs:                                                                                                                %
%                                                                                                                           %
% ------------------------------------------------------------------------------------------------------------------------- %
display_game(Gamestate, Player) :- display_board(Gamestate), display_turn(Player).


% ------------------------------------------------------------------------------------------------------------------------- %
%                                  display the current board (Gamestate), with NxN dimensions                               %
%   Prototype:                                                                                                              %
%       display_board(+Gamestate)                                                                                           %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Gamestate -> Current board matrix                                                                                   %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%       Prints the current board to the screen                                                                              %
% ------------------------------------------------------------------------------------------------------------------------- %
display_board(Gamestate) :-
    length(Gamestate, N),
    nl, write('      '), print_numbers(1, N), 
    nl,
    write('    \x250c\'), print_top(N), % ┌
    nl, 
    print_matrix(Gamestate, 1, N),
    write('    \x2514\'), print_bot(N), % └
    nl, 
    !.

% ------------------------------------------------------------------------------------------------------------------------- %
%                             Display the Player to play in the current turns                                               %
%   Prototype:                                                                                                              %
%       display_turn(+Player)                                                                                               %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player -> Current Player                                                                                            %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%       Prints the current player to the screen                                                                             %
% ------------------------------------------------------------------------------------------------------------------------- %
display_turn(Player) :-
    player(Player, Name),
    character(Player, Symbol),
    nl, write(Name), write(' turn. ('), write(Symbol), write(')'), nl.


% ------------------------------------------------------------------------------------------------------------------------- %
%                                Prints a line of numbers, enumerating the columns                                          %
%   Prototype:                                                                                                              %
%        print_numbers(+Acc, +N)                                                                                              %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Acc -> Actual column number to print, starting from 1                                                               %
%       N -> Last column number                                                                                             %
%   Outputs:                                                                                                                %
%       Prints a line of numbers, enumerating the columns                                                                   %
% ------------------------------------------------------------------------------------------------------------------------- %
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


% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                %
%   Prototype:                                                                                                              %
%        print_matrix(Matrix, Acc, N)                                                                                       %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Matrix -> Current board matrix                                                                                      %
%       Acc -> Actual row line to print                                                                                     %
%       N -> Row/Column limit                                                                                               %
%   Outputs:                                                                                                                %
%       Prints matrix M to the screen                                                                                       %
% ------------------------------------------------------------------------------------------------------------------------- %
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

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints line from matrix to the screen                                        %
%   Prototype:                                                                                                              %
%        print_line(+Line)                                                                                                  %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Line -> Line to print to screen from Matrix                                                                         %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                                                                           %
% ------------------------------------------------------------------------------------------------------------------------- %
print_line([]) :- write('\x2502\').  % │
print_line([Cell|L]) :-
    character(Cell, C),
    write('\x2502\ '), write(C), write(' '), % │ C 
    print_line(L).


% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                %
%   Prototype:                                                                                                              %
%        print_limits(N)                                                                                                    %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                                           %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                                                                           %
% ------------------------------------------------------------------------------------------------------------------------- %
print_limits(A, A).
print_limits(_, 0) :- nl.
print_limits(_, N) :-
    write('    \x251c\'), % ├ 
    print_middle(N).

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_middle(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_middle(0) :- nl.
print_middle(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'), % ───
    print_middle_intersect(N),
    print_middle(N1).

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_top(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_top(0).
print_top(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'), % ───
    print_top_intersect(N),
    print_top(N1).

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_bot(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_bot(0).
print_bot(N) :-
    N > 0,
    N1 is N - 1,
    write('\x2500\\x2500\\x2500\'), % ───
    print_bot_intersect(N),
    print_bot(N1).

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_middle_intersect(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_middle_intersect(1) :-
    write('\x2524\'). % ┤
print_middle_intersect(_) :-
    write('\x253c\'). % ┼

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_top_intersect(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_top_intersect(1) :-
    write('\x2510\'). % ┐
print_top_intersect(_) :-
    write('\x252c\'). % ┬

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              prints matrix M to the screen                                                                            %
%   Prototype:                                                                                                              %
%        print_bot_intersect(N)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
print_bot_intersect(1) :-
    write('\x2518\'). % ┘
print_bot_intersect(_) :-
    write('\x2534\'). % ┴

% ------------------------------------------------------------------------------------------------------------------------- %
%                                              displays the FinalBoard, with no more possible moves left                                                                            %
%   Prototype:                                                                                                              %
%        pshowFinalBoard(NextBoard)                                                                                             %
%                                                                                                                           %
%   Inputs:                                                                                                                 %
%       Player ->                                                                                  %
%                                                                                                                           %
%   Outputs:                                                                                                                %
%                                                                     %
% ------------------------------------------------------------------------------------------------------------------------- %
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