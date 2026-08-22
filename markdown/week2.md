# Lecture 1 (Part 2): Knowledge-Based Systems & Modern AI Architectures

## Learning Objectives
By the end of this module, students will be able to:
* Define **Knowledge-Based Systems (KBS)** and explain their core architecture.
* Differentiate between **Declarative Knowledge** and **Procedural Knowledge**.
* Explain the historical transition from rule-based architectures to statistical and modern machine learning pipelines.
* Understand the core components of the **Python Data Science & AI Ecosystem** (NumPy, Pandas, Scikit-Learn).
* Prepare for **Lab 1**: Building a rule-based expert system using Python conditional logic (`if-elif-else`).

---

## 1. Introduction to Knowledge-Based Systems (KBS)

Early AI research recognized that general problem solvers were insufficient for complex, domain-specific tasks. This led to **Knowledge-Based Systems**—AI applications that store explicit domain expertise to simulate human decision-making.

* **Core Principle:** Decouple domain knowledge (what the system knows) from the reasoning mechanism (how the system thinks).
* **Key Advantage:** Expert knowledge can be inspected, updated, and extended without altering the core underlying algorithms.

---

## 2. Architecture of a Knowledge-Based System

A standard Knowledge-Based System consists of two primary operational components separated from the user interface:

```
+-------------------------------------------------------------+
|                      USER / ENVIRONMENT                     |
+-------------------------------------------------------------+
| (Input Data/Queries)   ^ (Diagnosis/Output)
v                        |
+-------------------------------------------------------------+
|                       INFERENCE ENGINE                      |
|       (Applies logical reasoning, deduction, rules)         |
+-------------------------------------------------------------+
^
| (Queries / Modifies)
v
+-------------------------------------------------------------+
|                        KNOWLEDGE BASE                       |
|       (Domain Facts, Axioms, Condition-Action Rules)        |
+-------------------------------------------------------------+
```

### Components Breakdown

* **Knowledge Base (KB):** The central repository containing domain-specific facts, assertions, production rules (`IF condition THEN action`), and relationships.
* **Inference Engine:** The domain-independent reasoning module. It processes user inputs, evaluates conditions against the Knowledge Base, and executes deduction to derive new information or reach decisions.
* **Declarative vs. Procedural Knowledge:**
  * **Declarative Knowledge:** Stating *what* is true (e.g., facts and rules explicitly stored inside the Knowledge Base).
  * **Procedural Knowledge:** Expressing *how* to accomplish tasks directly within executable code execution flows.

---

## 3. Historical Shift: Rule-Based Systems to Modern AI Pipelines

To succeed in the HEC Competency Test, students must understand how AI paradigms evolved across three major eras:

```
+---------------------+     +--------------------------+     +------------------------+
|   1. Rule-Based     |     |   2. Statistical & ML    |     |   3. Modern AI / MLOps |
|   (1970s - 1980s)   | --> |     (1990s - 2010s)      | --> |     (2020s - Present)  |
| Expert Systems / KB |     | Feature Extraction / ML  |     | Deep Learning / LLMs   |
+---------------------+     +--------------------------+     +------------------------+
```

1. Rule-Based Era (1970s–1980s):  
- Relied on human experts manually writing conditional rules (IF symptom THEN diagnosis).
- Limitation: Suffered from the Knowledge Acquisition Bottleneck—it was impossible to hand-craft rules for every edge case or handle messy, noisy, unstructured real-world data.

2. Statistical & Machine Learning Era (1990s–2010s):  
- Shifted from hand-crafted rules to learning mathematical representations and patterns directly from structured data.
- Advantage: Systems adapt automatically to new data without manual code updates.

3. Modern AI & MLOps Pipelines (2020s+):
- Combines modern neural architectures, deep learning, automated data processing, and continuous deployment environments into unified pipelines.


## 4. Python Ecosystem for AI & Data Analytics

Modern AI pipelines rely heavily on open-source Python libraries. A fundamental awareness of these stack tiers is essential:

- Core Math & Data Handling:  
  - NumPy: Multi-dimensional array processing and high-performance linear algebra operations.
  - Pandas: Data structures (DataFrames) for tabular data manipulation, cleaning, and exploratory data analysis (EDA).
- Classical Machine Learning:
  - Scikit-Learn: Standard library for pre-processing, classification, regression, clustering, and model validation metrics.
- Natural Language Processing & Vision:
  - spaCy / NLTK: Text processing, tokenization, lemmatization, and vectorization.
  - OpenCV: Basic image processing, matrix manipulation, and computer vision utilities.

5. Lab 1 Readiness: Rule-Based Expert System
This theoretical section directly connects to [Practical Lab 1](Lab1.md).
