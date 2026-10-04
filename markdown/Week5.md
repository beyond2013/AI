# Week 4: Local Search Optimization

Welcome to Week 4! In traditional search algorithms (like BFS, DFS, or A*), our primary goal is to **find a path** from a starting state to a goal state.

In **Local Search Optimization**, the path does not matter at all—only the **final state** (the destination) matters.

## 1. What Is an Optimization Problem?

In an optimization problem, you want to find the **best solution** according to an **objective function** (a formula or score that measures how good a solution is).

- **Path-dependent search (e.g., GPS Navigation):** You care about *how* to drive from point A to point B (turn left, then right).

- **Local search (e.g., Choosing the best house location):** You do not care about the order in which you look at houses; you only care about ending up with the best house score possible.

### Key Characteristics of Local Search

1. Keeps track of a **current state** and evaluates its neighbors.
2. Moves iteratively to neighbor states.
3. Uses very **little memory** because it does not need to remember the history or path.

## 2. The Core Algorithm: Hill-Climbing Search

**Hill-Climbing** is the most fundamental local search algorithm. It is often described as trying to climb a mountain in a thick fog:

> Look around at your immediate neighboring steps, take a step in whichever direction goes highest uphill, and repeat until every direction leads downward.

### How Hill-Climbing Works (Greedy Local Search)

1. Evaluate your **current state**.
2. Examine all immediate **neighbor states**.
3. Choose the neighbor with the best score:
   - If that neighbor is better than your current state, move to that neighbor.
   - If no neighbor is better than your current state, **stop and return the current state**.

## 3. The Major Challenges of Hill-Climbing

Because Hill-Climbing is "greedy" (it only looks at immediate neighbors and never makes a move that temporarily lowers its score), it can easily get stuck before finding the best overall solution.

To understand these challenges, imagine a landscape with peaks, flat areas, and valleys:

```text
Objective
Function
   ^
   |                Global Maxima
   |                     /\
   |      Local         /  \
   |     Maxima        /    \   Plateau
   |       /\         /      \___________
   |      /  \  Shoulder              \
   |  ___/    \___/                    \
   +---------------------------------------> State Space
```

1. **Local Maxima:** A peak that is higher than all its immediate neighbors, but lower than the **Global Maxima** (the absolute highest peak overall). Once Hill-Climbing reaches a local maximum, it stops because every neighbor looks worse.

2. **Plateaus:** A flat area where neighboring states have the exact same score. The algorithm has no guidance on which direction to move.

3. **Ridges:** A sequence of local maxima that makes navigation difficult because moving in any single cardinal direction leads downhill, even though an upward path exists along a diagonal.

## 4. Variants & Solutions

To overcome the weaknesses of basic Hill-Climbing, several variants exist:

### A. Stochastic & First-Choice Hill-Climbing

- **Stochastic:** Chooses randomly among the uphill moves.

- **First-Choice:** Generates neighbors randomly one by one and takes the *first* move that improves the current score (useful when states have thousands of neighbors).

### B. Random-Restart Hill-Climbing

- **Concept:** *"If at first you don't succeed, try, try again."*

- **How it works:** Runs standard Hill-Climbing from a randomly generated starting point. If it gets stuck at a local maximum, it saves the result, generates a **brand new random starting point**, and runs Hill-Climbing again.

- **Why it works:** It is **probabilistically complete** under suitable conditions. Given enough independent restarts and a nonzero probability of starting in a region that leads to the global maximum, the probability of finding the global maximum approaches 1.

## Summary Cheat Sheet

| **Concept** | **Definition** |
|-------------|----------------|
| **Optimization Search** | Finding the best state according to an objective function, where path history does not matter. |
| **Hill-Climbing** | An algorithm that continually moves in the direction of increasing value (greedy approach). |
| **Local Maxima** | A sub-optimal peak where all neighbors are worse; causes standard Hill-Climbing to terminate prematurely. |
| **Plateau** | A flat region in the state space where neighbors have equal scores. |
| **Random-Restart** | Addresses local maximum problems by repeatedly restarting Hill-Climbing from random states until a satisfactory solution is found. |