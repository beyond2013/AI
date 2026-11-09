# Artificial Intelligence
## Practical Model Paper

**Total Marks:** 25  
**Time Allowed:** 2 Hours  
**Syllabus:** AI Practical Labs — Weeks 1–6

### General Instructions

1. Attempt **any FIVE questions**. Each question carries 5 marks.
2. Use Python 3 to complete the tasks.
3. You may use VS Code, IDLE, Jupyter Notebook, or Google Colab.
4. Write and execute your programs on a computer.
5. Save your programs with appropriate filenames.
6. You may use the basic Python constructs covered during laboratory sessions.
7. Focus on obtaining the correct output rather than writing complicated or lengthy programs.
8. Submit your source files and show the output to the instructor.

---

# Practical Questions

## Q1. Rule-Based Expert System (5 Marks)

A simple expert system uses predefined rules to identify a possible computer problem.

Complete the following program using conditional statements.

```python
temperature = input("Is the computer overheating? (yes/no): ")
slow = input("Is the computer running slowly? (yes/no): ")

if temperature == "yes":
    print("Possible Problem: Cooling system issue")

elif slow == "yes":
    print("Possible Problem: Insufficient system resources")

else:
    print("No common problem identified")
```

Tasks:

a. Execute the program. (1)

b. Test the program using at least two different input combinations. (2)

c. Add one more condition to identify a computer that does not start. (2)

---

## Q2. Breadth-First Search (BFS) (5 Marks)

Consider the following graph representing connections between different locations.

```python
graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['F'],
    'F': []
}
```

Complete the following BFS program.

```python
def bfs(graph, start):

    visited = []
    queue = [start]

    while queue:

        node = queue.pop(0)

        if node not in visited:

            visited.append(node)

            for neighbour in graph[node]:
                if neighbour not in visited:
                    queue.append(neighbour)

    return visited


result = bfs(graph, 'A')
print("BFS Traversal:", result)
```

Tasks:

a. Execute the program. (1)

b. Identify the first node visited. (1)

c. Change the starting node to 'B' and execute the program again. (1)

d. Explain why BFS uses a queue. (2)

---

## Q3. Heuristic Function and A* Search (5 Marks)

A heuristic function estimates the distance between the current state and the goal state.

For the 8-Puzzle problem, Manhattan Distance is calculated by adding the horizontal and vertical distances of each numbered tile from its goal position.

Consider the following two lists:

```python
current = [1, 2, 3,
           4, 0, 6,
           7, 5, 8]

goal = [1, 2, 3,
        4, 5, 6,
        7, 8, 0]
```

Here, 0 represents the empty space.

Tasks:

a. Identify the positions of tiles 5 and 8 in the current state. (1)

b. Calculate the Manhattan Distance of tile 5 from its goal position. (1)

c. Calculate the Manhattan Distance of tile 8 from its goal position. (1)

d. Write the total Manhattan Distance of the given state. (1)

e. State one reason why a heuristic is useful in A* Search. (1)

---

## Q4. Hill Climbing (5 Marks)

Hill Climbing attempts to find a better solution by moving towards a neighbouring state with a higher evaluation value.

Consider the following function:

```python
def objective(x):
    return -(x - 5) ** 2 + 25


for x in range(1, 10):
    print(x, objective(x))
```

Tasks:

a. Execute the program. (1)

b. Identify the value of x that produces the highest result. (1)

c. What is the maximum value of the objective function? (1)

d. Modify the range so that the program checks values from 1 to 15. (1)

e. Explain in one or two sentences how Hill Climbing searches for a better solution. (1)

---

## Q5. ELIZA: A Simple Conversational Program (5 Marks)

ELIZA was an early AI program that simulated conversation using predefined patterns and responses.

Complete and execute the following simple conversational program.

```python
print("ELIZA: Hello! How can I help you?")

while True:

    user = input("You: ")

    if user.lower() == "hello":
        print("ELIZA: Hello! How are you?")

    elif user.lower() == "sad":
        print("ELIZA: Why do you feel sad?")

    elif user.lower() == "happy":
        print("ELIZA: What makes you happy?")

    elif user.lower() == "bye":
        print("ELIZA: Goodbye!")
        break

    else:
        print("ELIZA: Please tell me more.")
```

Tasks:

a. Execute the program. (1)

b. Test it using the inputs `hello`, `sad`, and `bye`. (2)

c. Add a new condition for the input `angry` with an appropriate response. (1)

d. Explain how ELIZA generates responses. (1)

---

## Q6. Minimax Algorithm: Basic Game Tree (5 Marks)

The following game tree represents a simple two-player game.

MAX is the first player and MIN is the opponent. The terminal values represent the final evaluation scores.

```text
              MAX
             /   \
           MIN   MIN
          / \    / \
         3   5  2   9
```

Tasks:

a. Identify the two MIN nodes and their children. (1)

b. Determine the minimum value selected by the left MIN node. (1)

c. Determine the minimum value selected by the right MIN node. (1)

d. Determine the final value selected by the MAX node. (1)

e. Explain the purpose of the Minimax algorithm in two-player games. (1)

---

# End of Practical Model Paper

## Preparation Guidelines

Students should practise the following before appearing in the practical examination:

| Week | Practical Topic | What to Practise |
|---|---|---|
| 1 | Rule-Based Expert System | Variables, input, print, if-elif-else |
| 2 | BFS and DFS | Lists, dictionaries, loops, queues and stacks |
| 3 | A* Search and Heuristics | Understanding heuristic values and simple distance calculations |
| 4 | Hill Climbing | Functions, loops, objective values and identifying maximum values |
| 5 | Minimax | Understanding game trees and selecting minimum and maximum values |
| 6 | ELIZA | String comparison, conditional statements and conversational responses |

### Important Advice

- Practise executing Python programs and correcting simple errors.
- Understand what each statement in a program does.
- Be comfortable with variables, lists, dictionaries, loops, functions, and conditional statements.
- Practise changing input values and observing how the output changes.
- Do not memorise programs without understanding their purpose.

**Remember:** The practical examination will assess your ability to understand, execute, modify, and interpret simple Python programs related to the AI topics covered in the laboratory sessions.
