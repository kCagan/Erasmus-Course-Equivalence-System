# 🎓 Erasmus Course Equivalence Database System

![Status](https://img.shields.io/badge/Status-Completed-success)
![SQL](https://img.shields.io/badge/Language-T--SQL-blue)
![Platform](https://img.shields.io/badge/Platform-MS%20SQL%20Server-red)

## 📖 Project Overview
This project addresses the complexity of the **Erasmus Course Equivalence** process. It provides a structured database solution to automate and validate the matching of courses between Home and Host universities, ensuring **Data Integrity** and **Academic Consistency**.

Instead of manual comparisons, this system uses a **4-Stage Decision Funnel** to assist coordinators.

## 🚀 Key Features

### 1. The 4-Stage Analysis Funnel (Reporting)
Implemented in the `/Queries` folder, the system filters courses through a hierarchical logic:
1.  **Workload Verification:** Compares Official ECTS vs. Calculated Workload (Hours).
2.  **Structural Gatekeeper:** Checks Language, Credit, and Mode of Delivery constraints.
3.  **Semantic Context:** Compares Course Purpose & Descriptions.
4.  **Competency Matching:** Side-by-side comparison of Learning Outcomes to identify curriculum gaps.

### 2. Database Integrity & Automation
* **Constraints:** Strict rules to prevent invalid data entry (e.g., Course Credits limits, standardized Delivery Modes).
* **Triggers:** Automated actions that maintain data consistency across tables.
* **Smart Search:** Stored procedures allow users to find relevant courses by ECTS dynamically.

### 3. Advanced SQL Techniques
* **Window Functions:** `LAG()` used for hierarchical, non-repetitive reporting.
* **CTEs (Common Table Expressions):** Used for complex workload calculations.
* **Dynamic Procedures:** Parameterized queries for user interaction.

## 📂 Repository Structure

* **`/Constraints`**: Contains SQL scripts for data integrity rules (e.g., ECTS limits, Language validation).
* **`/Queries`**: Includes the core reporting logic, hierarchical listing queries, and the 4-stage analysis script.
* **`/Triggers`**: Database triggers for automated consistency checks.
* **`Erasmus-Project-Report.pdf`**: The detailed project documentation, including design rationale, ER diagrams, and **output screenshots**.

## 🛠 How to Run
1.  Run the scripts in `/Queries` to create the initial tables (if included).
2.  Execute scripts in `/Constraints` to apply rules.
3.  Execute `/Triggers` to enable automation.
4.  Use the reporting scripts in `/Queries` to generate equivalence reports.

---
**Author:** [Senin Adın]
