# Credit: Contents generated using Claude 

# Week 4: Informed Search & Heuristics

## 1. Recap: The Limits of Uninformed Search

BFS and DFS treat every state the same way — they have no sense of which unexplored node is "closer" to the goal. They expand nodes based purely on structure (arrival order in BFS, depth in DFS), which means:

- BFS guarantees the shortest path but explores exponentially many states it doesn't need to.
- DFS is memory-efficient but can wander arbitrarily far from the goal.

**Informed search** fixes this by giving the algorithm *domain knowledge* — an estimate of how promising a state is — so it can prioritize exploration intelligently instead of blindly.

---

## 2. Domain Knowledge and Heuristics

A **heuristic function** `h(n)` estimates the cost from state `n` to the goal. It encodes problem-specific knowledge that a generic search algorithm doesn't have.

- `h(n) = 0` for the goal state.
- `h(n)` should be cheap to compute — otherwise you're just shifting the cost of search into the cost of evaluation.
- A good heuristic reduces the **effective branching factor**, meaning fewer nodes are expanded to reach the same goal.

We'll use one running example for the rest of this lecture: the **8-Puzzle** (a 3×3 grid with tiles 1–8 and one blank, solvable by sliding tiles into the blank space). This is exactly the problem you will implement in this week's lab, so the heuristics discussed here are the ones you'll be coding and comparing directly.

**Problem formulation for the 8-Puzzle:**

| Component | Definition |
|---|---|
| State | An arrangement of tiles 1–8 and the blank on the 3×3 grid |
| Initial state | The scrambled starting board |
| Actions | Move blank Up, Down, Left, Right (when in bounds) |
| Transition model | Swapping the blank with the adjacent tile in the move direction |
| Goal test | Tiles arranged in order (e.g., 1–8 with blank last) |
| Path cost | Number of moves made (each move costs 1) |

---

## 3. Greedy Best-First Search

Greedy Best-First Search expands the node that appears **closest to the goal**, using only the heuristic:

```
f(n) = h(n)
```

It always picks the frontier node with the lowest `h(n)` value, ignoring how much it already cost to get there.

### Pseudocode

```
function GREEDY-BEST-FIRST-SEARCH(problem, h):
    frontier ← priority queue ordered by h(n), containing initial state
    explored ← empty set

    while frontier is not empty:
        node ← frontier.pop()  # lowest h(n)
        if problem.GOAL-TEST(node.state):
            return SOLUTION(node)
        explored.add(node.state)

        for each child in EXPAND(node, problem):
            if child.state not in explored and child not in frontier:
                frontier.add(child)
            else if child in frontier with higher h(n):
                replace it with child

    return failure
```

### Properties

- **Fast in practice** — it heads straight for states that look good.
- **Not optimal** — it can be lured down a path that looks promising early but is actually longer.
- **Not complete** in general (can loop on infinite spaces without repeated-state checking).

For the 8-Puzzle: a greedy search using Manhattan distance will often solve easy scrambles almost immediately, but on harder scrambles it can commit to a bad early move and end up taking far more moves than necessary.

---

## 4. A\* Search

A\* fixes Greedy's short-sightedness by combining the cost *already paid* with the cost *estimated to remain*:

```
f(n) = g(n) + h(n)
```

- `g(n)` — actual cost from the start to node `n` (exact, known).
- `h(n)` — estimated cost from `n` to the goal (heuristic, approximate).
- `f(n)` — estimated total cost of the cheapest solution through `n`.

A\* expands the node with the lowest `f(n)`, so it balances "how far I've come" against "how far I think I have left."

### Pseudocode

```
function A-STAR-SEARCH(problem, h):
    frontier ← priority queue ordered by f(n) = g(n) + h(n)
    frontier.add(initial state, g = 0)
    explored ← empty map (state → lowest g seen)

    while frontier is not empty:
        node ← frontier.pop()  # lowest f(n)
        if problem.GOAL-TEST(node.state):
            return SOLUTION(node)

        explored[node.state] ← node.g

        for each child in EXPAND(node, problem):
            g_child ← node.g + STEP-COST(node, child)
            if child.state not in explored or g_child < explored[child.state]:
                child.g ← g_child
                child.f ← g_child + h(child.state)
                frontier.add(child)

    return failure
```

### Why A\* Matters

If `h(n)` is **admissible** (see below), A\* is guaranteed to find the **optimal** solution, and it does so while expanding as few nodes as possible among all optimal algorithms using that heuristic (this optimality-of-efficiency result requires consistency as well). This is the tradeoff informed search gives you: the same completeness and optimality guarantees as BFS's uniform-cost search, but with far less wasted exploration.

---

## 5. Admissibility and Consistency

Not every heuristic makes A\* behave correctly. Two mathematical properties matter:

### Admissible Heuristics

A heuristic `h(n)` is **admissible** if it never overestimates the true cost to the goal:

```
h(n) ≤ h*(n)   for all n
```

where `h*(n)` is the actual optimal cost from `n` to the goal. An admissible heuristic is *optimistic* — it may underestimate, but never lies in a way that would cause a good path to look worse than it is.

**Why it matters:** if `h(n)` is admissible, A\* is guaranteed to return an optimal solution, because it will never let a suboptimal node with a falsely-low `f(n)` slip past a truly-optimal one.

### Consistent (Monotonic) Heuristics

A heuristic is **consistent** if, for every node `n` and every successor `n'` generated by an action with cost `c(n, n')`:

```
h(n) ≤ c(n, n') + h(n')
```

This is a triangle-inequality condition: the estimated cost from `n` shouldn't be greater than the cost of one step plus the estimated cost from the successor.

**Why it matters:** consistency guarantees that `f(n)` never decreases along any path from the root, which means once A\* expands a node, it has already found the optimal path to it — no re-expansion is ever needed. Every consistent heuristic is also admissible, but not every admissible heuristic is consistent.

---

> 🎥 **Supplementary Viewing: Search: Optimal, Branch and Bound, A\***
> [Watch on YouTube](https://youtu.be/gGQ-vAmdAOI)
>
> *Credit: Patrick H. Winston, "Lecture 5: Search: Optimal, Branch and Bound, A\*," MIT 6.034 Artificial Intelligence, Fall 2010. Source: [MIT OpenCourseWare](https://ocw.mit.edu/courses/6-034-artificial-intelligence-fall-2010/). Used under a Creative Commons license.*
>
> This lecture builds up to A\* starting from branch and bound, then revisits admissibility and ends with an example where the heuristic must be consistent. Watch it after this section to reinforce the theory. Note that it uses map-based examples instead of the 8-Puzzle and covers some material beyond this week's scope (e.g., branch and bound and the extended list), so treat it as enrichment rather than required viewing.

## 6. Heuristics for the 8-Puzzle

This is the direct bridge to your lab, where you'll implement and compare both of these:

### Misplaced Tiles

Count how many tiles are not in their goal position (excluding the blank).

- Cheap to compute.
- Admissible: each misplaced tile needs at least one move to fix, so this never overestimates.
- Weak: it ignores *how far* out of place each tile is, so it underestimates a lot, giving A\* less guidance and causing more node expansions.

### Manhattan Distance

Sum, over all tiles, the number of grid moves (horizontal + vertical) each tile is from its goal position.

- Still cheap to compute.
- Admissible: each unit of Manhattan distance requires at least one move, and diagonal moves aren't allowed, so it never overestimates.
- Also consistent, since moving a tile one step changes its Manhattan distance to the goal by at most 1.
- Stronger: it's always ≥ Misplaced Tiles, giving A\* a tighter, more informative estimate — and tighter admissible heuristics mean fewer nodes explored.

**What you'll measure in the lab:** for the same scrambled board, Manhattan distance will consistently expand fewer nodes than Misplaced Tiles to reach the same optimal solution. This is the practical payoff of a "better" (higher, but still admissible) heuristic.

---

## 7. Complexity

| Algorithm | Time | Space | Complete | Optimal |
|---|---|---|---|---|
| Greedy Best-First | O(b^m) worst case | O(b^m) | No (without cycle checks) | No |
| A\* | O(b^d) but heavily reduced by a good `h` | O(b^d) (stores frontier + explored) | Yes | Yes (if `h` admissible) |

Where `b` is the branching factor (up to 4 for the 8-Puzzle: Up/Down/Left/Right), `d` is the depth of the optimal solution, and `m` is the maximum depth of the search space. In practice, A\*'s real-world performance depends almost entirely on how informative `h(n)` is — this is exactly why the lab has you benchmark node counts, not just runtime.

---

## 8. Summary

- Informed search uses a heuristic `h(n)` to focus exploration, unlike uninformed search which treats all frontier nodes equally.
- Greedy Best-First Search is fast but not optimal — it ignores cost already paid.
- A\* Search combines `g(n)` and `h(n)` to guarantee optimality when `h(n)` is admissible.
- Consistency is a stronger property than admissibility and guarantees A\* never has to re-expand a node.
- For the 8-Puzzle: Misplaced Tiles is a weak but valid admissible heuristic; Manhattan Distance is stronger, still admissible and consistent, and will expand fewer nodes in your lab benchmarks.

## 9. Practical Lab Preview

You will implement an A\* solver for the 8-Puzzle in Python:

1. Represent the board state (e.g., as a tuple or flattened list) and implement the goal test.
2. Implement `EXPAND` to generate valid blank moves from a given state.
3. Implement both heuristics: `misplaced_tiles(state)` and `manhattan_distance(state)`.
4. Run A\* with each heuristic on the same set of scrambled boards.
5. Record and compare the number of nodes expanded for each heuristic to see, empirically, how heuristic strength translates into search efficiency.

## 10. 
