:- consult('board.pl').
:- consult('play.pl').

main_menu :-
    write('╭─────────────────────────────────────╮'), nl,
    write('│                                     │'), nl,
    write('│         WELCOME TO PERIOD 5         │'), nl,
    write('│                                     │'), nl,
    write('├─────────────────────────────────────┤'), nl,
    write('│                                     │'), nl,
    write('│    1. Game (Player-Player)          │'), nl,
    write('│    2. Game (Player-Computer)        │'), nl,
    write('│    3. Game (Computer-Computer)      │'), nl,
    write('│    4. Instructions                  │'), nl,
    write('│    5. Quit                          │'), nl,
    write('│                                     │'), nl,
    write('╰─────────────────────────────────────╯'), nl,
    write('Enter your choice (1-5).'), nl.


handle_main_menu_choice(1) :- start_player_vs_player_game.
handle_main_menu_choice(2) :- start_player_vs_player_game.%start_player_vs_computer_game.
handle_main_meu_choice(3) :- start_player_vs_player_game.%computer_player_vs_computer_game.
handle_main_menu_choice(4) :- display_instructions.
handle_main_menu_choice(5) :- quit_game.
handle_main_menu_choice(Choice) :- 
    Choice \== 1, Choice \== 2, Choice \==3, Choice \==4, Choice \== 5,
    write('Invalid choice. Please enter a valid option.'), nl,
    main_menu.

start_player_vs_player_game :-
    initial_state(Board, Player),
    show_board(Board),
    game_cycle(Board).

display_instructions :-
    clear,
    write('╭─────────────────────────────────────────────────╮'), nl,
    write('│                                                 │'), nl,
    write('│             PERIOD 5 - INSTRUCTIONS             │'), nl,
    write('│                                                 │'), nl,
    write('├─────────────────────────────────────────────────┤'), nl,
    write('│                                                 │'), nl,
    write('│  Period 5 is played on a square board with 5x5  │'), nl,
    write('│  squares painted in 5 different colors.         │'), nl,
    write('│                                                 │'), nl,
    write('│  There are two players, each having 4 pieces.   │'), nl,
    write('│  There is also an additional piece - the cube.  │'), nl,
    write('│                                                 │'), nl,
    write('│  OBJECTIVE: A player wins the game when his     │'), nl,
    write('│             pieces and the cube can be found    │'), nl,
    write('│             in every column of the board and    │'), nl,
    write('│             on each of the 5 different colors.  │'), nl,
    write('│             Rows do not matter.                 │'), nl,
    write('│                                                 │'), nl,
    write('│  PLAY: Players move alternately one of their    │'), nl,
    write('│        pieces or the cube per turn, starting    │'), nl,
    write('│        with the player controlling the light    │'), nl,
    write('│        pieces. All pieces and the cube are      │'), nl,
    write('│        able to move orthogonally any number     │'), nl,
    write('│        of empty spaces. They may not jump       │'), nl,
    write('│        over other pieces or land on an          │'), nl,
    write('│        occupied square.                         │'), nl,
    write('│                                                 │'), nl,
    write('│      RESTRICTIONS ON THE MOVEMENT OF CUBE       │'), nl,
    write('│                                                 │'), nl,
    write('│   1)   When the cube is moved, it cannot        │'), nl,
    write('│       immediately returned back to the same     │'), nl,
    write('│       square by the next player.                │'), nl,
    write('│   2)   The cube cannot be moved if the other    │'), nl,
    write('│       player threatens to win on his next move. │'), nl,
    write('│                                                 │'), nl,
    write('╰─────────────────────────────────────────────────╯'), nl, nl,
    write('Type "e" to exit the intructions menu.'), nl,
    wait_for_e_to_exit.

/*
* quit_game()
* Quits the game.
*/
quit_game :-
    write('Goodbye! Thanks for playing.'), nl,
    halt.


main :-
    repeat,
    main_menu,
    read(Choice),
    handle_main_menu_choice(Choice),
    Choice = 5, !.
    
/*
* clear()
* Clears the screen (doesn't show previous characters)
*/
clear :- write('\e[2J').

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