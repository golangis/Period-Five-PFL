:- use_module(library(lists)).

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
