## BSCS 4th Semester: 10-Week Artificial Intelligence Course Breakup

### Week 1: Introduction to AI & Knowledge-Based Systems
*   **Content:** An Introduction to Artificial Intelligence and its applications towards Knowledge Based Systems.
*   **Core Concepts:** Definition of AI, the Turing Test, and rational agents. Overview of Knowledge-Based Systems and the transition from rule-based architectures to modern AI pipelines.
*   **Practical Lab:** Setting up the Python environment (Google Colab/VS Code). Build a rule-based expert system (e.g., an automated medical symptom classifier or a tech-support diagnostic tree) using conditional logic structures.

### Week 2: Uninformed Search Strategies
*   **Content:** Problem Solving by Searching (Uninformed searching).
*   **Core Concepts:** Translating real-world problems into formal state-space graphs. Mechanism, frontier management, and complexities of Breadth-First Search (BFS) and Depth-First Search (DFS).
*   **Practical Lab:** Implement BFS and DFS from scratch in Python to navigate an agent through a 2D matrix maze. Print out and compare the size of the search frontier and the path length for both algorithms.

### Week 3: Informed Search & Heuristics
*   **Content:** Problem Solving by Searching (Informed searching, Heuristics).
*   **Core Concepts:** The role of domain knowledge in reducing search spaces. Greedy Best-First Search and the $A^*$ Search algorithm. Developing mathematically admissible and consistent heuristics.
*   **Practical Lab:** Write an $A^*$ solver in Python for the classic 8-Puzzle game. Test the algorithm using different heuristics (e.g., Manhattan distance vs. Misplaced tiles) to measure node exploration efficiency.

### Week 4: Local Search Optimization
*   **Content:** Problem Solving by Searching (Local searching).
*   **Core Concepts:** Optimization problems where the goal state matters but the path to it does not. Hill Climbing, the challenge of local maxima, plateaus, and random-restart variants.
*   **Practical Lab:** Implement a Hill Climbing algorithm in Python to solve the N-Queens problem or a 10-city Traveling Salesperson Problem (TSP). Plot the evaluation score over iterations to visualize the optimization process.

### Week 5: Adversarial Search & Game Engines
*   **Content:** Min-max algorithm, Alpha beta pruning, Game-playing.
*   **Core Concepts:** Game theory fundamentals in AI. Deterministic, zero-sum games of perfect information. Game tree construction with the Minimax algorithm and optimization using Alpha-Beta Pruning.
*   **Practical Lab:** Code a complete, turn-based Tic-Tac-Toe or Connect-Four engine in Python. Implement a Minimax agent with Alpha-Beta Pruning from scratch, making the bot completely unbeatable for a human player.

### Week 6: Landmark Case Studies in AI
*   **Content:** Case Studies: General Problem Solver, Eliza, Student, Macsyma.
*   **Core Concepts:** Historical milestones of symbolic AI. General problem-solving methodologies, early natural language pattern matching, algebra problem solving, and symbolic mathematics manipulation.
*   **Practical Lab:** Recreate a modern Python adaptation of the ELIZA chatbot. Use regular expressions (`re` library) and string parsing rules to map user statements to simulated psychotherapist responses.

### Week 7: Knowledge Representation & Reasoning
*   **Content:** Introduction to Reasoning and Knowledge Representation.
*   **Core Concepts:** How AI software structures world knowledge. Semantic networks, frames, propositional logic syntax, validity, satisfiability, and inference modeling.
*   **Practical Lab:** Build a structural knowledge graph or family-tree network using Python dictionaries and object-oriented properties. Write inference functions to deduce implicit, unstated relationships from the base facts.

### Week 8: Foundational Machine Learning (Learning from Examples)
*   **Content:** Learning from examples.
*   **Core Concepts:** Shifting from explicit logic programming to data-driven induction. Key components of machine learning: features, labels, and training vs. testing pipelines. High-level intuition of instance-based learning ($k$-NN) or simple Decision Trees.
*   **Practical Lab:** Introduce `Scikit-Learn` in Python. Load a clean, standard classification dataset (like the Iris dataset), split it into training/testing sets, train a basic classifier, and calculate its accuracy.

### Week 9: Applications of Neural Networks & NLP
*   **Content:** ANN and Natural Language Processing.
*   **Core Concepts:** High-level intuition of an Artificial Neural Network (neurons, weights, biases, activations) and text processing concepts (tokenization, lemmatization, stop-word removal). *Note: Kept focused on software application pipelines to avoid overlap with future dedicated ML/ANN electives.*
*   **Practical Lab:** Use `spaCy` or `NLTK` to build a text preprocessing pipeline that cleans a collection of sentences. Pass the processed tokens into an out-of-the-box `MLPClassifier` in `Scikit-Learn` to perform basic text categorization.

### Week 10: Recent Trends in AI & Capstone Project Showcase
*   **Content:** Recent trends in AI and applications of AI algorithms.
*   **Core Concepts:** Modern horizons in artificial intelligence (Generative AI, Large Language Models, and ethical considerations).
*   **Practical Lab:** Final Project Evaluations. Students demonstrate a practical AI application built over the semester (e.g., an automated pathfinder dashboard, a multi-heuristic puzzle solver, or an advanced game bot).