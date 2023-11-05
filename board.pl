initial_state([
        [empty, dark, empty, empty, empty],
        [light, empty, dark, empty, empty],
        [empty, light, cube, dark,  empty],
        [empty, empty, light, empty, dark],
        [empty, empty, empty, light, empty] ], light) :- !.

next_player(light, dark).
next_player(dark, light).

show_piece(empty) :- write('       ').
show_piece(cube) :- write('   ■   ').
show_piece(dark) :- write('   ●   ').
show_piece(light):- write('   □   ').

show_cells([]) :- !.
show_cells([Cell | Line]) :-
    show_piece(Cell), write('│'), show_cells(Line).


display_game([Line5, Line4, Line3, Line2, Line1]) :-
    nl, 
    write('       │       │       │       │       │       │'), nl,
    write('       │   A   │   B   │   C   │   D   │   E   │'), nl,
    write('       ╰───────┴───────┴───────┴───────┴───────╯'), nl,
    write('────╮  ╭───────┬───────┬───────┬───────┬───────╮  ╭─────  '), nl,
    write('    │  │ BLACK │  RED  │YELLOW │PURPLE │  BLUE │  │'), nl,
    write(' 5  │  │'), show_cells(Line5),           write('  │  5'), nl,
    write('    │  │ BLACK │  RED  │YELLOW │PURPLE │  BLUE │  │'), nl,
    write('────┤  ├───────┼───────┼───────┼───────┼───────┤  ├─────'), nl,
    write('    │  │  BLUE │ BLACK │  RED  │YELLOW │PURPLE │  │'), nl,
    write(' 4  │  │'), show_cells(Line4),           write('  │  4'), nl,
    write('    │  │  BLUE │ BLACK │  RED  │YELLOW │PURPLE │  │'), nl,
    write('────┤  ├───────┼───────┼───────┼───────┼───────┤  ├─────'), nl,
    write('    │  │PURPLE │  BLUE │ BLACK │  RED  │YELLOW │  │'), nl,
    write(' 3  │  │'), show_cells(Line3),           write('  │  3'), nl,
    write('    │  │PURPLE │  BLUE │ BLACK │  RED  │YELLOW │  │'), nl,
    write('────┤  ├───────┼───────┼───────┼───────┼───────┤  ├─────'), nl,
    write('    │  │YELLOW │PURPLE │  BLUE │ BLACK │  RED  │  │'), nl,
    write(' 2  │  │'), show_cells(Line2),           write('  │  2'), nl,
    write('    │  │YELLOW │PURPLE │  BLUE │ BLACK │  RED  │  │'), nl,
    write('────┤  ├───────┼───────┼───────┼───────┼───────┤  ├─────'), nl,
    write('    │  │  RED  │YELLOW │PURPLE │  BLUE │ BLACK │  │'), nl,
    write(' 1  │  │'), show_cells(Line1),           write('  │  1'), nl,
    write('    │  │  RED  │YELLOW │PURPLE │  BLUE │ BLACK │  │'), nl,
    write('────╯  ╰───────┴───────┴───────┴───────┴───────╯  ╰─────'), nl,
    write('       ╭───────┬───────┬───────┬───────┬───────╮'), nl,
    write('       │   A   │   B   │   C   │   D   │   E   │'), nl,
    write('       │       │       │       │       │       │'), nl.

