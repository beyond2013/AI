# Credit: Contents generated using Claude 

# Week 4 Lab: A* Search for the 8-Puzzle
### (Google Colab Edition)

## Objective

Implement the A* search algorithm from lecture and apply it to the 8-Puzzle. You will implement two heuristics — **Misplaced Tiles** and **Manhattan Distance** — and empirically compare how many nodes each one causes A* to expand, connecting the theoretical idea of "heuristic strength" to a measurable result.

By the end of this lab you should be able to:
1. Represent the 8-Puzzle as a search problem (state, actions, transition model, goal test).
2. Implement A* using a priority queue ordered by `f(n) = g(n) + h(n)`.
3. Implement both heuristics and verify they are admissible.
4. Measure and compare node expansions across heuristics and puzzle difficulty.

## How to Use This Lab in Colab

1. Open a new notebook at [colab.research.google.com](https://colab.research.google.com).
2. This lab is organized into **numbered cells**. Create one Colab cell per numbered block below, in order — **Markdown cells** (📝) for headings/notes, **Code cells** (💻) for everything else.
3. Run each cell with `Shift + Enter` before moving to the next — later cells depend on functions and variables defined earlier, so skipping ahead will cause `NameError`s.
4. Cells marked **TODO** contain `pass` placeholders you must complete before running later cells that depend on them.
5. Keep this notebook open throughout — you'll add cells incrementally as you go through Sections 1–5.

---

## Section 1: Problem Representation

### 📝 Cell 1 (Markdown)
```
## 1. Problem Representation
State: tuple of 9 ints, 0 = blank, read left-to-right top-to-bottom.
Goal state: (1, 2, 3, 4, 5, 6, 7, 8, 0)
```

### 💻 Cell 2 (Code) — imports and constants

```python
import heapq
import itertools
import random

GOAL_STATE = (1, 2, 3, 4, 5, 6, 7, 8, 0)
```

### 💻 Cell 3 (Code) — Task 1.1: state helper functions

```python
def get_blank_position(state):
    """Return the index (0-8) of the blank tile (0) in the state tuple."""
    return state.index(0)

def get_neighbors(state):
    """
    Return a list of (new_state, action) pairs reachable from `state`
    by sliding one tile into the blank space.

    Actions should be one of: "Up", "Down", "Left", "Right"
    (direction the BLANK moves).
    """
    neighbors = []
    blank = get_blank_position(state)
    row, col = divmod(blank, 3)

    moves = {
        "Up":    (row - 1, col),
        "Down":  (row + 1, col),
        "Left":  (row, col - 1),
        "Right": (row, col + 1),
    }

    for action, (new_row, new_col) in moves.items():
        if 0 <= new_row < 3 and 0 <= new_col < 3:
            new_blank = new_row * 3 + new_col
            new_state = list(state)
            new_state[blank], new_state[new_blank] = new_state[new_blank], new_state[blank]
            neighbors.append((tuple(new_state), action))

    return neighbors

def is_goal(state):
    return state == GOAL_STATE
```

### 💻 Cell 4 (Code) — checkpoint, run immediately after Cell 3

```python
# Checkpoint: blank is in the bottom-right corner of GOAL_STATE,
# so only Up and Left should be valid moves.
neighbors = get_neighbors(GOAL_STATE)
print(neighbors)
assert len(neighbors) == 2, f"Expected 2 neighbors, got {len(neighbors)}"
print("Cell 3 checkpoint passed.")
```

---

## Section 2: Heuristics

### 📝 Cell 5 (Markdown)
```
## 2. Heuristics
Both heuristics must be admissible (never overestimate true cost)
for A* to guarantee an optimal solution.
```

### 💻 Cell 6 (Code) — Task 2.1: Misplaced Tiles **(TODO)**

```python
def misplaced_tiles(state):
    """
    Count tiles that are not in their goal position.
    The blank (0) does NOT count as a misplaced tile.
    """
    # TODO: implement
    # Hint: compare state[i] to GOAL_STATE[i] for each i, skip where state[i] == 0
    pass
```

### 💻 Cell 7 (Code) — Task 2.2: Manhattan Distance **(TODO)**

```python
def manhattan_distance(state):
    """
    Sum of the horizontal + vertical distance of every tile
    (excluding the blank) from its goal position.
    """
    # TODO: implement
    # Hint: for each tile value, find its current (row, col) and its
    # goal (row, col), and sum abs(row_diff) + abs(col_diff)
    pass
```

### 💻 Cell 8 (Code) — Task 2.3: sanity check, run after completing Cells 6–7

```python
test_state = (1, 2, 3, 4, 5, 6, 7, 0, 8)  # one move from goal

assert misplaced_tiles(test_state) <= 1, "Misplaced tiles should be ≤ actual distance"
assert manhattan_distance(test_state) <= 1, "Manhattan distance should be ≤ actual distance"
print("Cell 8 checkpoint passed.")
```

> **Discussion (answer in your lab report, not in a cell):** Why must `h(n) = 0` whenever `state == GOAL_STATE`, for both heuristics? What would break in A* if this weren't true?

---

## Section 3: A* Search Implementation

### 📝 Cell 9 (Markdown)
```
## 3. A* Search
Priority queue ordered by f(n) = g(n) + h(n), using heapq.
```

### 💻 Cell 10 (Code) — Task 3.1: A* search **(TODO)**

```python
def a_star_search(start_state, heuristic_fn):
    """
    Returns a dict with:
        "path": list of actions from start to goal
        "cost": number of moves in the solution
        "nodes_expanded": total number of nodes popped from the frontier
    """
    counter = itertools.count()  # tie-breaker for equal f-values
    frontier = []
    heapq.heappush(frontier, (heuristic_fn(start_state), next(counter), 0, start_state, []))
    # entry format: (f, tie_breaker, g, state, path_of_actions)

    best_g = {start_state: 0}
    nodes_expanded = 0

    while frontier:
        f, _, g, state, path = heapq.heappop(frontier)
        nodes_expanded += 1

        if is_goal(state):
            return {"path": path, "cost": g, "nodes_expanded": nodes_expanded}

        # TODO: skip this node if we've already found a better g for this state
        # (this handles the "explored with lower g" case from the A* pseudocode)

        for neighbor_state, action in get_neighbors(state):
            new_g = g + 1  # each move costs 1

            # TODO: if neighbor_state is new OR new_g is better than best_g.get(neighbor_state, inf):
            #   - update best_g[neighbor_state]
            #   - compute new_f = new_g + heuristic_fn(neighbor_state)
            #   - push (new_f, next(counter), new_g, neighbor_state, path + [action]) onto frontier
            pass

    return {"path": None, "cost": None, "nodes_expanded": nodes_expanded}  # no solution found
```

> **Why the tie-breaker counter?** Tuples in the heap are compared element-by-element. If two entries have the same `f`, Python will try to compare `state` tuples next, which works, but comparing `path` lists too early can cause errors when states are otherwise equal. The counter guarantees a stable, error-free ordering. This is a Python implementation detail, not a search-theory concept.

### 💻 Cell 11 (Code) — quick smoke test, run after completing Cell 10

```python
easy_state = (1, 2, 3, 4, 5, 6, 7, 0, 8)  # one move from goal
result = a_star_search(easy_state, manhattan_distance)
print(result)
assert result["cost"] == 1, f"Expected cost 1, got {result['cost']}"
print("Cell 11 checkpoint passed.")
```

---

## Section 4: Testing

### 📝 Cell 12 (Markdown)
```
## 4. Testing
Generate solvable scrambles of increasing difficulty, then compare heuristics.
```

### 💻 Cell 13 (Code) — Task 4.1: solvability check

```python
def is_solvable(state):
    """
    A state is solvable iff the number of inversions (pairs of tiles,
    ignoring the blank, that are out of order relative to the goal)
    is even.
    """
    tiles = [t for t in state if t != 0]
    inversions = 0
    for i in range(len(tiles)):
        for j in range(i + 1, len(tiles)):
            if tiles[i] > tiles[j]:
                inversions += 1
    return inversions % 2 == 0
```

### 💻 Cell 14 (Code) — Task 4.2: scramble generator

```python
def generate_scramble(num_moves, seed=None):
    if seed is not None:
        random.seed(seed)
    state = GOAL_STATE
    for _ in range(num_moves):
        neighbors = get_neighbors(state)
        state, _ = random.choice(neighbors)
    return state
```

### 💻 Cell 15 (Code) — Task 4.3: run the comparison

```python
def run_comparison(num_moves_list, trials_per_level=5):
    results = []
    for num_moves in num_moves_list:
        for trial in range(trials_per_level):
            start = generate_scramble(num_moves, seed=trial * 1000 + num_moves)

            result_misplaced = a_star_search(start, misplaced_tiles)
            result_manhattan = a_star_search(start, manhattan_distance)

            results.append({
                "scramble_depth": num_moves,
                "trial": trial,
                "misplaced_nodes": result_misplaced["nodes_expanded"],
                "manhattan_nodes": result_manhattan["nodes_expanded"],
                "solution_cost": result_misplaced["cost"],  # should match manhattan's cost too
            })
    return results

# Suggested test range: start small, since Misplaced Tiles gets very slow
# on harder puzzles.
results = run_comparison(num_moves_list=[5, 10, 15, 20], trials_per_level=5)

for r in results:
    print(r)
```

> **Checkpoint:** For every trial, `misplaced_nodes`'s corresponding `solution_cost` and Manhattan's cost should be **identical** — both heuristics are admissible, so both must return an optimal solution. They should only differ in nodes expanded, never in solution length. If costs differ, you have a bug in Cell 6, 7, or 10.

### 💻 Cell 16 (Code) — table and chart (uses `pandas` and `matplotlib`, both preinstalled in Colab)

```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.DataFrame(results)
summary = df.groupby("scramble_depth")[["misplaced_nodes", "manhattan_nodes"]].mean()
print(summary)

summary.plot(marker="o")
plt.xlabel("Scramble Depth (moves from goal)")
plt.ylabel("Average Nodes Expanded")
plt.title("A* Node Expansion: Misplaced Tiles vs. Manhattan Distance")
plt.legend(["Misplaced Tiles", "Manhattan Distance"])
plt.show()
```

---

## Section 5: Analysis (answer in a text cell or your lab report)

### 📝 Cell 17 (Markdown) — write your answers directly in this cell

```
## 5. Analysis

1. Table: [paste your Cell 16 output/table here]
2. Chart: [Colab will keep the plot output attached to Cell 16 —
   reference it here, no need to duplicate it]
3. Answers:
   - At what scramble depth does the gap between the two heuristics
     become clearly visible? Why does the gap widen as depth increases
     rather than staying constant?
   - Manhattan Distance is provably ≥ Misplaced Tiles for every state.
     Using the lecture's definition of admissibility, explain why a
     higher admissible heuristic is not a violation of admissibility,
     and why it leads to fewer node expansions.
   - (Optional) Try increasing scramble depth until Misplaced Tiles
     becomes impractically slow. Does Manhattan Distance hit the same
     wall at the same depth?
```

---

## Submission Checklist

- [ ] Notebook has all 17 cells, run top to bottom with no errors (`Runtime → Run all` in Colab should complete cleanly)
- [ ] `get_neighbors`, `misplaced_tiles`, `manhattan_distance` implemented and passing the Cell 4 and Cell 8 checkpoints
- [ ] `a_star_search` implemented and passing the Cell 11 checkpoint
- [ ] Comparison run across at least 4 scramble depths, 5 trials each (Cell 15)
- [ ] Table and chart generated in Cell 16
- [ ] Section 5 analysis answered in Cell 17
- [ ] Share your Colab notebook link with **"Anyone with the link can view"** enabled, and submit the link