# Practical Lab: Uninformed Search

## Problem Statement

An intelligent agent must navigate through a 2D maze from a start cell to a goal cell.

The maze will be represented using:

```text
0 = Open cell
1 = Wall
```

Example:

```python
maze = [
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0],
    [0, 1, 1, 1, 0]
]

start = (0, 0)
goal = (4, 4)
```

The agent can move:

```text
UP
DOWN
LEFT
RIGHT
```

---

# Python Representation of Movements

We represent movements using row and column changes.

```python
directions = [
    (-1, 0),   # up
    (1, 0),    # down
    (0, -1),   # left
    (0, 1)     # right
]
```

For example:

```text
(-1, 0) → Move one row upward
(1, 0)  → Move one row downward
(0, -1) → Move one column left
(0, 1)  → Move one column right
```

---

# Checking Whether a Move Is Valid

A move is valid if:

1. The new position is inside the maze.
2. The new position is not a wall.

```python
def valid_move(maze, row, col):

    rows = len(maze)
    cols = len(maze[0])

    return (
        0 <= row < rows
        and 0 <= col < cols
        and maze[row][col] == 0
    )
```

---

# BFS Implementation

Python's `deque` provides an efficient queue.

```python
from collections import deque


def bfs(maze, start, goal):

    directions = [
        (-1, 0),   # up
        (1, 0),    # down
        (0, -1),   # left
        (0, 1)     # right
    ]

    frontier = deque([(start, [start])])
    visited = {start}

    max_frontier = 1

    while frontier:

        max_frontier = max(
            max_frontier,
            len(frontier)
        )

        current, path = frontier.popleft()

        if current == goal:
            return path, max_frontier

        row, col = current

        for dr, dc in directions:

            nr = row + dr
            nc = col + dc

            neighbor = (nr, nc)

            if (
                valid_move(maze, nr, nc)
                and neighbor not in visited
            ):

                visited.add(neighbor)

                frontier.append(
                    (neighbor, path + [neighbor])
                )

    return None, max_frontier
```

---

# Understanding the BFS Implementation

The critical line is:

```python
current, path = frontier.popleft()
```

`popleft()` removes the oldest item from the queue.

Therefore:

```text
First inserted
      ↓
First removed
```

This implements FIFO behavior.

That is the defining feature of BFS.

---

# DFS Implementation

For DFS, we can use a Python list as a stack.

```python
def dfs(maze, start, goal):

    directions = [
        (-1, 0),   # up
        (1, 0),    # down
        (0, -1),   # left
        (0, 1)     # right
    ]

    frontier = [(start, [start])]
    visited = {start}

    max_frontier = 1

    while frontier:

        max_frontier = max(
            max_frontier,
            len(frontier)
        )

        current, path = frontier.pop()

        if current == goal:
            return path, max_frontier

        row, col = current

        for dr, dc in directions:

            nr = row + dr
            nc = col + dc

            neighbor = (nr, nc)

            if (
                valid_move(maze, nr, nc)
                and neighbor not in visited
            ):

                visited.add(neighbor)

                frontier.append(
                    (neighbor, path + [neighbor])
                )

    return None, max_frontier
```

---

# Understanding the DFS Implementation

The critical line is:

```python
current, path = frontier.pop()
```

`pop()` removes the last item from the list.

Therefore:

```text
Last inserted
      ↓
First removed
```

This implements LIFO behavior.

That is the defining feature of DFS.

---

# The Key Implementation Difference

Compare:

```python
# BFS
frontier.popleft()
```

with:

```python
# DFS
frontier.pop()
```

Everything else about the search problem can remain largely the same.

The difference in frontier management causes the algorithms to explore the state space differently.

```text
             FRONTIER
                 |
        +--------+--------+
        |                 |
       BFS               DFS
        |                 |
      Queue              Stack
        |                 |
      FIFO               LIFO
        |                 |
 Level-by-level       Deep-first
```

---

# Running Both Algorithms

```python
bfs_path, bfs_frontier = bfs(
    maze,
    start,
    goal
)

dfs_path, dfs_frontier = dfs(
    maze,
    start,
    goal
)


print("BFS path:", bfs_path)
print(
    "BFS path length:",
    len(bfs_path) - 1
)
print(
    "BFS maximum frontier:",
    bfs_frontier
)

print()

print("DFS path:", dfs_path)
print(
    "DFS path length:",
    len(dfs_path) - 1
)
print(
    "DFS maximum frontier:",
    dfs_frontier
)
```

---

# Why Is the Path Length `len(path) - 1`?

Suppose the path is:

```python
path = [
    (0, 0),
    (0, 1),
    (0, 2),
    (1, 2)
]
```

There are four states:

```text
Start → A → B → Goal
```

But the agent made only three movements.

Therefore:

```text
Number of states     = 4
Number of movements  = 3
```

Hence:

```python
len(path) - 1
```

gives the number of movements.

Since every movement has cost 1:

```text
Path length = Path cost
```

for this experiment.

---

# Visualizing the Solution

We can create a function that prints the maze and marks the solution path.

```python
def print_maze(maze, path=None):

    path = set(path or [])

    for r in range(len(maze)):

        row = ""

        for c in range(len(maze[0])):

            if (r, c) in path:
                row += "* "

            elif maze[r][c] == 1:
                row += "# "

            else:
                row += ". "

        print(row)
```

The symbols mean:

```text
* = Solution path
# = Wall
. = Open cell
```

---

# Displaying the BFS Solution

```python
print("BFS solution:")
print_maze(maze, bfs_path)
```

A possible output is:

```text
* * * * .
. # # # *
. . . # *
. # . . *
. # # # *
```

The exact path depends on the maze and the ordering of neighboring cells.

---

#  Displaying the DFS Solution

```python
print("DFS solution:")
print_maze(maze, dfs_path)
```

DFS may produce a different path from BFS.

This demonstrates an important concept:

> **The same problem can produce different solutions depending on the search strategy.**

---

# Comparing BFS and DFS

Fill in the blanks of the following table:

| Algorithm | Path Length | Maximum Frontier |
|---|---:|---:|
| BFS | ___ | ___ |
| DFS | ___ | ___ |

Answer the following questions:

1. Which algorithm found the shorter path?
2. Which algorithm had the larger frontier?
3. Why did the algorithms produce different paths?
4. Does DFS always produce the shortest path?
5. Does BFS always produce the shortest path when every movement costs 1?
6. What happens when the maze becomes larger?
7. What happens if the order of directions is changed?

---

# Experiment: Change Neighbor Ordering

Initially, use:

```python
directions = [
    (-1, 0),   # up
    (1, 0),    # down
    (0, -1),   # left
    (0, 1)     # right
]
```

Now change it to:

```python
directions = [
    (0, 1),    # right
    (1, 0),    # down
    (0, -1),   # left
    (-1, 0)    # up
]
```

Run DFS again.

Answer the question: Did the DFS path change?

---


# Real-World Applications of BFS

BFS is useful when we need to explore a graph systematically by distance or number of steps.

Applications include:

- Shortest path in unweighted graphs
- Network exploration
- Finding minimum number of connections
- Social-network analysis
- Web crawling
- Puzzle solving
- Robot navigation

For example:

> Find the minimum number of links between two nodes in an unweighted network.

---

# Real-World Applications of DFS

DFS is useful when deep exploration or backtracking is appropriate.

Applications include:

- Maze exploration
- Graph traversal
- Cycle detection
- Topological sorting
- Backtracking
- File-system traversal
- Constraint problems

For example:

> Explore a possible route through a maze until a solution is found.

---

# BFS and DFS in Artificial Intelligence

Search is fundamental to AI because many intelligent tasks can be represented as:

```text
Current State
      |
      v
Possible Actions
      |
      v
Future States
      |
      v
Search
      |
      v
Goal State
```

Examples include:

- Maze solving
- Robot navigation
- Route planning
- Game playing
- Puzzle solving
- Automated planning

The search algorithm determines how the possibilities are explored.

---

# From Uninformed Search to Informed Search

Uninformed search does not know which state is more promising.

For example:

```text
BFS:

"I will explore states systematically."
```

An informed search algorithm can use additional knowledge.

For example:

```text
A*:

"I have an estimate of how far each state is from the goal."
```

This additional information is called a:

> **Heuristic**

This leads to later topics such as:

- Greedy Best-First Search
- A* Search
- Heuristic functions

---

#  Summary

Problem solving by searching means:

> **Exploring a state space to find a sequence of actions leading from an initial state to a goal state.**

A formal search problem contains:

```text
Initial State
Actions
Transition Model
Goal Test
Path Cost
```

The problem can be represented as a graph:

```text
Nodes → States
Edges → Actions / Transitions
```

The search algorithm maintains a **frontier** containing discovered but unexpanded states.

---

# BFS Summary

```text
BFS
 |
 +-- Queue
 |
 +-- FIFO
 |
 +-- Level-by-level exploration
 |
 +-- Complete under standard assumptions
 |
 +-- Optimal for equal step costs
 |
 +-- Can require substantial memory
```

---

#  DFS Summary

```text
DFS
 |
 +-- Stack
 |
 +-- LIFO
 |
 +-- Deep exploration
 |
 +-- Not necessarily complete
 |
 +-- Not optimal
 |
 +-- Generally lower memory requirement
```

---

#  Most Important Takeaway

The most important concept of this lecture is:

> **BFS and DFS mainly differ in how they manage the frontier.**

```text
                    FRONTIER
                        |
             +----------+----------+
             |                     |
            BFS                   DFS
             |                     |
           Queue                 Stack
             |                     |
           FIFO                  LIFO
             |                     |
     Level-by-level           Deep-first
             |                     |
     Shortest path*           Not optimal
             |                     |
       More memory             Less memory
```

In Python:

```python
# BFS
frontier.popleft()
```

and:

```python
# DFS
frontier.pop()
```

A small change in frontier management produces a fundamentally different search strategy.

---
