# Lecture: Problem Solving by Searching — Uninformed Search

**Course:** Artificial Intelligence  
**Topic:** Problem Solving by Searching (Uninformed Search)  
**Duration:** 3 hours  
**Practical Lab:** BFS and DFS in Python using a 2D matrix maze

---

# 1. Learning Objectives

By the end of this lecture, students should be able to:

1. Explain the idea of **problem solving as search**.
2. Convert a real-world problem into a **formal state-space representation**.
3. Identify:
   - States
   - Actions
   - Transition models
   - Goal tests
   - Path costs
4. Represent a problem as a **state-space graph**.
5. Explain the concept of the **search frontier**.
6. Explain how BFS and DFS manage the frontier differently.
7. Compare BFS and DFS in terms of:
   - Completeness
   - Optimality
   - Time complexity
   - Space complexity
8. Implement BFS and DFS in Python.
9. Use BFS and DFS to navigate an agent through a 2D matrix maze.
10. Compare the **maximum frontier size** and **path length** produced by both algorithms.

---

# 2. Introduction: Problem Solving as Search

Many artificial intelligence problems can be formulated as a **search problem**.

Suppose an intelligent agent wants to travel from:

```text
Quetta → Karachi
```

The agent has to determine a sequence of actions that takes it from its current location to the destination.

The same basic idea applies to:

- Robot navigation
- Maze solving
- Route planning
- Game playing
- Puzzle solving
- Network routing

The general process is:

```text
Initial State
     |
     v
Possible Actions
     |
     v
New States
     |
     v
More Possible Actions
     |
     v
Goal State?
   /     \
 No       Yes
 |         |
Search    Solution
```

The important idea is:

> **An AI agent can solve a problem by searching through possible states until it finds a state satisfying the goal condition.**

---

# 3. Real-World Example: Travelling from Quetta to Karachi

Consider a traveler who wants to travel by road from Quetta to Karachi.

A simplified representation of the main Quetta-Karachi road route is:

```text
Quetta
   |
Mastung
   |
Kalat
   |
Surab
   |
Khuzdar
   |
Wadh
   |
Bela
   |
Uthal
   |
Winder
   |
Hub
   |
Karachi
```

This is a useful example for introducing state-space representation because the journey consists of a sequence of locations connected by roads.

The Quetta-Karachi road corridor includes the **N-25 / RCD Highway**, passing through important locations such as Mastung, Kalat, Surab, Khuzdar, Wadh, Bela/Uthal, Winder and Hub.

For an AI course, the exact road distance is less important than the abstraction:

```text
Locations  → States
Roads      → Connections / Actions
Quetta     → Initial State
Karachi    → Goal State
```

---

# 4. Why the Quetta-Karachi Example Is a Search Problem

The real road network is much more complicated than a simple sequence.

At different locations, a traveler may have multiple possible roads.

A simplified branching network might look like:

```text
                         Route A
                       /---------\
Quetta ---- Khuzdar --             -- Karachi
                       \---------/
                         Route B
```

A more useful abstraction is:

```text
                  A -------- B
                 /            \
            Quetta              D ---- Karachi
                 \            /
                  C -------- E
```

Here:

- `Quetta` is the initial state.
- `Karachi` is the goal state.
- `A, B, C, D, E` are intermediate states.
- Connections represent possible roads or transitions.

The search algorithm must determine which states to explore and in what order.

The problem therefore becomes:

> **Given a road network, find a sequence of states and actions that takes the agent from Quetta to Karachi.**

---


# 5. From a Real-World Problem to a Formal Search Problem

Before an AI system can search for a solution, the real-world problem must be represented formally.

A classical search problem consists of five components:

1. **Initial state**
2. **Actions**
3. **Transition model**
4. **Goal test**
5. **Path cost**

These components define the problem that the search algorithm will solve.

---

# 6. State

A **state** describes a particular situation of the problem.

For the road-navigation problem: `State = Current location`

Possible states include: Quetta, Mastung, Kalat,  Surab, Khuzdar, Wadh, Bela, Uthal, Winder, Hub, Karachi

For a maze, a state can be represented by a coordinate: (row, column) For example: (2, 3)

means that the agent is currently located at row 2, column 3.

---

# 7. Initial State

The **initial state** is the state where the agent begins.

For the road example: Initial State = Quetta

For the maze: Initial State = (0, 0)

---

# 8. Actions

An **action** describes something the agent can do from a state.

For the road problem:

1. Drive from Quetta to Mastung
2. Drive from Mastung to Kalat
3. Drive from Kalat to Khuzdar
4. Drive from Khuzdar to Wadh

For a 2D maze, the possible actions are:

- UP
- DOWN
- LEFT
- RIGHT

The available actions depend on the current state.  For example, if the agent is at the top row of a maze, it cannot move UP.

---

# 9. Transition Model

The **transition model** tells us what happens when an action is performed.

In simple terms:

> **Current State + Action --> New State**

For example: **Current State** = Kalat, **Action** = Drive toward Khuzdar -->  **New State** = Khuzdar

Formally: Result(Kalat, Drive-to-Khuzdar) = Khuzdar

For a maze:

Current State = (2,3) + Action = RIGHT  --> New State = (2,4)

provided that `(2,4)` is a valid cell.

---

# 10. Goal Test

The **goal test** determines whether the current state is the desired state.

For the road problem: Goal = Karachi

The goal test can be expressed as:

```python
current_state == "Karachi"
```

For the maze: Goal = (4, 4)

The goal test is:

```python
current_state == goal
```

If the goal test is true: **Solution found!**

---

# 11. Path Cost

A solution is a sequence of actions leading from the initial state to the goal.

For example:

```text
Quetta
   ↓
Mastung
   ↓
Kalat
   ↓
Khuzdar
   ↓
Wadh
   ↓
Bela
   ↓
Uthal
   ↓
Winder
   ↓
Hub
   ↓
Karachi
```

If every action has the same cost:

```text
Cost of each action = 1
```

then: Path cost = Number of actions

In a real navigation problem, however, actions can have different costs.

For example:

- Road A = 100 km
- Road B = 150 km
- Road C = 80 km

The path cost could represent:

- Distance
- Travel time
- Fuel consumption
- Toll cost
- A combination of several factors

For maze lab, we simplify the problem: Cost of every movement = 1

Therefore: Path cost = Number of movements

---

# 12. State-Space Graph

Once the problem has been formally defined, we can represent it as a **state-space graph**.

A graph contains:

```text
Nodes  → States
Edges  → Actions / Transitions
```

For example:

```text
        A
       / \
      B   C
     / \
    D   E
```

Here:

```text
A = Initial State
E = Goal State
```

A possible solution is:

```text
A → B → E
```

The search algorithm determines which nodes to explore and in what order.

---

# 13. State-Space Graph for a Road Network

A simplified road network could be represented as:

```text
                         Khuzdar
                        /       \
                    Kalat       Wadh
                   /              |
              Mastung             Bela
                 |                 |
               Quetta             Uthal
                                   |
                                 Winder
                                   |
                                  Hub
                                   |
                                Karachi
```

The AI system interprets this as:

```text
Nodes = Locations
Edges = Road connections
Initial state = Quetta
Goal state = Karachi
```

The actual road network may contain many more branches and connections.

The AI abstraction removes unnecessary details and retains the information needed for search.

---

# 14. State-Space Graph for a Maze

Consider this maze:

```text
S . # .
. . # .
# . . .
. # . G
```

Where:

```text
S = Start
G = Goal
. = Open cell
# = Wall
```

Each open cell represents a possible state.

For example:

```text
(0,0) = Start
(0,1) = Open cell
(1,0) = Open cell
...
(3,3) = Goal
```

The transitions are movements between adjacent open cells.

---

# 15. Search Tree vs Search Graph

These two concepts should be distinguished.

## State-Space Graph

The state-space graph represents the actual problem.

```text
       A
      / \
     B---C
```

There is a connection between B and C.

## Search Tree

A search tree represents the paths generated by the search process.

```text
       A
      / \
     B   C
     |
     C
```

The same state can appear more than once in a search tree if it can be reached through different paths.

This is why practical graph-search algorithms maintain a: **visited / explored set**

to prevent unnecessary repeated exploration.

---

# 16. What Is Uninformed Search?

Today's topic is **Uninformed Search**.

Uninformed search is also called: **Blind Search**

The algorithm does not have additional information indicating which state is closer to the goal.

It knows:

- Initial state
- Available actions
- Transition model
- Goal test
- Path cost

But it does not use a heuristic such as: **This state is probably closer to Karachi.** or: **This cell is probably closer to the exit.**

The search algorithm must therefore explore the state space using a systematic strategy.

---

# 17. Examples of Uninformed Search

Important uninformed search algorithms include:

- Breadth-First Search (BFS)
- Depth-First Search (DFS)
- Uniform-Cost Search
- Depth-Limited Search
- Iterative Deepening Search

In this lecture we focus on:

```text
Breadth-First Search (BFS)
Depth-First Search (DFS)
```

---

# 18. The Search Frontier

The **frontier** is a central concept in search.

The frontier contains:  **States that have been discovered but have not yet been expanded.**

Consider:

```text
        A
       / \
      B   C
     / \
    D   E
```

Initially: Frontier = [A]

- After expanding A: Frontier = [B, C]
- After expanding B: Frontier = [C, D, E]

The search process repeatedly:

1. Selects a state from the frontier.
2. Expands that state.
3. Generates successor states.
4. Adds appropriate successors to the frontier.
5. Checks whether the goal has been reached.

---

# 19. Generic Search Algorithm

The general search process can be described as:

```
frontier ← {initial state}

while frontier is not empty:

    remove a node from frontier

    if node is goal:
        return solution

    expand node

    add resulting states to frontier
return failure
```

The crucial question is: **Which node should be removed from the frontier next?**

This determines the search strategy.

---

# 20. Breadth-First Search (BFS)

Breadth-First Search explores the state space **level by level**.

Consider:

```text
              A
           /     \
          B       C
        /  \     / \
       D    E   F   G
```

BFS explores:

```text
A

B C

D E F G
```

Therefore, the search proceeds through the shallowest nodes first.

The order may be:

```text
A → B → C → D → E → F → G
```

assuming left-to-right successor ordering.

---

# 21. BFS Frontier

BFS uses a:

> **FIFO Queue**

FIFO means:

> **First In, First Out**

For example:

```text
Initial:

[A]

Remove A:

[B, C]

Remove B:

[C, D, E]

Remove C:

[D, E, F, G]
```

The oldest node in the frontier is removed first.

Therefore BFS explores the search space broadly before going deeper.

---

# 22. BFS Pseudocode

```text
BFS(problem):

    frontier = Queue()
    frontier.add(initial_state)

    explored = empty set

    while frontier is not empty:

        node = frontier.remove()

        if node is goal:
            return solution

        add node to explored

        for each successor:

            if successor not in explored
               and successor not in frontier:

                frontier.add(successor)

    return failure
```

---

# 23. Why Does BFS Find a Shortest Path?

Suppose every action has the same cost.

BFS explores states in order of depth:

```text
Depth 0
Depth 1
Depth 2
Depth 3
...
```

Therefore, if BFS reaches the goal at depth `d`, there cannot be a solution requiring fewer than `d` actions.

Hence:

> **BFS is optimal when all step costs are equal.**

For today's maze:

```text
Every movement = 1
```

Therefore BFS will find a shortest path.

---

# 25. Depth-First Search (DFS)

Depth-First Search takes a different approach.

Instead of exploring an entire level first, DFS follows one path as deeply as possible.

Consider:

```text
              A
           /     \
          B       C
        /  \     / \
       D    E   F   G
```

DFS might explore:

```text
A
B
D
E
C
F
G
```

The exact order depends on the order in which successors are generated.

---

# 26. DFS Frontier

DFS uses a:

> **LIFO Stack**

LIFO means:

> **Last In, First Out**

For example:

```text
[A]
```

After expanding A:

```text
[B, C]
```

If C is the most recently added node:

```text
[B, C]
    ↑
    |
  remove
```

C will be selected before B.

Therefore DFS follows the most recently generated branch.

---

# 27. DFS Pseudocode

```text
DFS(problem):

    frontier = Stack()
    frontier.add(initial_state)

    explored = empty set

    while frontier is not empty:

        node = frontier.remove()

        if node is goal:
            return solution

        add node to explored

        for each successor:

            if successor not in explored:

                frontier.add(successor)

    return failure
```

---

# 28. The Fundamental Difference Between BFS and DFS

The most important implementation difference is how the frontier is managed.

```text
BFS
 |
 +-- Queue
 |
 +-- FIFO
 |
 +-- First inserted → First removed
```

versus:

```text
DFS
 |
 +-- Stack
 |
 +-- LIFO
 |
 +-- Last inserted → First removed
```

In Python:

```python
# BFS
frontier.popleft()
```

versus:

```python
# DFS
frontier.pop()
```

This small difference produces substantially different search behavior.

---

# 29. BFS vs DFS

| Feature | BFS | DFS |
|---|---|---|
| Strategy | Level by level | Go deep first |
| Frontier | Queue | Stack |
| Data structure | FIFO | LIFO |
| Complete? | Yes, under standard finite-branching assumptions | Not always |
| Optimal? | Yes, when all step costs are equal | No |
| Time | O(b^d) | O(b^m) |
| Space | O(b^d) | O(bm) |
| Memory usage | Usually high | Usually lower |
| Shortest path | Yes, for equal step costs | Not guaranteed |

Where:

- `b` = branching factor
- `d` = depth of the shallowest solution
- `m` = maximum depth of the search tree

---

# 30. Branching Factor

The **branching factor** is the approximate number of successors available from a state.

For example:

```text
       State
     /   |   \
    A    B    C
```

The branching factor is approximately:

```text
b = 3
```

In a 2D maze, a cell can have up to four neighboring cells:

```text
       UP
        |
LEFT -- X -- RIGHT
        |
      DOWN
```

Therefore:

```text
Maximum possible branching factor ≈ 4
```

However, walls and maze boundaries usually reduce the actual number of available moves.

---

# 31. BFS Complexity

For BFS, the standard worst-case time complexity is approximately:

```text
O(b^d)
```

where:

- `b` = branching factor
- `d` = depth of the shallowest solution

The major disadvantage is its memory requirement:

```text
O(b^d)
```

BFS may have to keep a large number of frontier nodes in memory.

Therefore:

> **BFS can be memory-intensive, especially for wide search spaces.**

---

# 32. DFS Complexity

For DFS, the standard worst-case time complexity is approximately:

```text
O(b^m)
```

where:

```text
m = maximum depth of the search tree
```

Its space complexity is approximately:

```text
O(bm)
```

Therefore, DFS can use considerably less memory than BFS.

However, DFS may spend a long time exploring an unproductive branch.

---

# 33. Why DFS Does Not Guarantee the Shortest Path

Consider:

```text
             S
            / \
           A   B
           |   |
           |   G
           |
           |
           G
```

Suppose the branch through A is long, while B leads directly to the goal.

DFS could explore:

```text
S → A → ... → G
```

before examining:

```text
S → B → G
```

Therefore DFS may return a solution that is longer than another available solution.

Hence:

> **DFS is not optimal.**

---

# 34. Why Use DFS?

DFS has an important advantage:

> **It generally requires less memory than BFS.**

Imagine a very wide search tree.

BFS may need to store:

```text
Thousands or millions of frontier nodes
```

DFS generally stores a much smaller amount of information related to the current exploration path and alternative branches.

Therefore:

```text
BFS → potentially high memory usage

DFS → generally lower memory usage
```

---

# 35. Frontier Size

For the practical experiment, we will measure:

> **Maximum size of the frontier during the search.**

For example:

```text
Step       Frontier Size
------------------------
1              1
2              2
3              3
4              4
5              3
6              2
```

Therefore:

```text
Maximum frontier size = 4
```

This provides a simple experimental measure of how much information the algorithm keeps waiting to be explored.

---

# 36. Important Experimental Observation

The frontier size is not a fixed property of BFS or DFS.

It depends on:

- Maze structure
- Branching factor
- Goal location
- Neighbor ordering
- Whether visited states are recorded
- Whether duplicate states are prevented

Therefore, students should not memorize a particular frontier size.

Instead:

> **Run both algorithms on the same maze and compare their actual behavior.**

---

