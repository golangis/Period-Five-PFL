/*
* wait_for_e_to_exit()
* When the character 'e' or 'E' are input the cycle is broken (used in the instructions menu)
*/
wait_for_e_to_exit :-
    get_char(InputChar),
    ((InputChar = 'e'; InputChar ='E') ->  % Check if the input is a newline character (Enter key)
        write('Exiting...'), nl, skip_line;
        wait_for_e_to_exit 
    ).

/*
* clear()
* Clears the screen (doesn't show previous characters)
*/
clear :- write('\e[2J').

/*
* read_number(+X)
* Reads integers - kudos https://github.com/ttoino/feup-pfl-proj2
*/
read_number(X) :- read_number(0, X).

read_number(X, X) :- peek_code(10), get_code(10), !.
read_number(Curr, Out) :-
    get_code(C),
    C >= 48,
    C =< 57,
    NewCurr is Curr * 10 + (C - 48),
    read_number(NewCurr, Out).