# Week 5: Adversarial Search and Game Engines

## Learning Objectives

By the end of this lecture, you should be able to:

1. Explain adversarial search and its role in Artificial Intelligence.
2. Describe deterministic, zero-sum games with perfect information.
3. Construct and interpret a game tree.
4. Explain how the Minimax algorithm selects a move.
5. Explain Alpha-Beta Pruning and its pruning condition.
6. Compare Minimax and Alpha-Beta Pruning.
7. Describe how these algorithms are used in practical game engines.

## 1. Introduction to Adversarial Search

Imagine playing Tic-Tac-Toe against a computer. You are X, and the computer is O.

The computer must choose a move. A move that looks good immediately may allow you to win on your next turn. Therefore, the computer should consider not only its own move but also your possible response.

This is the central idea behind **adversarial search**.

Adversarial search is a decision-making technique used when an intelligent agent operates in an environment where another agent actively tries to achieve an opposing objective.

Examples include:

- Chess, where each player tries to checkmate the opponent.
- Tic-Tac-Toe, where each player tries to complete a line or prevent the opponent from doing so.
- Checkers, where players attempt to capture pieces and achieve a winning position.
- Other competitive board games in which each player anticipates the opponent's actions.

Consider the difference between route finding and game playing. When searching for a route from Quetta to Karachi, the roads do not deliberately change their behavior to prevent you from reaching your destination. In a competitive game, however, the opponent actively responds to your decisions.

A good game-playing AI must therefore consider the consequences of its actions and the possible responses of its opponent.

## 2. Fundamentals of Game Theory in AI

### 2.1 What Is Game Theory?

Game theory is the mathematical study of decision-making in situations where the outcome depends on the actions of multiple decision-makers.

In AI, game theory helps us understand competitive situations in which one agent's decisions affect another agent's results.

A simple game may follow this sequence:

1. Player A chooses a move.
2. Player B observes the move and responds.
3. The players continue taking turns.
4. The game ends with a win, loss, draw, or another defined outcome.

Each player must consider how the other player might act.

Game theory provides a framework for understanding strategic interactions. Adversarial search provides algorithms for examining possible sequences of moves and selecting an appropriate action.

### 2.2 Basic Game Terminology

| Term | Meaning | Tic-Tac-Toe example |
|---|---|---|
| Player | An agent that makes decisions | X or O |
| State | The current situation of the game | The current board |
| Action | A legal move | Placing X in an empty cell |
| Initial state | The starting position | An empty board |
| Successor state | A state reached after an action | The board after a move |
| Terminal state | A state in which the game has ended | A win, loss, or draw |
| Utility | A numerical value representing an outcome | +1, 0, or -1 |
| Game tree | A representation of possible game states and moves | All possible moves and responses |

A **state** describes a particular game position. A **game tree** represents the possible positions that can arise from sequences of legal moves.

### 2.3 Important Properties of Games

**Deterministic and stochastic games**

In a deterministic game, the next state is predictable when the current state and action are known.

For example, placing X in the top-left cell of a Tic-Tac-Toe board produces a predictable result.

A stochastic game includes random events that influence outcomes, such as dice rolls. Backgammon is an example.

**Zero-sum and non-zero-sum games**

In a zero-sum game, one player's gain corresponds to an equal loss for the other player according to the payoff model.

For example, a game that assigns +1 to the winner and -1 to the loser is zero-sum.

In a non-zero-sum game, both players may benefit, both may lose, or their interests may overlap. Some economic negotiations and cooperative situations have this property.

**Perfect and imperfect information**

A game has perfect information when players can observe the complete current state relevant to decision-making.

Chess and Tic-Tac-Toe are games of perfect information because the board and pieces are visible to both players.

Poker is an example of imperfect information because players cannot see their opponents' hidden cards.

These are separate properties. A game can be deterministic but have imperfect information, or contain randomness while revealing much of its state to all players.

### 2.4 Which Games Suit Minimax?

The basic Minimax algorithm is particularly suitable for two-player, turn-based, deterministic games of perfect information with opposing objectives.

It assumes that:

- The legal moves are known.
- The resulting state after each move can be determined.
- The players alternate making decisions.
- The players have opposing objectives represented by a utility function.
- Both players choose their moves optimally.

Tic-Tac-Toe is an excellent introductory example because its rules are simple and its game tree is small.

Chess also fits the basic deterministic, perfect-information model. However, its enormous game tree makes exhaustive search impractical. Practical chess engines therefore use depth limits, evaluation functions, and search optimizations.

## 3. Understanding Game Trees

### 3.1 Structure of a Game Tree

A game tree represents the possible sequences of moves in a game.

- The **root** represents the current game state.
- A **branch** represents a possible move.
- A **child node** represents the state reached after a move.
- The **depth** indicates how many moves have been made from the root.
- A **leaf node** is a node at which the search stops.
- A **terminal node** is a state in which the actual game has ended.

Not every leaf is a terminal state. A search algorithm may stop at a fixed depth even though the game is unfinished.

### 3.2 A Numerical Game Tree

Suppose MAX is the AI player and MIN is its opponent. MAX moves first.

```text
                    MAX
                   /   \
                  A     B
                 / \   / \
               MIN MIN MIN MIN
               / \   / \   / \
              3   5 2   9 ...
```

For our main example, use the following tree:

```text
                  MAX
                 /   \
                A     B
               MIN   MIN
              /  \   /  \
             3    5 2    9
```

The leaf values represent how favorable the outcomes are for MAX. Higher values favor MAX, while lower values favor MIN.

MAX wants the highest value. MIN wants the lowest value from MAX's perspective.

To determine MAX's best move, we work backward from the leaves toward the root.

- At A, MIN selects the smaller value: 3.
- At B, MIN selects the smaller value: 2.
- At the root, MAX selects the larger value: 3.

Therefore, MAX selects branch A.

This introduces the fundamental principle of Minimax: **MAX assumes that MIN will respond intelligently and choose the outcome that is worst for MAX.**

## 4. The Minimax Algorithm

### 4.1 Why Is Minimax Needed?

Suppose an AI has two possible moves.

The first move could lead to a score of 10 if the opponent responds poorly, but the opponent can force a score of -5. The second move guarantees a score of 2, regardless of the opponent's available responses.

A greedy strategy might choose the first move because it appears to offer 10. Minimax instead considers the opponent's best response and chooses the second move because it guarantees a better outcome.

Minimax is a decision-making algorithm based on the assumption that:

- MAX chooses the action that maximizes utility.
- MIN chooses the action that minimizes utility for MAX.
- Both players make optimal decisions.
- The rules and available actions are known.

### 4.2 How Minimax Works

Minimax evaluates a game tree from the leaves upward.

At a terminal node, the utility is already known. At a non-terminal node, the algorithm calculates the value from the values of its children.

At a MAX node, it chooses the maximum child value:

```math
V(s)=\max_{a\in A(s)} V(\operatorname{Result}(s,a))
```

At a MIN node, it chooses the minimum child value:

$$
V(s)=\min_{a\in A(s)} V(\operatorname{Result}(s,a))
$$

Here:

- \(s\) is the current state.
- \(A(s)\) is the set of legal actions in state \(s\).
- \(a\) is a possible action.
- \(\operatorname{Result}(s,a)\) is the state reached after action \(a\).
- \(V(s)\) is the value of the state from MAX's perspective.

In simple terms, MAX selects the highest available value, while MIN selects the lowest.

### 4.3 Worked Example

Use the numerical tree:

```text
                  MAX
                 /   \
                A     B
               MIN   MIN
              /  \   /  \
             3    5 2    9
```

**Step 1: Evaluate node A.**

A belongs to MIN. Its outcomes are 3 and 5.

MIN selects the smaller value:

$$
V(A)=\min(3,5)=3
$$

**Step 2: Evaluate node B.**

B also belongs to MIN. Its outcomes are 2 and 9.

$$
V(B)=\min(2,9)=2
$$

**Step 3: Evaluate the root.**

The root belongs to MAX. Its children have values 3 and 2.

$$
V(\text{root})=\max(3,2)=3
$$

**Decision:** MAX chooses branch A because it guarantees a value of 3, while branch B allows MIN to force a value of 2.

Notice that MAX does not select the leaf with value 9. MIN controls the decision at node B and would select 2 instead.

### 4.4 Minimax Pseudocode

```text
MINIMAX(state, isMaximizingPlayer):

    if state is terminal:
        return utility(state)

    if isMaximizingPlayer:
        bestValue = negative infinity

        for each legal action:
            nextState = apply action to state
            value = MINIMAX(nextState, false)
            bestValue = maximum(bestValue, value)

        return bestValue

    else:
        bestValue = positive infinity

        for each legal action:
            nextState = apply action to state
            value = MINIMAX(nextState, true)
            bestValue = minimum(bestValue, value)

        return bestValue
```

The algorithm calls itself on each successor state. This is called **recursion**.

Each call explores the next level of the game tree until it reaches a terminal state or a defined stopping condition.

After the recursive call returns a value, the algorithm compares it with the best value found so far.

The Python implementation is provided in the companion lab: `week-05-adversarial-search-lab.md`.

## 5. Alpha-Beta Pruning

### 5.1 Why Is Pruning Necessary?

Minimax may explore many branches that cannot affect its final decision.

Suppose MAX has already found a move that guarantees a value of 3. While examining another move, the algorithm discovers that MIN can force the value down to 2.

The remaining branches beneath that MIN node cannot make the branch better than MAX's existing alternative. Further exploration is unnecessary.

**Alpha-Beta Pruning is an optimization of Minimax.** It skips branches that cannot affect the final decision while preserving the Minimax value.

### 5.2 Understanding Alpha and Beta

Alpha and beta are bounds maintained during the search.

- **Alpha (\(\alpha\))** is the best lower bound on the value MAX can guarantee among the alternatives examined so far.
- **Beta (\(\beta\))** is the best upper bound that MIN can enforce for MAX among the alternatives examined so far.

Initially:

$$ 
\alpha=-\infty,\qquad \beta=+\infty
$$

At a MAX node, alpha may increase when a better value is discovered.

At a MIN node, beta may decrease when a lower value is discovered.

### 5.3 The Pruning Condition

The key condition is:

$$
\boxed{\alpha\geq\beta}
$$

When alpha becomes greater than or equal to beta, the algorithm can stop exploring the remaining children of the current node.

Why?

MAX already has an alternative worth at least alpha. MIN has already found a way to restrict MAX to at most beta in the current branch. If alpha is at least beta, the current branch cannot improve the decision at the relevant ancestor.

The exact values of the unexplored leaves are unnecessary for selecting the optimal move.

Pruning does not mean that the unexplored nodes have a value of zero. It means their values cannot change the decision being made.

### 5.4 Worked Example

Examine the same game tree from left to right:

```text
                  MAX
                 /   \
                A     B
               MIN   MIN
              /  \   /  \
             3    5 2    9
```

**Step 1: Explore branch A.**

MIN compares 3 and 5 and returns 3.

MAX can now guarantee at least 3, so the root's alpha becomes 3.

**Step 2: Explore branch B.**

The first child of B has value 2. Because B is a MIN node, its current beta becomes 2.

We now have:

$$ \alpha=3,\qquad\beta=2 $$

Since:

$$
\alpha\geq\beta
$$

the pruning condition is satisfied.

**Step 3: Prune the remaining child.**

The leaf with value 9 does not need to be evaluated. MIN can already choose the outcome worth 2 at B, so branch B cannot improve MAX's existing alternative worth 3.

**Final decision:** MAX still chooses branch A with value 3, exactly as in ordinary Minimax.

The companion lab demonstrates this process in Python and counts the evaluated leaves.

## 6. Comparing Minimax and Alpha-Beta Pruning

| Feature | Minimax | Alpha-Beta Pruning |
|---|---|---|
| Purpose | Find the best move under the game assumptions | Find the same decision more efficiently |
| Explores branches | All branches within the search limit | Skips branches that cannot affect the decision |
| Alpha and beta bounds | Not used | Used |
| Pruning condition | Not applicable | \(\alpha\geq\beta\) |
| Worst-case time | \(O(b^d)\) | \(O(b^d)\) |
| Best-case time with good move ordering | \(O(b^d)\) | Approximately \(O(b^{d/2})\) |

Here, \(b\) is the branching factor and \(d\) is the search depth.

### 6.1 Why Does Move Ordering Matter?

Alpha-Beta Pruning is more effective when promising moves are examined first.

If a strong move is found early, alpha can increase quickly. This can allow the algorithm to prune more branches later.

If poor moves are examined first, fewer branches may be pruned.

With ideal move ordering in a balanced tree, Alpha-Beta Pruning can sometimes search approximately twice as deeply with a similar number of node evaluations. This is a useful rule of thumb, not a guarantee.

**Important:** Alpha-Beta Pruning does not improve the utility function or change the underlying decision rule. It reduces unnecessary exploration while preserving the Minimax result.

## 7. From Search Algorithms to Game Engines

### 7.1 Why Is Chess Difficult to Search Exhaustively?

Chess has many legal positions and possible move sequences. Although the game is deterministic and has perfect information, exploring every possible game to its conclusion is impractical.

Suppose a simplified game tree has an average branching factor of 30.

| Search depth | Approximate number of positions |
|---:|---:|
| 1 | 30 |
| 2 | 900 |
| 3 | 27,000 |
| 4 | 810,000 |
| 5 | 24,300,000 |

These figures assume a constant branching factor of 30. Actual game trees vary, and different move sequences can sometimes reach the same position.

The important observation is that the search tree grows exponentially with depth.

### 7.2 Depth-Limited Search

A practical game engine often searches only to a fixed depth instead of exploring the entire game.

For example, a search depth of four plies means that four individual player moves are explored.

What happens if the game has not ended when the depth limit is reached?

The engine needs an evaluation function to estimate how favorable the unfinished position is.

### 7.3 Heuristic Evaluation Functions

A heuristic evaluation function estimates the value of a non-terminal game position.

A Chess engine might consider:

- Material advantage, such as having more valuable pieces.
- King safety.
- Control of the center.
- Mobility, or the number and quality of available moves.
- Pawn structure and other positional factors.

Suppose a simplified evaluation function assigns:

- Position A: +4
- Position B: -2

If positive values favor MAX, Position A is estimated to be better for MAX.

These are illustrative scores, not guaranteed outcomes. A heuristic can be inaccurate, so an AI can select the best move according to its evaluation function and still make a poor real-world decision.

### 7.4 A Simplified Game-Engine Workflow

```text
Current game state
        |
        v
Generate legal moves
        |
        v
Search the game tree
(Minimax with Alpha-Beta Pruning)
        |
        v
Evaluate terminal or depth-limited positions
        |
        v
Select the best move
        |
        v
Update the game state
```

A game engine requires more than a search algorithm. It also needs:

- A representation of the game state.
- Legal-move generation.
- Rule enforcement and terminal-state detection.
- A utility or evaluation function.
- Search and move-selection procedures.

In a practical engine, these components work together.

### 7.5 Other Practical Techniques

**Iterative deepening**

The engine searches to depth 1, then depth 2, then depth 3, continuing until it reaches its time or resource limit. It can retain the best move found at the last completed depth.

**Move ordering**

The engine examines promising moves first to improve the effectiveness of Alpha-Beta Pruning.

**Transposition tables**

Different move sequences can lead to the same position. A transposition table stores previously calculated results so they can be reused.

Modern game-playing systems may combine these techniques with opening knowledge, endgame databases, advanced evaluation functions, and machine learning.

## 8. A Tic-Tac-Toe Example

Assume the AI plays O and the opponent plays X.

Define terminal utilities from O's perspective:

- O wins: +1
- Draw: 0
- X wins: -1

O is MAX, and X is MIN.

Consider this position:

```text
X | X | .
---------
O | O | .
---------
. | . | .
```

Each player has made two moves, so it is O's turn.

O can complete the second row:

```text
X | X | .
---------
O | O | O
---------
. | . | .
```

This move wins immediately, producing utility +1.

Minimax compares legal moves and their possible consequences. Since O can win immediately, the winning move is optimal.

This example illustrates why a game-playing program must generate legal moves, detect terminal states, and evaluate outcomes correctly. Minimax and Alpha-Beta Pruning rely on these supporting components.

The companion lab contains the programming work associated with these ideas.

## 9. Common Misconceptions

**Misconception 1: Minimax always chooses the highest leaf value.**

No. It selects the best move after accounting for the opponent's decisions. MIN may prevent MAX from reaching a high-valued leaf.

**Misconception 2: Alpha-Beta Pruning changes the final decision.**

Correctly implemented pruning preserves the Minimax value for the same search tree and evaluation rules.

**Misconception 3: Alpha is the value of MAX's current node and beta is the value of MIN's current node.**

Alpha and beta are bounds carried through the search. They are not simply the final values of the current nodes.

**Misconception 4: Every leaf represents a completed game.**

A leaf may be an unfinished position where the depth limit has been reached. Such a position needs heuristic evaluation.

**Misconception 5: Alpha-Beta Pruning always provides the same speed improvement.**

Its efficiency depends on the tree and the order in which moves are explored. Its worst-case time complexity remains \(O(b^d)\).

**Misconception 6: Minimax and Alpha-Beta Pruning are complete game engines.**

They are search algorithms. A complete game-playing program also needs state representation, legal-move generation, terminal-state detection, and an appropriate evaluation function.

## 10. Essential Terminology

| Term | Meaning |
|---|---|
| Adversarial search | Search where another agent has an opposing objective |
| Game tree | A tree of possible game states and moves |
| MAX | Player seeking to maximize utility |
| MIN | Player seeking to minimize MAX's utility |
| Utility function | Numerical representation of an outcome's desirability |
| Minimax value | Value calculated assuming optimal play by both players |
| Alpha | Lower bound on the value MAX can guarantee |
| Beta | Upper bound on the value MIN can enforce |
| Pruning | Skipping exploration that cannot affect the decision |
| Branching factor | Average number of available actions at a state |
| Search depth | Number of levels explored from the root |
| Heuristic evaluation | Estimate of a non-terminal state's value |
| Ply | One player's move |
| Move ordering | Arranging candidate moves to improve search efficiency |

## 11. Review Questions

1. What is adversarial search, and how does it differ from ordinary pathfinding?
2. What is the difference between a deterministic game and a stochastic game?
3. What makes Chess a game of perfect information?
4. What do MAX and MIN represent in a game tree?
5. Why does MIN select the smallest child value?
6. What is the Minimax value of the root in the numerical example?
7. What do alpha and beta represent?
8. When can Alpha-Beta Pruning occur?
9. Does pruning change the Minimax result?
10. Why do practical game engines use depth limits and heuristic evaluation?
11. Why does move ordering affect pruning efficiency?
12. What additional components are needed to build a complete game engine?

## 12. Conclusion

Adversarial search enables an AI system to make decisions by considering both its own actions and the possible responses of an opponent.

Minimax provides the fundamental decision-making strategy: MAX chooses the highest value, while MIN chooses the lowest value from MAX's perspective. The algorithm works backward through the game tree, assuming both players act optimally.

Alpha-Beta Pruning improves the efficiency of Minimax by skipping branches that cannot change the final decision.

Practical game engines combine these algorithms with legal-move generation, terminal-state detection, depth limits, heuristic evaluation, and other optimizations.

The central lesson is:

**A good game-playing AI does not merely ask, "What is my best move?" It asks, "What is my best move, assuming my opponent will respond intelligently?"**


