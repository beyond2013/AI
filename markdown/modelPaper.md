# Artificial Intelligence
## Model Paper for Midterm and Terminal Examination Preparation

**Syllabus Coverage:** Weeks 1–6  
**Total Questions:** 50 MCQs and 7 Subjective Questions  
**Subjective Marks:** 10 marks per question

### Instructions

1. This paper covers the theoretical and conceptual content taught during Weeks 1–6.
2. All 50 MCQs are provided for practice.
3. Each subjective question carries 10 marks.
4. Questions related to Python programming, coding, and practical implementation are excluded because programming will be evaluated separately.
5. Students should focus on understanding concepts, explaining algorithms, comparing approaches, and solving conceptual problems.

---

# Section A: Multiple Choice Questions (MCQs)

Choose the most appropriate answer.

## Week 1: Introduction to AI and Knowledge-Based Systems

**Q1.** Which of the following best describes Artificial Intelligence?

A. A technology used only for mathematical calculations  
B. The ability of machines to perform tasks that normally require human intelligence  
C. A method of storing large amounts of data  
D. A technique used exclusively for computer networking  

**Q2.** The Turing Test was proposed by:

A. John McCarthy  
B. Alan Turing  
C. Marvin Minsky  
D. Herbert Simon  

**Q3.** The primary purpose of the Turing Test is to evaluate whether:

A. A computer can perform complex calculations  
B. A machine can demonstrate human-like conversational behaviour  
C. A computer can store human knowledge  
D. A machine can solve every mathematical problem  

**Q4.** A rational agent selects an action based primarily on:

A. Random selection  
B. The agent's physical size  
C. The available information and expected performance  
D. The number of instructions stored in memory  

**Q5.** In Artificial Intelligence, an agent perceives its environment through:

A. Actuators  
B. Sensors  
C. Compilers  
D. Databases  

**Q6.** Which of the following is an example of a Knowledge-Based System?

A. A simple text editor  
B. A rule-based medical diagnostic system  
C. A file compression utility  
D. A calculator performing addition  

**Q7.** In a traditional rule-based system, knowledge is commonly represented using:

A. IF–THEN rules  
B. Random numbers  
C. Image pixels only  
D. Hardware instructions  

**Q8.** What is the primary role of an inference engine in a Knowledge-Based System?

A. To display graphical information  
B. To apply rules to available facts and derive conclusions  
C. To store computer hardware specifications  
D. To manage network connections  

**Q9.** Which statement best describes the transition from traditional rule-based AI to modern AI systems?

A. Modern AI completely eliminates the need for data  
B. Modern AI increasingly uses data-driven learning alongside other AI techniques  
C. Modern AI relies exclusively on manually written rules  
D. Modern AI is limited to mathematical calculations  

## Week 2: Uninformed Search Strategies

**Q10.** In Artificial Intelligence, a search problem generally involves:

A. Finding a solution by exploring possible states  
B. Increasing the computer's processing speed  
C. Compressing a large dataset  
D. Converting one programming language into another  

**Q11.** A state-space graph represents:

A. The physical components of a computer  
B. Possible states and transitions between those states  
C. The structure of a database  
D. The arrangement of files on a computer  

**Q12.** Which of the following is an example of a search problem?

A. Finding a route between two cities  
B. Changing the screen resolution  
C. Installing an operating system  
D. Formatting a document  

**Q13.** Breadth-First Search (BFS) explores nodes:

A. From deepest to shallowest  
B. Level by level  
C. In completely random order  
D. According to their estimated distance from the goal  

**Q14.** Which data structure is commonly associated with Breadth-First Search?

A. Stack  
B. Queue  
C. Tree  
D. Hash table  

**Q15.** Depth-First Search (DFS) explores:

A. All nodes at the same level before moving deeper  
B. The deepest available path before backtracking  
C. Only the goal node  
D. Nodes according to their path costs  

**Q16.** Which data structure is commonly associated with Depth-First Search?

A. Queue  
B. Stack  
C. Priority queue  
D. Circular buffer  

**Q17.** If all actions have equal costs, which search strategy is guaranteed to find a solution with the fewest number of edges, provided a solution exists at a finite depth?

A. Depth-First Search  
B. Breadth-First Search  
C. Random Search  
D. Hill Climbing  

**Q18.** Which of the following is generally a disadvantage of Breadth-First Search?

A. It cannot explore neighbouring states  
B. It may require a large amount of memory  
C. It always produces an incorrect solution  
D. It cannot find a goal at a shallow depth  

## Week 3: Informed Search and Heuristics

**Q19.** Informed search differs from uninformed search because it:

A. Uses additional knowledge to guide the search  
B. Does not explore any states  
C. Always selects a random state  
D. Requires no goal test  

**Q20.** A heuristic function estimates:

A. The total number of states in a problem  
B. The remaining cost or distance from a state to the goal  
C. The computer's processing speed  
D. The amount of memory available  

**Q21.** Which of the following is the evaluation function used by A* Search?

A. f(n) = h(n)  
B. f(n) = g(n)  
C. f(n) = g(n) + h(n)  
D. f(n) = g(n) - h(n)  

**Q22.** In A* Search, g(n) represents:

A. Estimated cost from the current state to the goal  
B. Actual cost from the initial state to the current state  
C. Total number of possible solutions  
D. Estimated number of remaining states  

**Q23.** In A* Search, h(n) represents:

A. The actual cost from the initial state  
B. The estimated cost from the current state to the goal  
C. The total number of explored nodes  
D. The depth of the search tree  

**Q24.** An admissible heuristic is one that:

A. Always overestimates the remaining cost  
B. Never overestimates the actual minimum remaining cost  
C. Always returns zero  
D. Estimates the total number of states  

**Q25.** Which of the following is a common heuristic for the 8-Puzzle problem?

A. Manhattan Distance  
B. Binary Search  
C. Depth-First Ordering  
D. Linear Regression  

**Q26.** Greedy Best-First Search selects the next node primarily based on:

A. The actual path cost g(n)  
B. The heuristic estimate h(n)  
C. The total number of explored nodes  
D. The depth of the initial state  

**Q27.** Which statement correctly distinguishes A* Search from Greedy Best-First Search?

A. A* considers both path cost and estimated remaining cost  
B. Greedy Best-First Search always considers actual path cost  
C. A* ignores heuristic information  
D. Both algorithms always explore nodes in exactly the same order  

## Week 4: Local Search Optimization

**Q28.** Local search algorithms are particularly useful when:

A. The path to the solution is more important than the final state  
B. The objective is to find a good final state or solution  
C. Every possible state must be stored in memory  
D. The problem contains no objective function  

**Q29.** Hill Climbing is an example of:

A. Uninformed search  
B. Local search  
C. Adversarial search  
D. Database searching  

**Q30.** In Hill Climbing, the algorithm generally moves towards:

A. A neighbouring state with a better evaluation value  
B. A randomly selected state regardless of quality  
C. The initial state in every iteration  
D. The deepest state in the search tree  

**Q31.** A local maximum occurs when:

A. The current state is better than its neighbours, but is not the global optimum  
B. Every possible state has the same value  
C. The algorithm has found the worst possible solution  
D. The search space contains no neighbouring states  

**Q32.** A plateau in Hill Climbing refers to:

A. A region where neighbouring states have equal or similar evaluation values  
B. A state that is always globally optimal  
C. A state with no possible solution  
D. A region where every move improves the solution  

**Q33.** What is the main purpose of Random-Restart Hill Climbing?

A. To eliminate the need for an objective function  
B. To improve the chances of finding a better solution by starting from different initial states  
C. To guarantee that every possible state is explored  
D. To convert local search into breadth-first search  

**Q34.** The N-Queens problem requires placing queens on a chessboard so that:

A. Every queen occupies a different row only  
B. No two queens attack each other  
C. All queens occupy the same diagonal  
D. Every queen occupies a corner square  

**Q35.** In the N-Queens problem, two queens placed in the same diagonal are considered:

A. Safe  
B. Attacking each other  
C. Unrelated  
D. Mutually exclusive solutions  

## Week 5: Adversarial Search and Game Engines

**Q36.** Adversarial search is commonly used in:

A. Two-player competitive games  
B. File management systems  
C. Image compression  
D. Database indexing  

**Q37.** In a two-player zero-sum game:

A. Both players always win  
B. One player's gain corresponds to the other player's loss  
C. Both players have identical objectives  
D. Neither player has a defined objective  

**Q38.** The Minimax algorithm is primarily used to:

A. Find the shortest route between cities  
B. Select the best move in competitive games  
C. Compress game files  
D. Estimate the size of a database  

**Q39.** In the Minimax algorithm, the MAX player attempts to:

A. Minimize the evaluation score  
B. Maximize the evaluation score  
C. Avoid evaluating any moves  
D. Select a random move  

**Q40.** In the Minimax algorithm, the MIN player attempts to:

A. Maximize the evaluation score  
B. Minimize the evaluation score  
C. Increase the branching factor  
D. Avoid the terminal states  

**Q41.** Alpha-Beta Pruning improves Minimax by:

A. Increasing the number of unnecessary nodes explored  
B. Eliminating branches that cannot affect the final decision  
C. Removing the evaluation function  
D. Changing a two-player game into a single-player game  

**Q42.** In Alpha-Beta Pruning, alpha represents:

A. The best value MAX can guarantee so far  
B. The best value MIN can guarantee so far  
C. The total number of game states  
D. The depth of the game tree  

**Q43.** Which of the following best describes a perfect-information game?

A. Players cannot observe the current game state  
B. All players have access to the complete current game state  
C. Players make decisions without knowing the rules  
D. The game is based entirely on random events  

## Week 6: Landmark Case Studies in AI

**Q44.** The General Problem Solver (GPS) was an early AI program associated with:

A. Herbert Simon and Allen Newell  
B. Alan Turing and John von Neumann  
C. Tim Berners-Lee and Vint Cerf  
D. Geoffrey Hinton and Yann LeCun  

**Q45.** The General Problem Solver was designed to:

A. Solve general problems using symbolic reasoning and problem-solving methods  
B. Perform only image recognition  
C. Manage computer networks  
D. Translate programming languages  

**Q46.** ELIZA was an early AI program that simulated:

A. A mathematics teacher  
B. A psychotherapist  
C. A chess player  
D. A database administrator  

**Q47.** ELIZA primarily relied on:

A. Pattern matching and predefined response rules  
B. Deep neural networks  
C. Reinforcement learning  
D. Computer vision  

**Q48.** The STUDENT program was developed to solve:

A. Algebra word problems  
B. Chess problems  
C. Image classification problems  
D. Network routing problems  

**Q49.** MACSYMA was an early AI-related system designed for:

A. Symbolic mathematical computation  
B. Speech recognition  
C. Medical image processing  
D. Autonomous driving  

**Q50.** What is a common characteristic of early symbolic AI systems?

A. They relied on explicit symbols, rules, and logical representations  
B. They depended exclusively on large-scale neural networks  
C. They learned everything from massive image datasets  
D. They required no knowledge representation  

---

# Section B: Subjective Questions

Each question carries **10 marks**.

**Q1. Introduction to AI and Knowledge-Based Systems (10 Marks)**

a. Define Artificial Intelligence and explain any four real-world applications. (4)

b. Explain the Turing Test and its purpose in evaluating machine intelligence. (3)

c. Describe the basic components of a Knowledge-Based System, including the knowledge base and inference engine. (3)

**Q2. Uninformed Search Strategies (10 Marks)**

a. Explain the concept of a state-space graph. Identify its major components using a route-finding problem as an example. (3)

b. Explain the working principles of Breadth-First Search (BFS) and Depth-First Search (DFS). (4)

c. Compare BFS and DFS in terms of completeness, optimality, and memory requirements. (3)

**Q3. Informed Search and Heuristics (10 Marks)**

a. What is a heuristic function? Explain its importance in informed search. (2)

b. Explain the working principles of Greedy Best-First Search and A* Search. (4)

c. Differentiate between admissible and consistent heuristics. (2)

d. Explain the roles of g(n), h(n), and f(n) in A* Search. (2)

**Q4. Local Search Optimization (10 Marks)**

a. Explain the concept of local search and identify situations where it is useful. (2)

b. Describe the Hill Climbing algorithm and explain how it improves a candidate solution. (3)

c. Explain local maxima and plateaus. Why can they prevent Hill Climbing from finding the global optimum? (3)

d. What is Random-Restart Hill Climbing, and how does it address some limitations of ordinary Hill Climbing? (2)

**Q5. Adversarial Search and Game Engines (10 Marks)**

a. Explain adversarial search and describe the characteristics of a deterministic, zero-sum, perfect-information game. (3)

b. Explain the Minimax algorithm and the roles of MAX and MIN players. (3)

c. What is Alpha-Beta Pruning? Explain how it improves the efficiency of Minimax without changing its final decision. (4)

**Q6. Landmark Case Studies in AI (10 Marks)**

a. Explain the purpose and significance of the General Problem Solver (GPS). (2)

b. Describe ELIZA and explain how it simulated a conversation with a psychotherapist. (2)

c. What type of problems was the STUDENT program designed to solve? (2)

d. Explain the purpose of MACSYMA and its contribution to symbolic mathematical computation. (2)

e. Identify two important characteristics of early symbolic AI systems. (2)

**Q7. Analytical and Conceptual Understanding of Search (10 Marks)**

Consider a route-finding problem in which an AI agent must find a path from City A to City G.

a. Explain how the problem can be represented as a state-space graph. Identify the initial state, goal state, possible actions, and path cost. (3)

b. If all roads have equal cost, which search algorithm would be more appropriate: BFS or DFS? Justify your answer. (2)

c. If the agent has additional information about the estimated distance from each city to City G, explain how a heuristic can help guide the search. (2)

d. Explain why A* Search may be more suitable than Greedy Best-First Search when finding a least-cost route. (3)

---


# Preparation Guidelines

Students should give particular attention to the following areas:

1. **AI Fundamentals:** Definitions, applications, rational agents, the Turing Test, and Knowledge-Based Systems.
2. **Uninformed Search:** State-space representation, BFS, DFS, their differences, and their advantages and limitations.
3. **Informed Search:** Heuristics, Greedy Best-First Search, A*, admissibility, consistency, and evaluation functions.
4. **Local Search:** Hill Climbing, objective functions, local maxima, plateaus, and Random-Restart Hill Climbing.
5. **Adversarial Search:** Game trees, Minimax, MAX and MIN players, and Alpha-Beta Pruning.
6. **Historical AI Systems:** GPS, ELIZA, STUDENT, and MACSYMA, including their purposes and contributions.

**Important:** Students should understand the working principles of the algorithms and be able to explain their behaviour using diagrams, examples, and comparisons. Python programming and practical implementation are not part of this model paper and will be evaluated separately.
