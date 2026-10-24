# Lab 4: Hill-Climbing Search with the N-Queens Problem
## Generated using A.I. models and reviewed by the instructor 

## 1. Lab Objectives

In this lab, you will implement the Hill-Climbing algorithm in Python to solve the N-Queens problem.

By completing this lab, you will learn how to:

- Represent a problem as a state.
- Define an objective or evaluation function.
- Generate neighboring states.
- Implement basic Hill-Climbing.
- Record and plot evaluation scores over iterations.
- Understand why Hill-Climbing may terminate without finding a solution.
- Implement Random-Restart Hill-Climbing.
- Compare the behavior of a single search with repeated randomized searches.

## 2. Background: Local Search and Hill-Climbing

Traditional search algorithms such as Breadth-First Search (BFS), Depth-First Search (DFS), and A* commonly explore a search space to find a path from an initial state to a goal state.

In **local search**, the path is generally not important. Instead, the algorithm focuses on improving the current state until it finds a satisfactory or optimal solution.

Hill-Climbing is a greedy local search algorithm. It repeatedly examines neighboring states and moves to a better state when one is available.

The basic process is:

1. Start with an initial state.
2. Evaluate the current state.
3. Generate neighboring states.
4. Select the best neighbor.
5. Move to that neighbor if it improves the evaluation score.
6. Stop when no better neighbor is available.

### Does Hill-Climbing Always Get Stuck?

No. Hill-Climbing does not always get stuck at a local maximum.

There are two possible outcomes:

- **Successful termination:** The algorithm reaches a goal state. For N-Queens, this means that no two queens attack each other.
- **Premature termination:** The algorithm reaches a state that is better than all its immediate neighbors but is not a goal state.

The second situation is the local maximum problem.

A local maximum is not necessarily a failure. If the local maximum is also the global maximum and represents a goal, the algorithm has succeeded.

However, basic Hill-Climbing cannot guarantee that it will find a global optimum from every starting state.

## 3. The N-Queens Problem

The N-Queens problem asks us to place N queens on an N × N chessboard so that no two queens attack each other.

Queens attack each other when they occupy:

- The same row.
- The same column.
- The same diagonal.

For example, the following arrangement is a valid solution for four queens:

```text
. Q . .
. . . Q
Q . . .
. . Q .
```

No two queens share a row, column, or diagonal.

## 4. Representing a State

We will represent the board using a Python list.

For example:

```python
state = [1, 3, 0, 2]
```

The index represents the column, and the value represents the row of the queen.

Therefore:

```text
Column:  0  1  2  3
Row:     1  3  0  2
```

The corresponding board is:

```text
. . Q .
Q . . .
. . . Q
. Q . .
```

This representation automatically guarantees that each column contains exactly one queen.

### Task 1

Create the state and print it.

```python
state = [1, 3, 0, 2]

print("State:", state)
```

## 5. Generating a Random Initial State

Hill-Climbing starts from an initial state. We will generate a random row position for the queen in each column.

### Code Cell

```python
import random

def random_state(n):
    return [random.randrange(n) for _ in range(n)]

state = random_state(8)

print("Random initial state:", state)
```

Run the cell several times. You may obtain a different state each time.

For example:

```text
Random initial state: [2, 5, 1, 7, 0, 3, 6, 4]
```

A randomly generated state is not necessarily a solution. Some queens may attack each other.

## 6. Defining the Evaluation Function

Hill-Climbing needs a way to determine whether one state is better than another.

For this problem, we will count the number of pairs of queens attacking each other.

Our objective is to minimize the number of conflicts.

A valid solution has zero conflicts.

However, to express the problem as a maximization problem, we will define:

`Evaluation score = - Number of conflicts`

Examples:

| Number of conflicts | Evaluation score |
|---:|---:|
| 5 | -5 |
| 3 | -3 |
| 1 | -1 |
| 0 | 0 |

A higher score is better. Therefore, zero is the best possible score.

### Code Cell: Count Conflicts

```python
def count_conflicts(state):
    conflicts = 0
    n = len(state)

    for i in range(n):
        for j in range(i + 1, n):

            # Queens in the same row
            if state[i] == state[j]:
                conflicts += 1

            # Queens on the same diagonal
            elif abs(state[i] - state[j]) == abs(i - j):
                conflicts += 1

    return conflicts
```

Test the function:

```python
state = [1, 3, 0, 2]

print("Conflicts:", count_conflicts(state))
```

Expected output:

```text
Conflicts: 0
```

### Code Cell: Evaluation Function

```python
def evaluation(state):
    return -count_conflicts(state)

state = [1, 3, 0, 2]

print("Evaluation score:", evaluation(state))
```

Expected output:

```text
Evaluation score: 0
```

## 7. Generating Neighboring States

A neighbor is a state that can be reached by making a small change to the current state.

In our implementation, we move one queen to another row in the same column.

For example, if the current state is:

```python
state = [1, 3, 0, 2]
```

Moving the queen in column 0 to row 0 produces:

```python
[0, 3, 0, 2]
```

Moving the same queen to row 2 produces:

```python
[2, 3, 0, 2]
```

We generate every state obtainable by moving one queen to another row in its column.

### Code Cell

```python
def get_neighbors(state):
    neighbors = []
    n = len(state)

    for col in range(n):
        for row in range(n):

            if row != state[col]:
                neighbor = state.copy()
                neighbor[col] = row
                neighbors.append(neighbor)

    return neighbors
```

Test the function:

```python
state = [1, 3, 0, 2]

neighbors = get_neighbors(state)

print("Number of neighbors:", len(neighbors))
print("First five neighbors:")

for neighbor in neighbors[:5]:
    print(neighbor)
```

For a board of size N, each state has:

`N × (N - 1)` neighbors.

For N = 8:

`8 × 7 = 56 neighbors`

## 8. Implementing Basic Hill-Climbing

We now have the three main components:

1. State representation.
2. Evaluation function.
3. Neighbor-generation function.

The following algorithm starts from a random state, repeatedly selects the best neighbor, and stops when no neighbor improves the current score.

It also records the evaluation score at each iteration so that we can plot the optimization process.

### Code Cell

```python
def hill_climbing(n):

    current = random_state(n)
    scores = []

    while True:

        # Evaluate the current state
        current_score = evaluation(current)
        scores.append(current_score)

        # Generate all neighboring states
        neighbors = get_neighbors(current)

        # Find the best neighbor
        best_neighbor = max(neighbors, key=evaluation)
        best_score = evaluation(best_neighbor)

        # Stop if no neighbor improves the current score
        if best_score <= current_score:
            break

        # Move to the better neighbor
        current = best_neighbor

    return current, scores
```

## 9. Running Hill-Climbing

Run the algorithm for eight queens.

### Code Cell

```python
solution, scores = hill_climbing(8)

print("Final state:", solution)
print("Final conflicts:", count_conflicts(solution))
print("Final evaluation score:", evaluation(solution))
print("Number of iterations:", len(scores))

if count_conflicts(solution) == 0:
    print("A valid solution was found.")
else:
    print("Hill-Climbing stopped without finding a solution.")
```

Your results may differ between runs because the initial state is random.

You may find a valid solution with zero conflicts. Alternatively, the algorithm may stop at a state with remaining conflicts.

This is expected behavior, not necessarily a programming error.

### Why Can the Algorithm Stop Without Solving the Problem?

Suppose the current evaluation score is -2, and the neighboring states have the following scores:

```text
-3, -4, -2, -5
```

None of these neighbors is better than the current state.

Therefore, Hill-Climbing stops.

However, a state with a score of zero may exist elsewhere in the state space.

The algorithm has reached a local maximum with respect to its neighborhood, but it has not reached the goal.

**Important:** Hill-Climbing is not guaranteed to find a solution from every starting state. Getting stuck at a non-goal local maximum is a possibility, not an inevitable outcome.

## 10. Visualizing the Chessboard

We will create a function to display the current arrangement of queens.

### Code Cell

```python
def print_board(state):

    n = len(state)

    for row in range(n):

        line = ""

        for col in range(n):

            if state[col] == row:
                line += "Q "
            else:
                line += ". "

        print(line)
```

Display the result:

```python
print_board(solution)
```

If a solution is found, no two queens should attack each other.

If the algorithm stops at a non-solution state, the board will still be displayed, but some queens may attack each other.

## 11. Plotting the Evaluation Score

A graph helps us observe how the evaluation score changes during the search.

### Code Cell

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(9, 5))

plt.plot(
    range(len(scores)),
    scores,
    marker="o"
)

plt.xlabel("Iteration")
plt.ylabel("Evaluation Score")
plt.title("Hill-Climbing Optimization: N-Queens")

plt.grid(True)
plt.show()
```

### Interpret the Graph

Answer these questions:

1. Does the evaluation score increase as the algorithm moves to better states?
2. Does the score decrease during a move accepted by this implementation?
3. What happens when the algorithm reaches a state with no better neighbor?
4. What does an evaluation score of zero mean?
5. Can the algorithm stop at a score below zero? Explain why.

The score is non-decreasing because the algorithm accepts only improving moves. The final score may be zero or negative.

If the final score is zero, the goal has been reached. If it is negative, the algorithm has stopped without finding a valid solution.

## 12. Experimenting with Different Board Sizes

Run Hill-Climbing with different values of N.

### Code Cell

```python
for n in [4, 8, 10, 12]:

    solution, scores = hill_climbing(n)

    print(
        f"N = {n:2d} | "
        f"Conflicts = {count_conflicts(solution):2d} | "
        f"Iterations = {len(scores):3d} | "
        f"Solved = {count_conflicts(solution) == 0}"
    )
```

### Task 2

Run the experiment several times.

Record your observations in the following table.

| N | Run | Final Conflicts | Iterations | Solved? |
|---:|---:|---:|---:|---|
| 4 | 1 | | | |
| 4 | 2 | | | |
| 8 | 1 | | | |
| 8 | 2 | | | |
| 8 | 3 | | | |
| 10 | 1 | | | |
| 10 | 2 | | | |
| 10 | 3 | | | |

Discuss whether the same board size always produces the same result.

## 13. Improving the Search: Random-Restart Hill-Climbing

Basic Hill-Climbing uses a single initial state. If the search stops at a non-goal local maximum, the algorithm terminates without finding a solution.

One way to improve the chances of success is **Random-Restart Hill-Climbing**.

The algorithm repeatedly runs Hill-Climbing from new random starting states.

The process is:

1. Generate a random initial state.
2. Run Hill-Climbing until it stops.
3. Check whether a solution was found.
4. If a solution was found, return it.
5. Otherwise, start again from a new random state.
6. Stop when a solution is found or the restart limit is reached.

### What Does Probabilistically Complete Mean?

An algorithm is **probabilistically complete** if the probability of finding a solution approaches 1 as the search effort increases, provided that a solution exists and the algorithm's assumptions hold.

In simpler words:

> If we continue giving the algorithm independent opportunities to search, its chance of finding a solution can get closer and closer to 100%.

This does not guarantee success within a fixed number of restarts.

Suppose a randomized search has a 20% probability of finding a solution in each independent run.

The probability of failure in one run is:

`1 - 0.20 = 0.80`

If each run is independent, the probability that all k runs fail is:

`P(all fail) = 0.80^k`

Therefore, the probability of finding at least one solution is:

`P(success) = 1 - 0.80^k`

For example:

| Independent runs | Probability of finding a solution |
|---:|---:|
| 1 | 20.00% |
| 2 | 36.00% |
| 5 | 67.23% |
| 10 | 89.26% |
| 20 | 98.85% |

These numbers are illustrative; they are not measured success rates for N-Queens.

The principle is that repeated independent attempts reduce the probability of repeated failure.

For Random-Restart Hill-Climbing, probabilistic completeness requires that there is a nonzero probability of a restart leading to a solution. If the probability of success per independent run is p, where p is greater than zero, then:

`P(success within k runs) = 1 - (1 - p)^k`

As k increases, this probability approaches 1.

If no possible restart can lead to a solution under the chosen algorithm and neighborhood, repeated restarts will not help.

## 14. Implementing Random-Restart Hill-Climbing

The following implementation keeps track of the best state found and records the best evaluation score after every restart.

It stops early if a valid solution is found.

### Code Cell

```python
def random_restart_hill_climbing(n, max_restarts=100):

    best_state = None
    best_score = float("-inf")
    best_scores = []

    for restart in range(max_restarts):

        # Start a new Hill-Climbing run
        state, scores = hill_climbing(n)

        score = evaluation(state)

        # Keep the best state found so far
        if score > best_score:
            best_state = state
            best_score = score

        # Record the best score after this restart
        best_scores.append(best_score)

        # A score of zero means a valid solution
        if best_score == 0:
            return best_state, restart + 1, best_scores

    return best_state, max_restarts, best_scores
```

### Code Cell: Run the Algorithm

```python
solution, restarts, best_scores = (
    random_restart_hill_climbing(8, max_restarts=100)
)

print("Final state:", solution)
print("Final conflicts:", count_conflicts(solution))
print("Restarts performed:", restarts)

if count_conflicts(solution) == 0:
    print("A valid solution was found.")
else:
    print("No solution was found within the restart limit.")

print_board(solution)
```

A valid solution should have zero conflicts.

If no solution is found within 100 restarts, the algorithm returns the best state encountered during those attempts.

The restart limit is a practical stopping condition, not a guarantee of success.

## 15. Plotting Random-Restart Progress

In the previous graph, we plotted the evaluation score during one Hill-Climbing run.

Now we will plot the **best evaluation score found so far** after each restart.

### Code Cell

```python
plt.figure(figsize=(9, 5))

plt.plot(
    range(1, len(best_scores) + 1),
    best_scores,
    marker="o"
)

plt.xlabel("Restart")
plt.ylabel("Best Evaluation Score So Far")
plt.title("Random-Restart Hill-Climbing: N-Queens")

plt.grid(True)
plt.show()
```

### Interpret the Graph

The graph should be non-decreasing because the algorithm retains the best result found so far.

For example, the best score might change as follows:

```text
-5, -3, -3, -2, -1, 0
```

The algorithm improves the best-known result over several restarts.

Once the score reaches zero, a valid solution has been found, and the algorithm stops.

**Remember the difference:**

- The single-run graph shows the score during one search.
- The random-restart graph shows the best score retained across repeated searches.

## 16. Comparing Basic and Random-Restart Hill-Climbing

Run both algorithms five times.

### Code Cell

```python
print("Basic Hill-Climbing")
print("-------------------")

for i in range(5):

    state, scores = hill_climbing(8)
    conflicts = count_conflicts(state)

    print(
        f"Run {i + 1}: "
        f"Conflicts = {conflicts}, "
        f"Iterations = {len(scores)}, "
        f"Solved = {conflicts == 0}"
    )


print("\nRandom-Restart Hill-Climbing")
print("----------------------------")

for i in range(5):

    state, restarts, best_scores = (
        random_restart_hill_climbing(8, max_restarts=100)
    )

    conflicts = count_conflicts(state)

    print(
        f"Run {i + 1}: "
        f"Conflicts = {conflicts}, "
        f"Restarts = {restarts}, "
        f"Solved = {conflicts == 0}"
    )
```

### Task 3

Compare the results.

1. Did basic Hill-Climbing find a solution in every run?
2. Did Random-Restart Hill-Climbing improve the results?
3. How many restarts were needed to find a solution?
4. Did any random-restart experiment reach its restart limit without finding a solution?
5. Why can Random-Restart improve the probability of success without guaranteeing success within a fixed number of attempts?

Your results will depend on the random starting states.

## 17. Lab Questions

Answer the following questions in Markdown cells in your notebook.

### Question 1

What is the purpose of the evaluation function in Hill-Climbing?

### Question 2

Why is an evaluation score of zero the best result in our N-Queens implementation?

### Question 3

What is the difference between a local maximum and a global maximum?

### Question 4

Why can basic Hill-Climbing stop without finding a solution even when a solution exists?

### Question 5

Does reaching a local maximum always mean that the algorithm has failed? Explain.

### Question 6

For N = 8, how many neighbors does each state have in our implementation?

### Question 7

What does the evaluation-score graph tell you about the behavior of Hill-Climbing?

### Question 8

Explain probabilistic completeness in your own words.

### Question 9

Why does Random-Restart Hill-Climbing improve the chance of finding a solution?

### Question 10

Does probabilistic completeness guarantee that a solution will be found within 100 restarts? Why or why not?

## 18. Extension Task

Modify the experiment to solve the N-Queens problem for N = 20.

Record the following:

- Number of conflicts in the final state.
- Number of iterations in a basic Hill-Climbing run.
- Number of restarts required by Random-Restart Hill-Climbing.
- Whether a valid solution was found.

Compare the results of basic and Random-Restart Hill-Climbing.

Discuss how the number of queens and the random initial state affect the search process.

## 19. Final Learning Outcomes

After completing this lab, you should be able to:

- Explain the difference between traditional search and local search.
- Represent the N-Queens problem as a state-space problem.
- Define an objective function and generate neighboring states.
- Implement basic Hill-Climbing in Python.
- Plot evaluation scores over iterations.
- Explain local maxima and premature termination.
- Implement Random-Restart Hill-Climbing.
- Explain probabilistic completeness and its assumptions.
- Compare optimization behavior across multiple randomized runs.

## Key Takeaway

**Hill-Climbing repeatedly improves the current state until no better neighboring state is available. It may find the goal, or it may stop at a non-goal local maximum. Random restarts provide additional opportunities to find a solution, but success within a fixed number of attempts is not guaranteed.**
