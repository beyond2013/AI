# Week 5: Adversarial Search and Game Engines

**Course:** Artificial Intelligence\
**Level:** Undergraduate BS Computer Science / BS Information Technology

## Learning Objectives

By the end of this lecture, you should be able to:

1.  Explain adversarial search and its role in game-playing Artificial
    Intelligence.
2.  Describe deterministic, zero-sum games with perfect information.
3.  Construct and interpret a game tree.
4.  Explain how the Minimax algorithm selects a move.
5.  Apply Alpha-Beta Pruning to avoid unnecessary exploration.
6.  Implement both algorithms in Python 3.
7.  Compare their efficiency and explain how they are used in practical
    game engines.

## 1. Introduction: How Does an AI Play a Game Intelligently?

Imagine that you are playing Tic-Tac-Toe against a computer. You are X,
and the computer is O.

The computer has three possible moves. One move may look attractive
because it places O in an empty corner. However, if that move allows you
to complete a row of Xs on your next turn, it is a poor decision.

A sensible computer must do more than examine its immediate move. It
must consider what you might do in response, how it could respond to
your move, and whether the resulting position is favorable.

This is the central idea behind **adversarial search**.

Adversarial search is a search technique used when an intelligent agent
must make decisions in an environment where another agent is actively
trying to achieve an opposing objective.

Examples include:

-   Chess, where each player tries to checkmate the opponent.
-   Tic-Tac-Toe, where one player tries to form a line while the other
    tries to prevent it.
-   Checkers, where players try to capture pieces and achieve a winning
    position.
-   Strategic board games in which each player must anticipate the
    other's decisions.

In an ordinary search problem, such as finding a route from Quetta to
Karachi, the goal is to find a path to a destination. The road network
does not deliberately change its behavior to prevent you from reaching
Karachi.

In a competitive game, however, the opponent actively responds to your
actions. A move that appears good initially may become bad after the
opponent's response.

Therefore, a game-playing AI must consider both its own decisions and
the possible decisions of its opponent.

## 2. Fundamentals of Game Theory in AI

### 2.1 What Is Game Theory?

Game theory is the mathematical study of decision-making in situations
where the outcome depends on the actions of multiple decision-makers.

In Artificial Intelligence, game theory helps us reason about situations
in which one agent's actions affect another agent's results.

Consider a simple game:

1.  Player A chooses a move.
2.  Player B observes that move and chooses a response.
3.  The game eventually ends.
4.  The final outcome determines who wins, loses, or draws.

Each player must consider how the other player might act.

Game theory provides a way to reason about these interactions.
Adversarial search provides computational techniques for exploring
possible sequences of moves and selecting a suitable action.

### 2.2 Basic Terminology

  -----------------------------------------------------------------------
  Term                    Meaning                 Example in Tic-Tac-Toe
  ----------------------- ----------------------- -----------------------
  Player                  An agent that makes     X or O
                          decisions               

  State                   The current situation   The current arrangement
                          of the game             of Xs and Os

  Action or move          A legal decision        Placing X in an empty
                          available to a player   cell

  Initial state           The state in which the  An empty board
                          game begins             

  Successor state         A state reached after   The board after placing
                          an action               O

  Terminal state          A state in which the    X wins, O wins, or a
                          game has ended          draw

  Utility                 A numerical value       +1 for a win, -1 for a
                          representing the        loss, 0 for a draw
                          outcome's desirability  

  Game tree               A representation of     All possible moves and
                          possible sequences of   responses from a
                          moves                   position
  -----------------------------------------------------------------------

A **state** describes one particular position in a game. A **game tree**
represents the possible positions that can arise as players make
different sequences of moves.

For example, one Tic-Tac-Toe board is a state. The collection of
possible boards resulting from all legal moves from that board forms a
tree of possibilities.

### 2.3 Important Properties of Games

**Deterministic versus stochastic games**

A deterministic game has no random event that determines the next state.
Given the current state and a particular legal action, the resulting
state is predictable.

For example, in Tic-Tac-Toe, placing X in the top-left cell produces a
predictable board.

A stochastic game includes randomness, such as dice rolls or random card
draws. Backgammon is an example because dice affect the available
outcomes.

**Zero-sum versus non-zero-sum games**

A zero-sum game is one in which one player's gain corresponds to an
equal loss for the other player, according to the game's payoff model.

For example, if a simplified competitive game assigns +1 to the winner
and -1 to the loser, one player's winning outcome is the other's losing
outcome.

A non-zero-sum game allows outcomes in which both players can benefit or
both can suffer. Some economic negotiations and cooperative games have
this property.

**Perfect information versus imperfect information**

A game has perfect information when all players can observe the complete
current game state relevant to decision-making.

Chess and Tic-Tac-Toe are games of perfect information: players can see
the board and the pieces.

Poker is an example of imperfect information because a player cannot see
the opponents' hidden cards.

These properties are different dimensions. A game can be deterministic
but have imperfect information, or include randomness while exposing
much of its state to all players.

### 2.4 Which Games Suit Minimax?

The basic Minimax algorithm is particularly suitable for games with the
following characteristics:

-   Two players take turns making decisions.
-   The players have opposing objectives.
-   One player's benefit corresponds to the other's disadvantage in the
    utility model.
-   The game is deterministic.
-   The game has perfect information.
-   The legal actions and resulting states can be generated.

Tic-Tac-Toe is an ideal introductory example because its rules are
simple and its game tree is small enough to examine.

Chess also fits the basic deterministic, perfect-information model, but
its enormous game tree makes exhaustive search impractical. Practical
chess engines therefore use search limits, evaluation functions, and
other optimizations.

## 3. Understanding Game Trees

### 3.1 What Is a Game Tree?

A game tree is a tree-shaped representation of the possible moves in a
game.

-   The **root** represents the current game state.
-   A **branch** represents a possible move.
-   A **child node** represents the state reached after a move.
-   The **depth** indicates how many moves have been made from the root.
-   A **leaf node** is a node at which the search stops.
-   A **terminal node** is a state in which the actual game has ended.

Not every leaf node is necessarily terminal. If the algorithm stops
searching after a fixed number of moves, a leaf may represent an
unfinished game position that requires an estimate of its value.

### 3.2 A Small Game Tree

Suppose MAX is the AI player and MIN is its opponent. MAX moves first.

``` text
                         MAX
                        /   \
                       A     B
                      / \   / \
                    MIN MIN MIN MIN
                    / \   / \   / \
                   3   5 2   9 ...
```

A simpler numerical tree for the example is:

``` text
                  MAX
                 /   \
                A     B
               MIN   MIN
              /  \   /  \
             3    5 2    9
```

The leaf values 3, 5, 2, and 9 represent how favorable the resulting
outcomes are for MAX. Higher values favor MAX; lower values favor MIN.

MAX wants to obtain the highest possible value. MIN wants to make the
outcome as unfavorable as possible for MAX.

To decide what MAX should do, we work backward from the leaves toward
the root.

-   At node A, MIN chooses the smaller of 3 and 5, giving 3.
-   At node B, MIN chooses the smaller of 2 and 9, giving 2.
-   At the root, MAX chooses the larger of 3 and 2, giving 3.

Thus, MAX chooses branch A.

This simple example introduces the main idea behind Minimax: **MAX
assumes that MIN will respond intelligently and choose the move that is
worst for MAX.**

## 4. The Minimax Algorithm

### 4.1 Why Do We Need Minimax?

Suppose an AI has two possible moves. The first move could lead to a
score of 10 if the opponent makes a poor response, but the opponent can
force a score of -5. The second move guarantees a score of 2, regardless
of the opponent's available responses.

A greedy strategy might choose the first move because it appears to
offer a score of 10. Minimax instead considers the opponent's best
response and chooses the second move because it guarantees a better
outcome.

Minimax is a decision-making algorithm that selects a move by assuming
that:

-   MAX always chooses the action that maximizes the utility.
-   MIN always chooses the action that minimizes the utility for MAX.
-   Both players make optimal decisions.
-   The rules and available actions are known.

This is a cautious strategy: MAX does not assume that its opponent will
make mistakes.

### 4.2 How Does Minimax Work?

Minimax works from the bottom of the game tree upward.

At a terminal node, the utility is already known. At a non-terminal
node, the algorithm calculates the value from the values of its
children.

The rules are:

-   At a MAX node, choose the **maximum** child value.
-   At a MIN node, choose the **minimum** child value.

The value of a node is called its *Minimax value*.

For a MAX node:

\[
V(s)=`\max`{=tex}\_{a`\in `{=tex}A(s)}V(`\operatorname{Result}`{=tex}(s,a))
\]

For a MIN node:

\[
V(s)=`\min`{=tex}\_{a`\in `{=tex}A(s)}V(`\operatorname{Result}`{=tex}(s,a))
\]

Here:

-   \(s\) is the current game state.
-   (A(s)) is the set of legal actions available in state (s).
-   \(a\) is one possible action.
-   (`\operatorname{Result}`{=tex}(s,a)) is the state reached after
    taking action (a).
-   (V(s)) is the value of the state from MAX's perspective.

In plain English, the algorithm evaluates the possible next states and
selects the highest value when it is MAX's turn or the lowest value when
it is MIN's turn.

### 4.3 A Complete Worked Example

Consider this game tree:

``` text
                    MAX
                     3
                   /   \
                A         B
               MIN       MIN
                3         2
              /  \      /   \
             3    5    2     9
```

**Step 1: Evaluate node A.**

Node A belongs to MIN. Its available outcomes are 3 and 5.

MIN chooses the smaller value:

\[ V(A)=`\min`{=tex}(3,5)=3 \]

**Step 2: Evaluate node B.**

Node B also belongs to MIN. Its available outcomes are 2 and 9.

\[ V(B)=`\min`{=tex}(2,9)=2 \]

**Step 3: Evaluate the root.**

The root belongs to MAX. Its children have values 3 and 2.

\[ V(`\text{root}`{=tex})=`\max`{=tex}(3,2)=3 \]

**Final decision:** MAX selects branch A because it guarantees a value
of 3, whereas branch B allows MIN to force a value of 2.

Notice that MAX does not select the leaf with the highest value, 9. That
leaf lies beyond MIN's decision, and MIN would choose 2 instead. The
algorithm accounts for the opponent's control over its own turns.

### 4.4 Minimax Pseudocode

``` text
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

The algorithm calls itself on each successor state. This is called
*recursion*. Each recursive call explores the next level of the game
tree until it reaches a terminal state or another defined stopping
condition.

After returning the value, the algorithm compares it with the best value
found so far and eventually returns the value of the current state.

### 4.5 Python Implementation of Minimax

We can implement the same numerical game tree using Python.

``` python
def minimax(tree, is_maximizing):
    # A leaf is represented by a number.
    if isinstance(tree, (int, float)):
        return tree

    if is_maximizing:
        best_value = float("-inf")

        for child in tree:
            value = minimax(child, False)
            best_value = max(best_value, value)

        return best_value

    else:
        best_value = float("inf")

        for child in tree:
            value = minimax(child, True)
            best_value = min(best_value, value)

        return best_value


# Root is MAX; its children are MIN nodes.
game_tree = [
    [3, 5],   # Branch A: MIN chooses 3
    [2, 9]    # Branch B: MIN chooses 2
]

best_value = minimax(game_tree, True)

print("Best Minimax value:", best_value)
```

Expected output:

``` text
Best Minimax value: 3
```

**Understanding the code**

1.  `tree` represents the current part of the game tree. A number
    represents a leaf; a list represents a non-terminal node and its
    children.
2.  `is_maximizing` tells the function whose turn it is.
3.  If `tree` is a number, the function has reached a leaf and returns
    its utility.
4.  At a MAX node, `best_value` begins at negative infinity. Each
    child's value is calculated, and the largest is retained.
5.  At a MIN node, `best_value` begins at positive infinity. Each
    child's value is calculated, and the smallest is retained.
6.  The recursive call switches the player from MAX to MIN or from MIN
    to MAX.
7.  The final result is the value of the root, which is 3.

This implementation calculates the best value, but it does not
explicitly return which root-level action achieves it. A game-playing
program can track the best action along with the value to choose the
actual move.

### 4.6 Time and Space Complexity

Let:

-   \(b\) be the average branching factor, or number of legal actions at
    each node.
-   \(d\) be the maximum search depth.

If Minimax explores a full tree of depth (d), its time complexity is
approximately:

\[ O(b\^d) \]

The exponential growth is the main difficulty. If each state has 10
possible moves, for example, exploring 5 levels can involve up to
(10\^5=100{,}000) leaf positions.

A typical recursive implementation stores the current path and its local
variables, requiring (O(d)) auxiliary space for depth-first traversal,
excluding the representation of the tree itself.

This is manageable for small games but becomes expensive for games such
as Chess. We therefore need ways to reduce the amount of search.

## 5. Alpha-Beta Pruning

### 5.1 Why Is Pruning Necessary?

Minimax can make excellent decisions, but it may explore many branches
that cannot affect the final decision.

Imagine that MAX has already found a move that guarantees a value of 3.
When examining another move, the algorithm discovers that MIN can force
the value down to 2.

No matter what other outcomes are hidden beyond that MIN node, MIN can
choose an outcome of 2 or lower than MAX's current alternative of 3.
That branch cannot improve MAX's decision.

Alpha-Beta Pruning allows the algorithm to stop exploring such branches.

**Alpha-Beta Pruning is an optimization of Minimax.** It does not change
the underlying decision rule. When implemented correctly, it returns the
same Minimax value and optimal move while potentially examining fewer
nodes.

### 5.2 What Do Alpha and Beta Mean?

Alpha and beta are two bounds maintained during the search.

-   **Alpha ((`\alpha`{=tex}))** is the best value MAX can guarantee
    from the alternatives examined so far. It is a lower bound on the
    value MAX can achieve.
-   **Beta ((`\beta`{=tex}))** is the best upper bound that MIN can
    enforce for MAX among the alternatives examined so far.

Initially, the bounds are:

\[
`\alpha`{=tex}=-`\infty`{=tex},`\qquad `{=tex}`\beta`{=tex}=+`\infty`{=tex}
\]

As the algorithm explores the tree, these values become more
restrictive.

At a MAX node, alpha may increase when a better value is found. At a MIN
node, beta may decrease when a lower value is found.

### 5.3 The Pruning Condition

The central rule is:

\[ `\boxed{\alpha\geq\beta}`{=tex} \]

When alpha becomes greater than or equal to beta, the algorithm can stop
examining the remaining children of the current node.

Why?

MAX already has an alternative worth at least alpha. MIN already has an
alternative that can restrict MAX to at most beta. If alpha is at least
beta, the remaining exploration cannot produce a result that improves
the decision for the player whose choice matters at the ancestor node.

More precisely, the bounds show that the current branch cannot change
the root's optimal value. The branch may contain different leaf scores,
but discovering them is unnecessary for selecting the optimal move.

Pruning does not mean the unexplored nodes have a value of zero. It
means their exact values are not needed for the final decision.

### 5.4 A Step-by-Step Alpha-Beta Example

Consider the same game tree, with children examined from left to right:

``` text
                    MAX
                 value = 3
                 /       \
                A         B
               MIN       MIN
             value=3   current=2
              /  \      /   \
             3    5    2    9 (pruned)
```

**Step 1: Start at the root.**

At the beginning, no alternative has been examined:

\[
`\alpha`{=tex}=-`\infty`{=tex},`\qquad `{=tex}`\beta`{=tex}=+`\infty`{=tex}
\]

**Step 2: Examine branch A.**

The first leaf has value 3. MIN's current best value at A becomes 3.

The second leaf has value 5. MIN still chooses 3, because it wants the
smaller value.

The value of A is therefore 3. MAX can now guarantee a value of at least
3, so the root's alpha becomes 3.

**Step 3: Move to branch B.**

The first child of B has value 2. Since B is a MIN node, its current
best value is now 2, so beta at B becomes 2.

We now have:

\[ `\alpha=3`{=tex},`\qquad `{=tex}`\beta=2`{=tex} \]

Since (`\alpha`{=tex}`\geq`{=tex}`\beta`{=tex}), the pruning condition
is satisfied.

**Step 4: Prune the remaining child.**

The unexplored leaf has value 9, but its value is irrelevant to the root
decision. MIN can already select the outcome worth 2 at B. Thus, B
cannot offer MAX a value better than the 3 already available through A.

The algorithm skips the leaf with value 9.

**Final decision:** MAX still chooses branch A with value 3, just as in
ordinary Minimax.

### 5.5 Alpha-Beta Pruning Pseudocode

``` text
ALPHA_BETA(state, depth, alpha, beta, isMaximizingPlayer):

    if state is terminal or depth limit reached:
        return evaluate(state)

    if isMaximizingPlayer:
        value = negative infinity

        for each legal action:
            nextState = apply action to state

            childValue = ALPHA_BETA(
                nextState, depth + 1,
                alpha, beta, false
            )

            value = maximum(value, childValue)
            alpha = maximum(alpha, value)

            if alpha >= beta:
                break

        return value

    else:
        value = positive infinity

        for each legal action:
            nextState = apply action to state

            childValue = ALPHA_BETA(
                nextState, depth + 1,
                alpha, beta, true
            )

            value = minimum(value, childValue)
            beta = minimum(beta, value)

            if alpha >= beta:
                break

        return value
```

This version uses a depth limit as an optional stopping condition. If
the entire game tree is explored, the search can stop at terminal
states. In a depth-limited search, the evaluation function must also
handle unfinished states.

The key additional operations compared with Minimax are updating alpha
or beta and checking whether the pruning condition has been met.

### 5.6 Python Implementation of Alpha-Beta Pruning

The following implementation uses exactly the same game tree as the
Minimax example.

``` python
def alpha_beta(tree, is_maximizing, alpha, beta, stats):
    # A leaf is represented by a number.
    if isinstance(tree, (int, float)):
        stats["leaves"] += 1
        return tree

    if is_maximizing:
        best_value = float("-inf")

        for child in tree:
            value = alpha_beta(
                child, False, alpha, beta, stats
            )

            best_value = max(best_value, value)
            alpha = max(alpha, best_value)

            # MIN already has a bound that makes
            # further exploration unnecessary.
            if alpha >= beta:
                break

        return best_value

    else:
        best_value = float("inf")

        for child in tree:
            value = alpha_beta(
                child, True, alpha, beta, stats
            )

            best_value = min(best_value, value)
            beta = min(beta, best_value)

            # MAX already has a better alternative.
            if alpha >= beta:
                break

        return best_value


game_tree = [
    [3, 5],
    [2, 9]
]

stats = {"leaves": 0}

best_value = alpha_beta(
    game_tree,
    True,
    float("-inf"),
    float("inf"),
    stats
)

print("Best Alpha-Beta value:", best_value)
print("Leaf nodes evaluated:", stats["leaves"])
```

Expected output:

``` text
Best Alpha-Beta value: 3
Leaf nodes evaluated: 3
```

Ordinary Minimax evaluates all four leaves in this example. Alpha-Beta
Pruning evaluates only three, skipping the leaf with value 9.

The `stats` dictionary counts the leaf nodes actually evaluated. It is
used to demonstrate the effect of pruning, not to calculate the decision
itself.

### 5.7 Understanding the Implementation

1.  The function receives the current subtree, the player whose turn it
    is, and the alpha and beta bounds.
2.  If the current node is a numerical leaf, it returns the utility and
    increments the leaf counter.
3.  At a MAX node, the function updates `best_value` with the maximum
    child value and raises alpha if a better value is found.
4.  At a MIN node, the function updates `best_value` with the minimum
    child value and lowers beta if a better value for MIN is found.
5.  After each child, the function checks whether `alpha >= beta`.
6.  If the condition holds, `break` stops the loop and skips the
    remaining children of that node.
7.  The function returns the best value found within the bounds, which
    is sufficient for the parent to make its decision.

Alpha and beta are passed down the recursive calls. Each node uses the
information already obtained from its ancestors and previously explored
siblings to determine whether additional work is necessary.

## 6. Comparing Minimax and Alpha-Beta Pruning

Both algorithms use the same decision-making principle. Their main
difference is how much of the game tree they need to examine.

  ---------------------------------------------------------------------------------------------
  Feature                 Minimax                 Alpha-Beta Pruning
  ----------------------- ----------------------- ---------------------------------------------
  Main purpose            Find the optimal move   Find the same optimal move more efficiently
                          under the game          
                          assumptions             

  Explores branches       All branches within the Skips branches that cannot affect the
                          search limit            decision

  Maintains alpha and     No                      Yes
  beta                                            

  Pruning condition       Not applicable          (`\alpha `{=tex}`\geq `{=tex}`\beta`{=tex})

  Worst-case time         (O(b\^d))               (O(b\^d))

  Best-case time with     (O(b\^d))               Approximately (O(b\^{d/2}))
  good move ordering                              

  Decision quality        Optimal for the         Same as Minimax for the searched tree
                          searched tree           
  ---------------------------------------------------------------------------------------------

Here, (b) is the branching factor and (d) is the search depth.

### 6.1 Why Does Move Ordering Matter?

Alpha-Beta Pruning becomes more effective when promising moves are
examined early.

Suppose the AI can examine five possible moves. If the first move
reveals a very strong result for MAX, alpha increases. This may allow
the algorithm to prune many branches of later MIN nodes.

If poor moves are examined first, alpha may remain low for longer, and
fewer branches may be pruned.

For a balanced tree with good move ordering, Alpha-Beta Pruning can
sometimes search approximately twice as deeply as Minimax with a similar
number of node evaluations. This is an illustrative rule of thumb, not a
guarantee.

**Important:** Alpha-Beta Pruning does not make a bad move good, nor
does it improve the utility function. It reduces unnecessary search
while preserving the result of Minimax.

## 7. From Small Game Trees to Real Game Engines

### 7.1 Why Is Chess Difficult for Exhaustive Search?

Chess has a large number of legal positions and possible move sequences.
Even though the rules are deterministic and the board is visible to both
players, exploring every possible game to its conclusion is impractical.

Consider a simplified example in which each position has an average of
30 legal moves.

    Search depth   Approximate number of positions
  -------------- ---------------------------------
               1                                30
               2                               900
               3                            27,000
               4                           810,000
               5                        24,300,000

These figures use the simplified assumption of a constant branching
factor of 30. Actual game trees vary by position, and these figures do
not account for transpositions, where different move sequences reach the
same position.

The important observation is that the search tree grows exponentially
with depth. Even a modest increase in search depth can dramatically
increase the computational cost.

### 7.2 Depth-Limited Search

Instead of exploring the entire game tree, a practical game engine often
searches only to a fixed depth.

For example, a depth-limited search may explore four plies, where a
*ply* means one player's move. Four plies represent two moves by each
player when both alternate normally.

But what happens when the search reaches its depth limit and the game
has not ended?

The algorithm needs an evaluation function.

### 7.3 Heuristic Evaluation Functions

A heuristic evaluation function estimates how favorable a non-terminal
game position is.

For a Chess engine, a simplified evaluation function might consider:

-   Material advantage, such as having more valuable pieces.
-   King safety.
-   Control of the center.
-   Mobility, meaning the number and quality of available moves.
-   Pawn structure and other positional factors.

Consider a hypothetical position:

-   Position A has an estimated value of +4.
-   Position B has an estimated value of -2.

If positive values favor MAX, position A is estimated to be better for
MAX than position B.

These are illustrative evaluation scores, not guaranteed game outcomes.
A heuristic is an estimate, so it may be inaccurate. Minimax can choose
the best move according to the evaluation function while still making a
poor real-world decision if that function misjudges a position.

### 7.4 How Does a Game Engine Use These Components?

A simplified game-playing system follows this process:

``` text
Current game state
        |
        v
Generate possible legal moves
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

This is a conceptual workflow. In an actual engine, evaluation is
integrated into the search, and legal-move generation, pruning, and move
selection may interact at every level.

A game engine is more than a search algorithm. It also needs to
represent the game state, generate legal moves, enforce the rules,
evaluate positions, and manage the overall process of playing a game.

### 7.5 Other Practical Techniques

Three techniques are particularly useful for understanding practical
game engines.

**Iterative deepening**

The engine searches to depth 1, then depth 2, then depth 3, and
continues until it reaches its time or resource limit. This allows it to
maintain a usable result if the search must stop.

**Move ordering**

The engine tries promising moves first to increase the effectiveness of
Alpha-Beta Pruning. Previous search results, captures, and other
heuristics can help determine the order.

**Transposition tables**

Different sequences of moves can sometimes lead to the same position. A
transposition table stores previously calculated results so that the
engine can reuse them instead of repeating the same work.

Modern game-playing systems may combine these techniques with opening
knowledge, endgame databases, advanced evaluation functions, and machine
learning. The precise combination depends on the game and the engine's
design.

## 8. Worked Application: Tic-Tac-Toe

Let us connect the numerical game tree to a real game.

Assume the AI plays O, and the human plays X. O must select a legal
empty cell. Its objective is to win if possible, prevent X from winning,
or draw if a win cannot be guaranteed.

For Tic-Tac-Toe, we can define terminal utilities from O's perspective:

-   O wins: +1
-   Draw: 0
-   X wins: -1

O is MAX, and X is MIN.

Consider this valid position, with O to move:

``` text
X | X | .
---------
O | O | .
---------
. | . | .
```

X has made two moves and O has made two moves, so it is O's turn.

O has several legal moves. Consider the empty cell in the third column
of the second row. If O places its mark there, the board becomes:

``` text
X | X | .
---------
O | O | O
---------
. | . | .
```

O wins immediately, so the utility is +1.

Minimax examines the possible moves and their consequences. Because O
can win immediately, the move completing the row is optimal. The search
does not need to assume that X will make a mistake; it considers the
available responses to each candidate move.

Alpha-Beta Pruning can help avoid unnecessary exploration when other
branches cannot improve this decision.

This example also shows why a game-playing program must check the actual
game rules, detect terminal states, and generate only legal moves. The
search algorithm alone cannot perform those tasks unless they are
provided by the surrounding program.

## 9. Common Misconceptions

**Misconception 1: Minimax always selects the highest leaf value.**

Not necessarily. It selects the best move after accounting for the
opponent's decisions. MIN may prevent MAX from reaching a high-valued
leaf.

**Misconception 2: Alpha-Beta Pruning changes the final decision.**

Correctly implemented Alpha-Beta Pruning preserves the Minimax value for
the same search tree and evaluation rules. It skips branches that cannot
change the result.

**Misconception 3: Alpha is the value of MAX's current node, and beta is
the value of MIN's current node.**

Alpha and beta are bounds carried through the search. They are updated
as the algorithm discovers better alternatives; they are not simply the
final values of the current nodes.

**Misconception 4: Every leaf node represents a completed game.**

A leaf may instead be a position where a depth limit has been reached.
Such a position needs a heuristic evaluation.

**Misconception 5: Alpha-Beta Pruning always reduces the search time by
the same amount.**

Its efficiency depends on the structure of the tree and the order in
which moves are explored. In the worst case, its time complexity remains
(O(b\^d)).

**Misconception 6: Minimax and Alpha-Beta Pruning are complete game
engines.**

They are search algorithms. A functioning game-playing program also
needs state representation, legal-move generation, terminal-state
detection, and an appropriate utility or evaluation function.

## 10. Essential Terminology

  -----------------------------------------------------------------------
  Term                                Meaning
  ----------------------------------- -----------------------------------
  Adversarial search                  Search in an environment where
                                      another agent works toward an
                                      opposing objective

  Game tree                           A tree of possible game states and
                                      moves

  MAX                                 The player seeking to maximize
                                      utility

  MIN                                 The player seeking to minimize
                                      MAX's utility

  Utility function                    A numerical representation of the
                                      desirability of a terminal outcome

  Minimax value                       The value calculated by assuming
                                      both players choose optimally

  Alpha                               The best lower bound on the value
                                      MAX can guarantee so far

  Beta                                The best upper bound on the value
                                      MIN can enforce so far

  Pruning                             Skipping exploration that cannot
                                      affect the final decision

  Branching factor                    The average number of available
                                      actions at a state

  Search depth                        The number of levels explored from
                                      the root

  Heuristic evaluation                An estimate of the value of a
                                      non-terminal state

  Ply                                 One player's move

  Move ordering                       Arranging candidate moves to
                                      improve search efficiency
  -----------------------------------------------------------------------

## 11. Review Questions and Answers

1.  **What is adversarial search?**\
    A search technique for decision-making when another agent actively
    works toward an opposing objective.

2.  **Why is Tic-Tac-Toe suitable for learning Minimax?**\
    It has simple rules, deterministic outcomes, perfect information,
    and a relatively small game tree.

3.  **What does MAX do at a node?**\
    It selects the maximum value among the child nodes.

4.  **What does MIN do at a node?**\
    It selects the minimum value from MAX's perspective.

5.  **What are the initial values of alpha and beta?**\
    Alpha starts at negative infinity and beta starts at positive
    infinity.

6.  **When can Alpha-Beta Pruning occur?**\
    When alpha is greater than or equal to beta.

7.  **Does pruning change the Minimax value?**\
    No. Correct pruning preserves the value and optimal decision for the
    same search tree.

8.  **Why do practical game engines use heuristic evaluation?**\
    To estimate unfinished positions when exploring the complete game
    tree is too expensive.

9.  **What is the worst-case time complexity of Minimax?**\
    (O(b\^d)), where (b) is the branching factor and (d) is the search
    depth.

10. **Why does move ordering matter?**\
    Examining promising moves first can allow Alpha-Beta Pruning to
    eliminate more branches.

## 12. Conclusion

Adversarial search enables an AI system to make decisions by considering
not only its own actions but also the possible responses of an opponent.

Minimax provides the fundamental decision-making strategy: MAX chooses
the highest value, while MIN chooses the lowest value from MAX's
perspective. The algorithm works backward through the game tree to
identify the best available move under the assumption that both players
act optimally.

Alpha-Beta Pruning improves the efficiency of Minimax by skipping
branches that cannot change the final decision. It uses alpha and beta
bounds to identify when additional exploration is unnecessary.

In practical game engines, these algorithms are combined with move
generation, terminal-state detection, depth limits, heuristic
evaluation, and other optimizations.

The central lesson is simple: **a good game-playing AI does not merely
ask, "What is my best move?" It asks, "What is my best move, assuming my
opponent will respond intelligently?"**
