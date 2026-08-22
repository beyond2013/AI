# Practical Lab 1: Google Colab Setup & Building a Knowledge-Based System (KBS)

**Course:** Artificial Intelligence (BSCS 4th Semester)  
**Duration:** 2 Hours  
**Tooling:** Python 3, Google Colab  
**Prerequisites:** Basic Python syntax (`if`, `elif`, `else`, functions, dictionaries)

---

## Lab Objectives
By the end of this lab session, you will be able to:
1. Navigate, configure, and execute Python code using **Google Colab**.
2. Understand the architecture of a **Knowledge-Based System (KBS)** by decoupling the Knowledge Base from the Inference Engine.
3. Write and execute a functional rule-based expert system in Python using production rules and conditional inference logic.

---

## Part 1: Setting Up Google Colab (15 Minutes)

Google Colaboratory (Colab) is a cloud-based Jupyter Notebook environment that allows you to write and execute Python code directly in your web browser with no local setup required.

### Step 1: Launch Colab
1. Open your web browser and navigate to [colab.research.google.com](https://colab.research.google.com).
2. Sign in using your Google account credentials.
3. In the pop-up modal, click **New Notebook** (bottom right).

### Step 2: Configure Your Notebook
1. Click on the title at the top left (e.g., `Untitled0.ipynb`) and rename it to:  
   `Lab1_KBS_ExpertSystem.ipynb`.
2. Note the two main types of cells:
   * **Text Cells (`+ Text`):** Write documentation using Markdown formatting.
   * **Code Cells (`+ Code`):** Write executable Python scripts.

### Step 3: Test Code Execution
1. Hover over the notebook interface and click **`+ Code`**.
2. Type the following test code into the cell:
   ```python
   print("Google Colab Environment Initialized Successfully!")


### Task 1: Building the Knowledge Base
Create a Code Cell in Colab and define the university grading and standing rules as structured Python dictionaries:

```python
# =====================================================================
# STEP 1: KNOWLEDGE BASE (KB)
# Declarative facts and decision rules representing university grading policy.
# =====================================================================

UNIVERSITY_KB = {
    "system_name": "BSCS Academic Performance & Grading Expert System",
    "passing_marks": 50,
    "rules": [
        {
            "id": "RULE_01",
            "conditions": {"attendance_percentage": 74},  # Below 75%
            "condition_type": "attendance_below",
            "grade": "F",
            "status": "Debarred",
            "action": "Ineligible to sit for final exam due to short attendance."
        },
        {
            "id": "RULE_02",
            "conditions": {"marks_min": 85, "marks_max": 100},
            "condition_type": "marks_range",
            "grade": "A",
            "status": "Passed with Distinction",
            "action": "Recommended for Merit Scholarship."
        },
        {
            "id": "RULE_03",
            "conditions": {"marks_min": 75, "marks_max": 84},
            "condition_type": "marks_range",
            "grade": "B",
            "status": "Passed",
            "action": "Good standing. Maintain momentum."
        },
        {
            "id": "RULE_04",
            "conditions": {"marks_min": 60, "marks_max": 74},
            "condition_type": "marks_range",
            "grade": "C",
            "status": "Passed",
            "action": "Satisfactory performance. Focus on weak subject areas."
        },
        {
            "id": "RULE_05",
            "conditions": {"marks_min": 50, "marks_max": 59},
            "condition_type": "marks_range",
            "grade": "D",
            "status": "Conditional Pass",
            "action": "Warning: Near failure threshold. Academic counseling advised."
        },
        {
            "id": "RULE_06",
            "conditions": {"marks_min": 0, "marks_max": 49},
            "condition_type": "marks_range",
            "grade": "F",
            "status": "Failed",
            "action": "Must repeat the course in the upcoming semester."
        }
    ]
}

print(f"Loaded: {UNIVERSITY_KB['system_name']}")
```

### Task 2: Building the Inference Engine
Create a second Code Cell to define the inference engine function that processes student data against the KB rules:

```python
# =====================================================================
# STEP 2: INFERENCE ENGINE
# Evaluates student records against rules stored in the Knowledge Base.
# =====================================================================

def evaluate_student(student_record, kb):
    """
    Evaluates student marks and attendance against university rules.
    Returns computed grade, academic status, and recommended action.
    """
    print(f"\n--- EVALUATING STUDENT: {student_record['student_name']} (ID: {student_record['student_id']}) ---")
    
    # Check rule 1: Attendance constraint first
    if student_record["attendance"] < 75:
        attendance_rule = next(r for r in kb["rules"] if r["condition_type"] == "attendance_below")
        return {
            "rule_id": attendance_rule["id"],
            "grade": attendance_rule["grade"],
            "status": attendance_rule["status"],
            "action": attendance_rule["action"]
        }
    
    # Check grade spectrum rules
    marks = student_record["total_marks"]
    for rule in kb["rules"]:
        if rule["condition_type"] == "marks_range":
            if rule["conditions"]["marks_min"] <= marks <= rule["conditions"]["marks_max"]:
                return {
                    "rule_id": rule["id"],
                    "grade": rule["grade"],
                    "status": rule["status"],
                    "action": rule["action"]
                }
                
    return {
        "rule_id": "UNKNOWN",
        "grade": "N/A",
        "status": "Invalid Score Entry",
        "action": "Verify submitted marks with the exam department."
    }
```

### Task 3: Simulating Student Records & Running Inference
Create a third Code Cell to execute test cases and observe the expert system outputs:

```python
# =====================================================================
# STEP 3: WORKING MEMORY & TEST EXECUTION
# =====================================================================

# Test Case 1: High scorer with full attendance
student_1 = {
    "student_id": "BSCS-2024-012",
    "student_name": "Ali Khan",
    "total_marks": 88,
    "attendance": 92
}

# Test Case 2: Good marks, but failed attendance threshold
student_2 = {
    "student_id": "BSCS-2024-045",
    "student_name": "Sara Ahmed",
    "total_marks": 81,
    "attendance": 68
}

# Run Inference Engine
result_1 = evaluate_student(student_1, UNIVERSITY_KB)
print(f"Grade: {result_1['grade']} | Status: {result_1['status']}")
print(f"Advisory Action: {result_1['action']}")

result_2 = evaluate_student(student_2, UNIVERSITY_KB)
print(f"Grade: {result_2['grade']} | Status: {result_2['status']}")
print(f"Advisory Action: {result_2['action']}")
```

### Part 2: Hands-On Student Exercises

Execute these exercises inside your Google Colab notebook:

- **Exercise 1:** Degree Honors RuleAdd a new rule to `UNIVERSITY_KB["rules"]` for students completing their degree program:
  - Condition: `cgpa >= 3.70` and `disciplinary_warnings == 0` $\rightarrow$ Status: "Graduated with Magna Cum Laude Honors".
- **Exercise 2:** Tracing Forward ChainingModify `evaluate_student()` to print each evaluated rule condition as the loop runs, demonstrating step-by-step logical deduction.