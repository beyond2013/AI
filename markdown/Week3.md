# Lecture: Problem Solving by Searching — Uninformed Search

**Course:** Artificial Intelligence
**Topic:** Problem Solving by Searching (Uninformed Search)
**Duration:** 3 hours
**Practical Lab:** BFS and DFS in Python using a 2D matrix maze

---

## 1. Learning Objectives

By the end of this lecture, students should be able to:

1. Explain the idea of **problem solving as search**.
2. Convert a real-world problem into a **formal state-space representation**.
3. Identify the five components of a search problem: state, actions, transition model, goal test, path cost.
4. Represent a problem as a **state-space graph**.
5. Explain the **search frontier** and how BFS/DFS manage it differently.
6. Compare BFS and DFS on completeness, optimality, time complexity, and space complexity.
7. Implement BFS and DFS in Python and run them on a 2D matrix maze.
8. Compare the **maximum frontier size** and **path length** each algorithm produces.

---

## 2. Problem Solving as Search

Many AI problems — robot navigation, maze solving, route planning, game playing, puzzle solving — boil down to the same pattern:

```text
Initial State → Possible Actions → New States → ... → Goal State?
```

> **Key idea:** An AI agent solves a problem by searching through possible states until it finds one that satisfies the goal condition.

**Our running example for this entire lecture:** an agent navigating a 2D maze.

```text
S . # .
. . # .
# . . .
. # . G
```

Legend: `S` = start, `G` = goal, `.` = open cell, `#` = wall.

---

## 3. Formalizing the Problem

Before an algorithm can search for a solution, the problem must be defined using five components:

1. **State**
2. **Initial state**
3. **Actions**
4. **Transition model**
5. **Goal test** (and **path cost**)

### State
A state is a situation the agent can be in. In the maze, a state is a coordinate `(row, column)` — e.g. `(2, 3)` means the agent is at row 2, column 3.

### Initial State
Where the agent begins: `Initial State = (0, 0)`.

### Actions
What the agent can do from a state. In the maze: `UP`, `DOWN`, `LEFT`, `RIGHT`. Available actions depend on the current state — e.g. an agent in the top row cannot move `UP`, and it can never move into a wall (`#`).

### Transition Model
What happens when an action is performed:

> **Current State + Action → New State**

```text
Current State = (2, 3)
Action        = RIGHT
New State     = (2, 4)     [only if (2,4) is open, not a wall]
```

### Goal Test
Checks whether the current state is the goal. Here, `Goal = (3, 3)`.

```python
current_state == goal
```

### Path Cost
We simplify: every movement costs `1`. So:

```text
Path cost = number of movements
```

(In harder problems, different actions can have different costs — e.g. distance, time, or fuel — but our maze keeps it uniform.)

---

## 4. State-Space Graph

Once a problem is formalized, it can be drawn as a graph:

```text
Nodes → States
Edges → Actions / transitions between states
```

For our maze, each open cell is a node, and edges connect cells that are reachable from each other in one move:

```text
(0,0)---(0,1)       (0,3)
           |            |
(1,0)---(1,1)       (1,3)
                        |
        (2,1)---(2,2)---(2,3)
                            |
                (3,2)---(3,3)
```

*(Walls at `(0,2)`, `(1,2)`, `(2,0)`, `(3,1)` are simply absent — they contribute no nodes or edges.)*

`(0,0)` is the initial state, `(3,3)` is the goal state. A solution is any path through this graph from start to goal.

---

## 5. Search Tree vs. Search Graph

These look similar but are different — a common point of confusion.

**State-space graph** (above): each state appears **exactly once**, no matter how many ways there are to reach it.

**Search tree**: represents the *paths* the search process tries. The same state can appear **more than once**, once for every distinct path leading to it:

```text
                (0,0)
                  |
                (0,1)
                  |
                (1,1)
               /      \
           (2,1)      (1,1)  ← revisited via a different path
```

This is exactly why practical search algorithms keep an **explored set** — to stop wastefully re-expanding a state we've already visited.

---

## 6. What Is Uninformed Search?

Today's topic is **Uninformed Search**, also called **Blind Search**.

The algorithm only knows the initial state, actions, transition model, goal test, and path cost. It has **no heuristic** — no notion like "this cell is probably closer to the exit." (That's *informed* search, e.g. A\*, covered later.) So it must explore the state space using a purely systematic strategy.

Common uninformed search algorithms: **BFS**, **DFS**, Uniform-Cost Search, Depth-Limited Search, Iterative Deepening Search. Today: **BFS and DFS**.

---

## 7. The Search Frontier

The **frontier** holds states that have been discovered but not yet expanded.

```text
frontier ← {initial state}
explored ← {}

while frontier is not empty:
    node ← remove a node from frontier
    if node is goal:
        return solution
    add node to explored
    for each successor of node:
        if successor not already in explored or frontier:
            add successor to frontier

return failure
```

The crucial design question — **which node do we remove from the frontier next?** — is exactly where BFS and DFS diverge.

---

## 8. Breadth-First Search (BFS)

BFS explores **level by level**, using a **FIFO Queue** ("First In, First Out") — the oldest node in the frontier is removed first.

Tracing BFS on our maze from `(0,0)`:

```text
Frontier: [(0,0)]
Remove (0,0) → expand → Frontier: [(0,1),(1,0)]
Remove (0,1) → expand → Frontier: [(1,0),(1,1)]
Remove (1,0) → expand → Frontier: [(1,1)]        (only new state: none new)
Remove (1,1) → expand → Frontier: [(1,3)? no — not adjacent; (2,1)]
...continues level by level until (3,3) is reached
```

*(Exact order depends on neighbor-generation order — the point is BFS always finishes one full "ring" of distance from start before starting the next.)*

**Pseudocode:**

```text
BFS(problem):
    frontier = Queue()
    frontier.add(initial_state)
    explored = empty set

    while frontier is not empty:
        node = frontier.remove()      # FIFO: oldest first
        if node is goal:
            return solution
        add node to explored
        for each successor:
            if successor not in explored and not in frontier:
                frontier.add(successor)
    return failure
```

```python
# BFS uses:
frontier.popleft()
```

**Why BFS finds the shortest path:** if all step costs are equal, BFS fully explores depth 0, then depth 1, then depth 2, and so on. So if it reaches the goal at depth `d`, no shorter solution can exist — every shallower depth was already checked and ruled out.

> **BFS is optimal when all step costs are equal.** Since every move in our maze costs 1, BFS is guaranteed to return a shortest path.

---

## 9. Depth-First Search (DFS)

DFS follows **one path as deeply as possible** before backtracking, using a **LIFO Stack** ("Last In, First Out") — the most recently added node is removed first.

Tracing DFS on our maze from `(0,0)`:

```text
Frontier: [(0,0)]
Remove (0,0) → expand → Frontier: [(0,1),(1,0)]
Remove (1,0) → (most recent) → expand → Frontier: [(0,1)]  (no new unvisited neighbor)
Remove (0,1) → expand → Frontier: [(1,1)]
Remove (1,1) → expand → Frontier: [(2,1)]
...DFS commits to this branch fully before trying alternatives
```

**Pseudocode:**

```text
DFS(problem):
    frontier = Stack()
    frontier.add(initial_state)
    explored = empty set

    while frontier is not empty:
        node = frontier.remove()      # LIFO: most recent first
        if node is goal:
            return solution
        add node to explored
        for each successor:
            if successor not in explored:
                frontier.add(successor)
    return failure
```

```python
# DFS uses:
frontier.pop()
```

**Why DFS does not guarantee the shortest path:** if the goal is reachable both via a long branch and a short branch, DFS returns whichever one it happens to commit to and finish first — not necessarily the shorter one.

> **DFS is not optimal** — it finds *a* solution, not necessarily the *best* one.

---

## 10. The Fundamental Difference

```text
BFS                          DFS
 +-- Queue                    +-- Stack
 +-- FIFO                     +-- LIFO
 +-- First inserted,          +-- Last inserted,
     first removed                first removed
```

One line of code (`popleft()` vs `pop()`) is enough to produce two completely different search behaviors.

---

## 11. Completeness and Optimality

- **Complete:** guaranteed to find a solution if one exists (and correctly report failure otherwise).
- **Optimal:** guaranteed to find the *best* (e.g. shortest) solution, not just *a* solution.

An algorithm can be complete without being optimal — DFS is a good example.

---

## 12. BFS vs. DFS — Comparison Table

| Feature          | BFS                                     | DFS                                              |
|------------------|-------------------------------------------|----------------------------------------------------|
| Strategy         | Level by level                            | Go deep first                                       |
| Frontier         | Queue                                     | Stack                                               |
| Data structure   | FIFO                                      | LIFO                                                |
| Complete?        | Yes, if branching factor is finite        | Not always — can get stuck down a long/infinite branch |
| Optimal?         | Yes, when all step costs are equal        | No                                                   |
| Time complexity  | O(b^d)                                    | O(b^m)                                              |
| Space complexity | O(b^d)                                    | O(b·m)                                              |
| Memory usage     | Usually high                              | Usually lower                                       |
| Shortest path?   | Yes, for equal step costs                 | Not guaranteed                                      |

Where `b` = branching factor, `d` = depth of the shallowest solution, `m` = maximum depth of the search tree.

**Branching factor** in a maze: up to 4 (`UP`, `DOWN`, `LEFT`, `RIGHT`), reduced in practice by walls and boundaries.

---

## 13. Why the Memory Trade-off Matters

- **BFS**: worst case `O(b^d)` time *and* space — it may need to hold a huge number of frontier nodes at once, especially in a wide maze.
- **DFS**: worst case `O(b^m)` time, but only `O(b·m)` space — it only needs to remember the current path plus untried alternatives along it.

```text
BFS → potentially very high memory usage, guaranteed shortest path
DFS → generally low memory usage, no such guarantee
```

This time/space vs. solution-quality trade-off recurs throughout AI search.

---

## 14. Frontier Size (What You'll Measure in the Lab)

In the lab, you'll track the **maximum frontier size during the search** — a simple proxy for memory use.

| Step | Frontier Size |
|------|----------------|
| 1    | 1              |
| 2    | 2              |
| 3    | 3              |
| 4    | 4              |
| 5    | 3              |
| 6    | 2              |

Here, **maximum frontier size = 4**.

> Frontier size is **not fixed** — it depends on maze structure, branching factor, goal location, neighbor ordering, and whether visited states are tracked. Don't memorize a number: run BFS and DFS on the *same* maze and compare their *actual* measured behavior.

---

## 15. Recap

| Question | BFS | DFS |
|---|---|---|
| Picks next node from frontier by... | Oldest (Queue/FIFO) | Newest (Stack/LIFO) |
| Finds a solution if one exists? | Yes (finite branching) | Not always |
| Finds the *shortest* solution? | Yes (equal step costs) | Not guaranteed |
| Typical memory use | Higher | Lower |
| Best when... | You need the shortest path and can afford the memory | Memory is limited and any valid solution will do |

---

## 16. Quick Self-Check (Try Before the Lab)

1. Why is BFS guaranteed to find the shortest path in the maze, while DFS is not?
2. With branching factor 3 and a goal at depth 5, roughly how large could BFS's frontier get just before finding the goal?
3. Give one reason you might choose DFS over BFS even though it isn't optimal.
4. Why can the same maze cell appear twice in a search tree but only once in the state-space graph?
5. What one-line code change turns the generic search algorithm into BFS vs. DFS?
