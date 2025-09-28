# Prolog Water Jug Problem Solver (4 & 3 Gallons)

This project implements the classic **Water Jug Puzzle** using Prolog, showcasing a simple yet effective application of **state-space search** in logic programming.

---

## Problem Overview

The Water Jug Problem is a fundamental task in Artificial Intelligence used to illustrate **automated planning and search techniques**.

### Problem Statement

Given two unmarked jugs with fixed capacities:

- A **4-gallon jug**  
- A **3-gallon jug**  

Find a sequence of pouring and filling actions (a plan) to result in **exactly 2 gallons of water in either jug**, starting with both jugs empty.

### State Representation

A state is represented by the term `state(G4, G3)`, where:

- `G4`: Amount of water in the 4-gallon jug (0 to 4).  
- `G3`: Amount of water in the 3-gallon jug (0 to 3).  

| State Predicate | Value |
|-----------------|-------|
| Initial State   | `state(0, 0)` |
| Goal State      | Any state where `G4 = 2` or `G3 = 2` |

---

## Algorithm and Implementation Details

The solution uses a **Depth-First Search (DFS)** algorithm with explicit path tracking to avoid infinite loops and find a sequence of moves from the initial state to the goal state.

### Core Predicates

| Predicate | Arity | Description |
|-----------|-------|------------|
| `find_plan(Plan)` | 1 | The main entry point; starts the search and returns the action sequence. |
| `dfs(State, Visited, Actions, Plan)` | 4 | Recursive search algorithm. `Visited` list prevents cycles. |
| `move(Old, New, ActionName)` | 3 | Defines all 8 legal water-jug transitions (rules) from `Old` state to `New` state. |
| `jug_capacity(J, C)` | 2 | Defines the fixed capacities (4 and 3 gallons). |

### Key Search Mechanisms

- **State Transition (`move/3`)**: Declaratively defines the eight physical operations (Fill, Empty, Pour) using arithmetic and comparison checks.  
  Pouring actions use Prolog's `is` operator to calculate new water levels.

- **Loop Prevention**: The `Visited` list stores all states encountered in the current search path.  
  ```prolog
  \+ member(NewState, Visited)
ensures the algorithm does not revisit a state, preventing cycles and guaranteeing termination.

Goal Check: The goal_state/1 predicate immediately succeeds if the 4-gallon jug or the 3-gallon jug contains 2 gallons.

### Applications, Use Cases, and Sample Execution
#### Applications & Use Cases
The state-space search approach used here is versatile and applicable to many symbolic AI problems:

**Robotics / Planning**: Generating a plan (sequence of movements) for an automated system (e.g., Blocks World).

**Game Solving**: Finding optimal solutions for state-based games like N-Puzzle, Rubik's Cube, or Chess.

**Logic Puzzles**: Solving constraint-based problems like Sudoku or the N-Queens puzzle (often with Prolog's Constraint Logic Programming extensions).

**Routing / Navigation**: Finding the shortest or most efficient path through a network.

#### Sample Execution
To run the solver:

Copy the entire Prolog code block into any standard Prolog environment (e.g., SWISH, SWI-Prolog, or Tutorialspoint Prolog compiler).

In the Prolog query prompt, execute the test predicate:

`?- test_water_jug.`
Press Enter to see the plan to get exactly 2 gallons in either jug.
