# ️ AI Content Credit & Caution for Students

### Course Reference Notice
This lecture framework and practical roadmap have been meticulously designed and structured utilizing generative AI tools (Gemini) to align perfectly with the Higher Education Commission (HEC) of Pakistan curriculum requirements. It has been customized to provide a highly practical, code-driven approach tailored specifically for BSCS 4th-semester students.

### Academic & Professional Caution
As aspiring computer science professionals, you must understand the following guidelines regarding AI-assisted learning:

1. **AI is a Copilot, Not the Pilot:** You are fully encouraged to use AI tools (like ChatGPT, Gemini, or GitHub Copilot) to debug syntax errors or understand algorithmic logic. However, relying on AI to write your entire lab assignments will severely stunt your problem-solving skills, which are critical for passing exams and technical interviews.
2. **Verify and Validate:** AI models can sometimes generate logically incorrect or inefficient code blocks (hallucinations). It is your responsibility as an engineer to test, benchmark, and mathematically verify your algorithm's behavior.
3. **The "Why" Matters Most:** Writing code that works is only 20% of the job. In this course, you will be graded heavily on your ability to explain *why* an algorithm was chosen, its time/space complexity ($O(n)$ metrics), and how it behaves when the environment scales. 

*“The goal of Artificial Intelligence is to build systems that think. The goal of this course is to teach YOU how to think algorithmically.”*

# Week 1: Introduction to AI & Knowledge-Based Systems

## 1. Lecture Content & Core Concepts

### A. Defining Artificial Intelligence
*   **What is AI?** The study of systems that receive percepts from the environment and perform actions. AI can be categorized along two dimensions:
    1.  **Thinking vs. Acting:** Focus on internal thought processes/reasoning vs. external observable behavior.
    2.  **Humanly vs. Rationally:** Measuring success against human performance vs. an ideal concept of correctness (rationality).
*   **The Turing Test:** Proposed by Alan Turing (1950), it defines operational intelligence as the ability to achieve human-level performance in all cognitive tasks sufficient to fool an interrogator.
*   **Rationality:** A system is rational if it does the "right thing" given what it knows. In AI, we lean heavily toward building **Rational Agents** because it is mathematically well-defined and more general than mimicking human behavior.

### B. Intelligent Agents and Environments
*   **Agent Architecture:** An agent is anything that can be viewed as perceiving its environment through **sensors** and acting upon that environment through **actuators** ($\text{Agent} = \text{Architecture} + \text{Program}$).
*   **PEAS Framework:** To design an intelligent agent, we must fully specify its task environment using PEAS:
    *   **P**erformance Measure: The criteria that determine how successful an agent is.
    *   **E**nvironment: The external setting or context in which the agent operates.
    *   **A**ctuators: The tools or mechanisms the agent uses to assert actions.
    *   **S**ensors: The devices the agent uses to receive input or percepts.
*   **Environment Properties:** Environments dictate the complexity of the AI algorithm. They can be:
    *   *Fully Observable vs. Partially Observable*
    *   *Deterministic vs. Stochastic*
    *   *Episodic vs. Sequential*
    *   *Static vs. Dynamic*
    *   *Discrete vs. Continuous*

### C. Knowledge-Based Systems (KBS)
*   **The Paradigm Shift:** Traditional procedural code relies strictly on hardcoded `if-else` execution paths. Knowledge-Based Systems separate the software execution into two distinct layers:
    1.  **Knowledge Base (KB):** A centralized repository of domain-specific facts, rules, and relationships.
    2.  **Inference Engine:** The generic, domain-independent control mechanism that applies logical rules to the KB to deduce new information or make decisions.
*   **Simple Reflex Agents:** The simplest agent type. It maps current percepts directly to actions using hardcoded condition-action rules (e.g., *if car-in-front-is-braking then initiate-braking*).

---

## 2. Classroom Discussion / Concept Check
1.  **The Self-Driving Car PEAS:** Ask students to identify the PEAS profile for a self-driving car. 
    *   *Expected Answers:* **P:** Safety, time, comfort, legality; **E:** Roads, pedestrians, weather; **A:** Steering, accelerator, brakes; **S:** Cameras, LiDAR, speedometer.
2.  **Reflex vs. Intelligence:** Is a home thermostat truly "intelligent"? It uses a simple condition-action rule (*if temp < baseline, turn on heater*). Introduce the idea that while it fits the definition of a simple reflex agent, AI scales this up to handle complex, partially observable state spaces.

---

## 3. Practical Lab Manual: Building a Knowledge-Based Expert System

### Lab Objective
Students will set up their Python environment (Google Colab or local VS Code) and implement a simple, rule-based Expert System using an object-oriented approach. This system will simulate a technical support or medical diagnostic agent, demonstrating how a separate "Knowledge Base" can drive decisions.

### Prerequisites
*   Basic understanding of Python classes, dictionaries, and loops.
*   No external libraries are required for this lab (pure Python).

### Lab Tasks

#### Task 1: Environment Verification
Open a new Google Colab notebook or a local Python file and run the following script to verify your environment setup:
```python
import sys
print(f"Python Version: {sys.version}")
print("Environment successfully configured for BSCS AI Lab!")