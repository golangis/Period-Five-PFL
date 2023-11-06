:- use_module(library(lists)).
:- consult('utils.pl').
:- consult('board.pl').

/*
* player_won(+Board, +Player) 
* Checks if the player won the game.
*/
player_won(Board, Player) :-
    player_five_columns(Board, Player),
    player_five_colors(Board, Player).
/*
* count_in_column(+Array, +ColumnIndex, +Value, -Count) 
* Counts the number of times a given Value appears on a specified ColumnIndex on a given Array.
*/
count_in_column(Array, ColumnIndex, Value, Count) :-
    findall(Cell, (nth1(RowIndex, Array, Row), nth1(ColumnIndex, Row, Cell), Cell = Value), Cells),
    length(Cells, Count).
/*
* player_five_columns(+Board, +Player) 
* Checks if the player pieces (plus the cube) are on all 5 collumns of the board.
*/
player_five_columns(Board, Player) :-
    count_in_column(Board, 1, Player, 1),
    count_in_column(Board, 2, Player, 1),
    count_in_column(Board, 3, Player, 1),
    count_in_column(Board, 4, Player, 1),
    count_in_column(Board, 5, Player, 1).

/*
* player_piece_in_black(+Board, + Player)
* Function that checks if one of the player pieces (or the cube) is in at least all the a black square of the board.
*/    
player_piece_in_black(Board, Player) :- 
    nth1(1, Board, Row1), nth1(1, Row1, Player) ;
    nth1(2, Board, Row2), nth1(2, Row2, Player) ;  
    nth1(3, Board, Row3), nth1(3, Row3, Player) ; 
    nth1(4, Board, Row4), nth1(4, Row4, Player) ;  
    nth1(5, Board, Row5), nth1(5, Row5, Player). 

/*
* player_piece_in_red(+Board, + Player)
* Function that checks if one of the player pieces (or the cube) is in at least all the a red square of the board.
*/
player_piece_in_red(Board, Player) :-
    nth1(1, Board, Row1), nth1(2, Row1, Player) ;
    nth1(2, Board, Row2), nth1(3, Row2, Player) ;  
    nth1(3, Board, Row3), nth1(4, Row3, Player) ; 
    nth1(4, Board, Row4), nth1(5, Row4, Player) ;  
    nth1(5, Board, Row5), nth1(1, Row5, Player). 

/*
* player_piece_in_yellow(+Board, + Player)
* Function that checks if one of the player pieces (or the cube) is in at least all the a yellow square of the board.
*/
player_piece_in_yellow(Board, Player) :-
    nth1(1, Board, Row1), nth1(3, Row1, Player) ;
    nth1(2, Board, Row2), nth1(4, Row2, Player) ;  
    nth1(3, Board, Row3), nth1(5, Row3, Player) ; 
    nth1(4, Board, Row4), nth1(1, Row4, Player) ;  
    nth1(5, Board, Row5), nth1(2, Row5, Player). 

/*
* player_piece_in_purple(+Board, + Player)
* Function that checks if one of the player pieces (or the cube) is in at least all the a purple square of the board.
*/
player_piece_in_purple(Board, Player) :-
    nth1(1, Board, Row1), nth1(4, Row1, Player) ;
    nth1(2, Board, Row2), nth1(5, Row2, Player) ;  
    nth1(3, Board, Row3), nth1(1, Row3, Player) ; 
    nth1(4, Board, Row4), nth1(2, Row4, Player) ;  
    nth1(5, Board, Row5), nth1(3, Row5, Player). 

/*
* player_piece_in_blue(+Board, + Player)
* Function that checks if one of the player pieces (or the cube) is in at least all the a blue square of the board.
*/
player_piece_in_blue(Board, Player) :-
    nth1(1, Board, Row1), nth1(5, Row1, Player) ;
    nth1(2, Board, Row2), nth1(1, Row2, Player) ;  
    nth1(3, Board, Row3), nth1(2, Row3, Player) ; 
    nth1(4, Board, Row4), nth1(3, Row4, Player) ;  
    nth1(5, Board, Row5), nth1(4, Row5, Player). 
    

/*
* player_five_colors(+Board, + Player)
* Function that checks if the player pieces (plus the cube) are on all the 5 colors of the board.
*/
player_five_colors(Board, Player) :-
    player_piece_in_black(Board, Player),
    player_piece_in_red(Board, Player),
    player_piece_in_yellow(Board, Player),
    player_piece_in_purple(Board, Player),
    player_piece_in_blue(Board, Player).


count_true_conditions(0, []).
count_true_conditions(Count, [Condition | Rest]) :-
    Condition,
    count_true_conditions(SubCount, Rest),
    Count is SubCount + 1.
count_true_conditions(Count, [Condition | Rest]) :-
    count_true_conditions(Count, Rest).



rival_next_to_win(Board, Player) :-
    ConditionsColors = [
        player_piece_in_black(Board, Player),
        player_piece_in_red(Board, Player),
        player_piece_in_yellow(Board, Player),
        player_piece_in_purple(Board, Player),
        player_piece_in_blue(Board, Player)
    ],
    count_true_conditions(CountColors, ConditionsColors),
    CountColors = 4,
    ConditionsColumns = [
        count_in_column(Board, 1, Player, 1),
        count_in_column(Board, 2, Player, 1),
        count_in_column(Board, 3, Player, 1),
        count_in_column(Board, 4, Player, 1),
        count_in_column(Board, 5, Player, 1)
    ],
    count_true_conditions(CountColumns, ConditionsColumns),
    CountColumns = 4.

/*
*
* 
*/
cube_cant_move(Board, Player) :- 
    rival_next_to_win(Board, Player).
    %last_position()  .<- checar se posiçao igual à posiçao em que esteve na jogada anterior

%valid_moves(Board, Player, ListOfMoves) :-.

game_over(Board, Winner) :- 
    (player_won(Board, light), congratulate(light)), Winner is light; 
    (player_won(Board, dark), congratulate(dark)), Winner is dark.

congratulate(dark) :-
    nl, nl, write('Game over!'), nl, write('Dark won! Good luck next time, Light!'), nl,
    write('Type "e" to exit the intructions menu.'), nl,
    wait_for_e_to_exit.

congratulate(light) :-
    nl, nl, write('Game over!'), nl, write('Light won! Good luck next time, Dark!'), nl,
    write('Type "e" to exit the intructions menu.'), nl,
    wait_for_e_to_exit.


game_cycle(Board, Player) :-
    game_over(Board, Winner), !.

game_cycle(Board, Player) :-
    %choose_move(Board, Player, Move),
    take_turn(Board, Player, NewBoard, NextPlayer),
    write(NextPlayer),
    display_game(NewBoard),
    game_cycle(NewBoard, NextPlayer).




%         ------------- PERFORM MOVE -------------     %


replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

% To update the value at a specific (X,Y) position in a 2D list
update_board(Board, X, Y, NewValue, UpdatedBoard) :-
    nth0(Y, Board, Row),                 % Extract the specified row
    replace(Row, X, NewValue, NewRow),   % Use replace to set the NewValue
    replace(Board, Y, NewRow, UpdatedBoard).

% To move a piece from (StartX,StartY) to (EndX,EndY)
perform_move(Board, StartX, StartY, EndX, EndY, UpdatedBoard, Player, NextPlayer) :-
    nth0(StartY, Board, StartRow),                 % Get the start row
    nth0(StartX, StartRow, Piece),                 % Get the piece to move
    Piece \= empty,                                % Make sure the start is not empty
    (Piece = Player; Piece = cube),                % Make sure the piece belongs to the current player or is a cube
    nth0(EndY, Board, EndRow),                     % Get the end row
    nth0(EndX, EndRow, Destination),               % Check the destination cell
    Destination = empty,                           % Make sure the destination is empty
    (StartX == EndX; StartY == EndY), 
    path_clear(Board, StartX, StartY, EndX, EndY), % Check the path is clear
    update_board(Board, StartX, StartY, empty, TempBoard),  % Remove the piece
    update_board(TempBoard, EndX, EndY, Piece, UpdatedBoard),  % Place the piece
    next_player(Player, NextPlayer).               % Get the next player

ask_coordinates(StartX, StartY, EndX, EndY) :-
    write('Enter the Column of the piece to move: '), read(StartX),
    write('Enter the Row coordinate of the piece to move: '), read(StartY),
    write('Enter the Column coordinate of where to move the piece: '), read(EndX),
    write('Enter the Row coordinate of where to move the piece: '), read(EndY).

user_move(Board, Player, UpdatedBoard, NextPlayer) :-
    ask_coordinates(StartX, StartY, EndX, EndY),
    (
      perform_move(Board, StartX, StartY, EndX, EndY, UpdatedBoard, Player, NextPlayer) 
    -> true  % If the move is successful, proceed
    ; write('Invalid move, please try again.'), nl,  % If the move fails, ask again
      user_move(Board, Player, UpdatedBoard, NextPlayer)
    ).

take_turn(Board, Player, UpdatedBoard, NextPlayer) :-
    write(Player), write(' player turn.'), nl,
    user_move(Board, Player, UpdatedBoard, NextPlayer).

% Check if the path is clear between two points (not including endpoints)
path_clear(Board, StartX, StartY, EndX, EndY) :-
    (
        StartX == EndX -> 
        DiffY is EndY - StartY,
        DiffY > 0 -> vertical_clear(Board, StartX, StartY, EndY, 1);  % Moving down
        vertical_clear(Board, StartX, StartY, EndY, -1)  % Moving up
    );
    (
        StartY == EndY -> 
        DiffX is EndX - StartX,
        DiffX > 0 -> horizontal_clear(Board, StartY, StartX, EndX, 1);  % Moving right
        horizontal_clear(Board, StartY, StartX, EndX, -1)  % Moving left
    ).

% Check vertical path between two Y coordinates is clear on the given X coordinate
vertical_clear(_, _, EndY, EndY, _). % Reached end position
vertical_clear(Board, X, CurrentY, EndY, Step) :-
    NextY is CurrentY + Step,
    nth0(NextY, Board, Row),
    nth0(X, Row, Cell),
    Cell == empty, % The cell must be empty to be clear
    vertical_clear(Board, X, NextY, EndY, Step).

% Check horizontal path between two X coordinates is clear on the given Y coordinate
horizontal_clear(_, EndX, _, EndX, _). % Reached end position
horizontal_clear(Board, Y, CurrentX, EndX, Step) :-
    NextX is CurrentX + Step,
    nth0(Y, Board, Row),
    nth0(NextX, Row, Cell),
    Cell == empty, % The cell must be empty to be clear
    horizontal_clear(Board, Y, NextX, EndX, Step).