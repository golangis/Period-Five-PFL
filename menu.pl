:- consult('board.pl').

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
    initial_state(Board),
    show_board(Board),
    write('Player vs Player game is starting...'), nl.

display_instructions :-
    write('These are the game instructions.'), nl.

quit_game :-
    write('Goodbye! Thanks for playing.'), nl,
    halt.

main :-
    repeat,
    main_menu,
    read(Choice),
    handle_main_menu_choice(Choice),
    Choice = 5, !.
    

