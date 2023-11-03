:- use_module(library(lists)).

count_in_column(Array, ColumnIndex, Value, Count) :-
    findall(Cell, (nth1(RowIndex, Array, Row), nth1(ColumnIndex, Row, Cell), Cell = Value), Cells),
    length(Cells, Count).

player_won(Board, Player) :-
    player_five_columns(Board, Player),
    player_five_colors(Board, Player).

player_five_columns(Board, Player) :-
    [count_in_column(Board, 1, Player, Count),
     count_in_column(Board, 2, Player, Count),
     count_in_column(Board, 3, Player, Count),
     count_in_column(Board, 4, Player, Count),
     count_in_column(Board, 5, Player, Count),
    ] = [1, 1, 1, 1, 1].
    

%player_five_colors(Board, Player) :-

