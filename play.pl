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
    move_piece(Board, Player, NewBoard),
    next_player(Player, NextPlayer),
    write(NextPlayer),
    display_game(NewBoard),
    game_cycle(NewBoard, NextPlayer).

% Update your move_piece predicate to handle player turns and implement the conversion
move_piece(Board, Player, NewBoard) :-
    write('Enter the start Column (1-5): '),
    read(StartX),
    % input_to_index(StartXChar, StartX),
    write('Enter the start Row (1-5): '),
    read(StartY),
    write('Enter the end Column (1-5): '),
    read(EndX),
    % input_to_index(EndXChar, EndX),
    write('Enter the end Row (1-5): '),
    read(EndY),

    % Validate the move with the player in mind
    ( validate_move(Board, Player, StartX, StartY, EndX, EndY) ->
        % If the move is valid, perform it
        perform_move(Board, StartX, StartY, EndX, EndY, UpdatedBoard),
        % Output the updated board
        show_board(UpdatedBoard),
        % Return the new state of the board
        NewBoard = UpdatedBoard
    ;
        % If the move is invalid, notify the user and ask again
        write('Invalid move, try again.'), nl,
        move_piece(Board, Player, NewBoard)
    ).

% Validate the move
validate_move(Board, Player, StartX, StartY, EndX, EndY) :-
    % Make sure the move is within the bounds of the board.
    within_bounds(StartX, StartY),
    within_bounds(EndX, EndY),
    % Make sure the start and end positions are different.
    (StartX, StartY) \= (EndX, EndY),
    % Ensure that there is a piece at the start position.
    piece_at(Board, StartX, StartY, Piece),
    Piece \= empty,
    % Ensure that the end position is empty or the moving piece is the cube.
    (Piece \= cube -> piece_at(Board, EndX, EndY, empty); true),
    % Ensure the piece belongs to the player or it is the cube.
    (Piece == cube; owns_piece(Player, Piece)),
    % Make sure the path between the start and end positions is clear.
    path_clear(Board, StartX, StartY, EndX, EndY),
    % Cube-specific rules
    (Piece \= cube ; (
        % The cube cannot be returned to the same position.
        \+cube_just_moved(EndX, EndY),
        % The cube cannot be moved if the other player threatens to win on the next move.
        \+threatens_to_win(Board, Player)
    )).

% Stub for cube_just_moved - Implement the logic based on your previous move tracking
cube_just_moved(EndX, EndY) :-
    % You need logic to remember where the cube was moved last, possibly by having a dynamic predicate
    % that gets updated with the cube's last position after every move.
    % For simplicity, assume there's a predicate cube_last_position(LastX, LastY) that stores this.
    cube_last_position(LastX, LastY),
    LastX == EndX, LastY == EndY.

% Stub for threatens_to_win - Implement the logic to check if a move threatens to win
threatens_to_win(Board, Player) :-
    % Define the conditions that would mean a player threatens to win.
    % This is a complex condition that depends on your game logic.
    % It should check if by moving the cube, the opponent can win on their next move.
    % For now, we will assume this check is done elsewhere and always fail it here.
    false.

% Stub for path_clear - check if the path is clear (no jumping over pieces)
path_clear(Board, StartX, StartY, EndX, EndY) :-
    % You need to ensure there's no piece in the way in the path from start to end.
    % This will depend on whether the move is vertical or horizontal.
    % Implement the check based on your game's movement rules.
    % For now, this is a placeholder that always succeeds.
    true.

% Stub for owns_piece - checks if the player owns the piece
owns_piece(Player, Piece) :-
    % This should check if the piece at the start belongs to the player making the move.
    % Implement this according to your game's logic of which player owns which pieces.
    % For now, assume a simple check based on your description.
    (Player == light -> Piece == light; Piece == dark).

% Check if a position is within the bounds of the board.
within_bounds(X, Y) :-
    X >= 1, X =< 5, % Assuming A-E are represented as 'A' to 'E'
    Y >= 1, Y =< 5.

% Replace this with the actual logic to find a piece at a given position
piece_at(Board, X, Y, Piece) :-
    % You need to convert X from 'A' to 'E' to 1-5 if it's not already in numeric form.
    % Then access the Board using the indices to get the Piece.
    % For now, we'll assume it always succeeds.
    true.


%         ------------- PERFORM MOVE -------------     %

% Perform the actual move on the board
perform_move(Board, StartX, StartY, EndX, EndY, UpdatedBoard) :-
    % Translate X/Y coordinates to 0-indexed list indices
    IndexXStart is StartX - 1,
    IndexYStart is StartY - 1,
    IndexXEnd is EndX - 1,
    IndexYEnd is EndY - 1,

    write('IndexXStart: '), write(IndexXStart), nl,
    write('IndexYStart: '), write(IndexYStart), nl,
    write('IndexXEnd: '), write(IndexXEnd), nl,
    write('IndexYEnd: '), write(IndexYEnd), nl,
    % Retrieve the piece at the starting position.
    matrix_element(Board, IndexYStart, IndexXStart, Piece),
    % Set the starting position to empty and place the piece at the ending position.
    set_matrix_element(Board, IndexYStart, IndexXStart, empty, TempBoard),
    set_matrix_element(TempBoard, IndexYEnd, IndexXEnd, Piece, UpdatedBoard).

% Set an element in a matrix at the given Row and Col index.
set_matrix_element([Row|RestRows], 0, Col, Elem, [NewRow|RestRows]) :-
    % We are at the correct row, now we replace the column element.
    replace_nth(Row, Col, Elem, NewRow).

set_matrix_element([Row|RestRows], RowIndex, Col, Elem, [Row|NewRestRows]) :-
    % We are not yet at the correct row, continue to the next.
    RowIndex > 0,
    NewRowIndex is RowIndex - 1,
    set_matrix_element(RestRows, NewRowIndex, Col, Elem, NewRestRows).

% Replace the nth element in a list with a new element.
replace_nth([_|T], 0, Elem, [Elem|T]).
replace_nth([H|T], I, Elem, [H|R]) :-
    I > 0, % Ensure index is positive
    NI is I-1, % Decrease index by 1
    replace_nth(T, NI, Elem, R).

% Get an element from the matrix at the given Row and Col index.
matrix_element(Board, RowIndex, ColIndex, Element) :-
    nth0(RowIndex, Board, Row),       % Retrieve the specified row from the board
    nth0(ColIndex, Row, Element).     % Retrieve the specified element from the row
    replace_nth(T, NI, Elem, R).

% Get an element from the matrix at the given Row and Col index.
matrix_element(Board, RowIndex, ColIndex, Element) :-
    nth0(RowIndex, Board, Row),       % Retrieve the specified row from the board
    nth0(ColIndex, Row, Element).     % Retrieve the specified element from the row



