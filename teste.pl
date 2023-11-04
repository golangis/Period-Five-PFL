:- use_module(library(lists)).


% Define a predicate to check if a value appears at the specified positions
value_in_Board(Value, Board) :-
    nth1(1, Board, Row1), nth1(1, Row1, Value) ;
    nth1(2, Board, Row2), nth1(2, Row2, Value) ;  
    nth1(3, Board, Row3), nth1(3, Row3, Value) ; 
    nth1(4, Board, Row4), nth1(4, Row4, Value) ;  
    nth1(5, Board, Row5), nth1(5, Row5, Value). 


% Example usage
% Define a sample Board
sample_board([[1, 2, 3, 4, 5],
              [6, 7, 8, 9, 10],
              [11, 12, 13, 14, 15],
              [16, 17, 18, 19, 20],
              [21, 22, 23, 24, 25]]).

