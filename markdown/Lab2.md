# Lab: Uninformed Search — BFS and DFS on a 2D Maze

**Goal of this lab:** implement BFS and DFS, run them on the same maze, and compare the paths and frontier sizes they produce.

Run each code cell in order — later cells depend on earlier ones.

---

### 📝 Markdown Cell

## 1. The Maze

We represent the maze as a grid of `0`s and `1`s:

```text
0 = Open cell
1 = Wall
```

The agent starts at `start` and must reach `goal`.

### 💻 Code Cell

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

for row in maze:
    print(row)
```

---

### 📝 Markdown Cell

## 2. Movements

The agent can move `UP`, `DOWN`, `LEFT`, `RIGHT`. We represent each as a `(row_change, col_change)` pair:

```text
(-1, 0) → up
( 1, 0) → down
( 0,-1) → left
( 0, 1) → right
```

### 💻 Code Cell

```python
directions = [
    (-1, 0),   # up
    (1, 0),    # down
    (0, -1),   # left
    (0, 1)     # right
]
```

---

### 📝 Markdown Cell

## 3. Checking a Valid Move

A move is valid only if the new cell is **inside the maze** and **not a wall**.

### 💻 Code Cell

```python
def valid_move(maze, row, col):
    rows = len(maze)
    cols = len(maze[0])
    return (
        0 <= row < rows
        and 0 <= col < cols
        and maze[row][col] == 0
    )

# Quick check
print(valid_move(maze, 0, 0))   # True — open cell
print(valid_move(maze, 1, 1))   # False — wall
print(valid_move(maze, -1, 0))  # False — outside the maze
```

---

### 📝 Markdown Cell

## 4. Breadth-First Search (BFS)

BFS uses a **Queue** (FIFO) — the oldest discovered state is expanded first. This is what makes BFS explore level by level and guarantees a shortest path when every move costs 1.

The key line to notice is `frontier.popleft()`.

### 💻 Code Cell

```python
from collections import deque

def bfs(maze, start, goal):
    frontier = deque([(start, [start])])
    visited = {start}
    max_frontier = 1

    while frontier:
        max_frontier = max(max_frontier, len(frontier))

        current, path = frontier.popleft()   # FIFO: oldest first

        if current == goal:
            return path, max_frontier

        row, col = current
        for dr, dc in directions:
            nr, nc = row + dr, col + dc
            neighbor = (nr, nc)

            if valid_move(maze, nr, nc) and neighbor not in visited:
                visited.add(neighbor)
                frontier.append((neighbor, path + [neighbor]))

    return None, max_frontier
```

### 💻 Code Cell

```python
bfs_path, bfs_frontier = bfs(maze, start, goal)

print("BFS path:", bfs_path)
print("BFS path length:", len(bfs_path) - 1)
print("BFS maximum frontier:", bfs_frontier)
```

**Why `len(path) - 1`?** A path of 4 states (`Start → A → B → Goal`) represents only 3 movements. Since every movement costs 1, `len(path) - 1` gives both the path length and the path cost.

---

### 📝 Markdown Cell

## 5. Depth-First Search (DFS)

DFS uses a **Stack** (LIFO) — the most recently discovered state is expanded first. This makes DFS commit to one branch and follow it as deep as possible before backtracking.

The only real change from BFS is `frontier.pop()` instead of `frontier.popleft()`.

### 💻 Code Cell

```python
def dfs(maze, start, goal):
    frontier = [(start, [start])]   # plain list used as a stack
    visited = {start}
    max_frontier = 1

    while frontier:
        max_frontier = max(max_frontier, len(frontier))

        current, path = frontier.pop()   # LIFO: most recent first

        if current == goal:
            return path, max_frontier

        row, col = current
        for dr, dc in directions:
            nr, nc = row + dr, col + dc
            neighbor = (nr, nc)

            if valid_move(maze, nr, nc) and neighbor not in visited:
                visited.add(neighbor)
                frontier.append((neighbor, path + [neighbor]))

    return None, max_frontier
```

### 💻 Code Cell

```python
dfs_path, dfs_frontier = dfs(maze, start, goal)

print("DFS path:", dfs_path)
print("DFS path length:", len(dfs_path) - 1)
print("DFS maximum frontier:", dfs_frontier)
```

---

### 📝 Markdown Cell

## 6. Visualizing the Paths

`*` marks the solution path, `#` marks walls, `.` marks open cells.

### 💻 Code Cell

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

### 💻 Code Cell

```python
print("BFS solution:")
print_maze(maze, bfs_path)

print()

print("DFS solution:")
print_maze(maze, dfs_path)
```

Notice whether the two paths are the same or different — that's the point of the next section.

---

### 📝 Markdown Cell

## 7. Compare BFS and DFS

Fill in this table from your output above:

| Algorithm | Path Length | Maximum Frontier |
|---|---:|---:|
| BFS | ___ | ___ |
| DFS | ___ | ___ |

**Answer these:**

1. Which algorithm found the shorter path?
2. Which algorithm had the larger maximum frontier?
3. Why did the two algorithms produce different paths on the same maze?
4. Does DFS always produce the shortest path? Why or why not?
5. Does BFS always produce the shortest path when every movement costs 1? Why?

---

### 📝 Markdown Cell

## 8. Experiment 1 — Change the Neighbor Order

DFS's exact path depends on the order in which neighbors are tried. Change `directions` and re-run DFS:

### 💻 Code Cell

```python
directions = [
    (0, 1),    # right
    (1, 0),    # down
    (0, -1),   # left
    (-1, 0)    # up
]

dfs_path2, dfs_frontier2 = dfs(maze, start, goal)

print("DFS path (new order):", dfs_path2)
print("DFS path length:", len(dfs_path2) - 1)
print("DFS maximum frontier:", dfs_frontier2)

print()
print_maze(maze, dfs_path2)
```

**Question:** Did the DFS path change? Did BFS's path (Section 4) depend on this ordering the same way? Why or why not?

*(Reset `directions` back to the original `up, down, left, right` order before continuing, so Experiment 2 starts from the same baseline.)*

---

### 📝 Markdown Cell

## 9. Experiment 2 — Change `start` and `goal`

Now try different start and goal cells in the **same maze**, and re-run BFS and DFS. Pick cells that are open (`0`) in the maze grid from Section 1.

### 💻 Code Cell

```python
directions = [
    (-1, 0),   # up
    (1, 0),    # down
    (0, -1),   # left
    (0, 1)     # right
]

# Try changing these to any open (0) cells in the maze
start = (0, 0)
goal = (2, 2)

bfs_path, bfs_frontier = bfs(maze, start, goal)
dfs_path, dfs_frontier = dfs(maze, start, goal)

print("BFS path:", bfs_path, "| length:", len(bfs_path) - 1, "| max frontier:", bfs_frontier)
print("DFS path:", dfs_path, "| length:", len(dfs_path) - 1, "| max frontier:", dfs_frontier)

print()
print("BFS solution:")
print_maze(maze, bfs_path)
print()
print("DFS solution:")
print_maze(maze, dfs_path)
```

**Try at least 3 different `(start, goal)` pairs** and record your results:

| Start | Goal | BFS Length | BFS Max Frontier | DFS Length | DFS Max Frontier |
|---|---|---:|---:|---:|---:|
| | | | | | |
| | | | | | |
| | | | | | |

**Answer these:**

6. Does BFS's path length ever change if you re-run it with the same `start`/`goal`? Does DFS's?
7. As the distance between `start` and `goal` grows, what happens to the maximum frontier size for each algorithm?
8. Can you find a `(start, goal)` pair where BFS and DFS return the **same** path? What does that tell you about the maze structure between those two points?
9. What happens if `goal` is unreachable from `start` (e.g. sealed off by walls)? Try it — what do `bfs()` and `dfs()` return?

---

### 📝 Markdown Cell

## 10. Where This Is Used

**BFS** — shortest paths in unweighted graphs, network exploration, social-network "degrees of separation," web crawling.

**DFS** — maze/graph traversal, cycle detection, topological sorting, backtracking search, file-system traversal.

Both are **uninformed** — they don't know which direction is "closer" to the goal. The next step beyond this lab is **informed search** (e.g. A\*), which uses a **heuristic** — an estimate of distance to the goal — to search more efficiently.

---

### 📝 Markdown Cell

## 11. Key Takeaway

The entire behavioral difference between BFS and DFS comes down to one line:

```python
# BFS
frontier.popleft()

# DFS
frontier.pop()
```

FIFO vs. LIFO frontier management is what turns the same generic search algorithm into two strategies with different guarantees:

| | BFS | DFS |
|---|---|---|
| Guaranteed shortest path (equal costs)? | Yes | No |
| Typically uses less memory? | No | Yes |