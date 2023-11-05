/*
* wait_for_e_to_exit()
* When the character 'e' or 'E' are input the cycle is broken (used in the instructions menu)
*/
wait_for_e_to_exit :-
    get_char(InputChar),
    ((InputChar = 'e'; InputChar ='E') ->  % Check if the input is a newline character (Enter key)
        write('Exiting...'), nl;  
        wait_for_e_to_exit 
    ).

/*
* clear()
* Clears the screen (doesn't show previous characters)
*/
clear :- write('\e[2J').
