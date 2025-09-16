jug_capacity(4, 4).
jug_capacity(3, 3).

initial_state(state(0, 0)).
goal_state(state(G4, G3)) :- G4 = 2 ; G3 = 2. % Goal: Get 2 gallons in either jug.

find_plan(Plan) :-
    initial_state(Init),
    dfs(Init, [Init], [], Plan).

dfs(State, _, Actions, Plan) :-
    goal_state(State),
    reverse(Actions, Plan).

dfs(State, Visited, Actions, Plan) :-
    move(State, NewState, ActionName),
    \+ member(NewState, Visited),
    dfs(NewState, [NewState|Visited], [ActionName|Actions], Plan).
% move(OldState, NewState, ActionDescription)

move(state(G4, G3), state(4, G3), fill_4_gal) :-
    jug_capacity(4, C4), G4 < C4.

move(state(G4, G3), state(G4, 3), fill_3_gal) :-
    jug_capacity(3, C3), G3 < C3.

move(state(G4, G3), state(0, G3), empty_4_gal) :-
    G4 > 0.

move(state(G4, G3), state(G4, 0), empty_3_gal) :-
    G3 > 0.

move(state(G4, G3), state(NewG4, 3), pour_4_to_3_until_3_full) :-
    G4 > 0, 
    G3 < 3,
    Transfer is 3 - G3,    
    G4 >= Transfer,        
    NewG4 is G4 - Transfer.

move(state(G4, G3), state(4, NewG3), pour_3_to_4_until_4_full) :-
    G3 > 0, 
    G4 < 4,
    Transfer is 4 - G4,    
    G3 >= Transfer,         
    NewG3 is G3 - Transfer.

move(state(G4, G3), state(0, NewG3), pour_all_4_to_3) :-
    G4 > 0,
    G3 < 3,
    Total is G4 + G3,
    Total =< 3, 
    NewG3 is Total.

move(state(G4, G3), state(NewG4, 0), pour_all_3_to_4) :-
    G3 > 0,
    G4 < 4,
    Total is G4 + G3,
    Total =< 4, 
    NewG4 is Total.

reverse(List, Reversed) :-
    reverse(List, [], Reversed).

reverse([], Acc, Acc).
reverse([H|T], Acc, Reversed) :-
    reverse(T, [H|Acc], Reversed).

test_water_jug :-
    writeln('--- Water Jug Problem (4 & 3 gal to get 2 gal) ---'),
    ( find_plan(Plan) ->
        format('SUCCESS! Plan (~w steps):~n', [length(Plan)]),
        write_plan(Plan)
    ;
        writeln('FAILED - No solution found')
    ).

write_plan([]) :- !.
write_plan([H|T]) :-
    format('  - ~w~n', [H]),
    write_plan(T).
