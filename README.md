# 🎓 Erasmus Course Equivalence Database System

![Status](https://img.shields.io/badge/Status-Completed-success)
![SQL](https://img.shields.io/badge/Language-T--SQL-blue)
![Platform](https://img.shields.io/badge/Platform-MS%20SQL%20Server-red)
![Design](https://img.shields.io/badge/Design-3NF%20Normalized-green)

## 📖 Project Overview
This project addresses the complexity of the **Erasmus Course Equivalence** process. It provides a structured database solution to automate and validate the matching of courses between Home and Host universities.

The system is built using a **"Superset Integration Strategy"**, allowing it to handle diverse academic structures (e.g., **Ege University's** T+U+L system, **TOBB ETÜ's** Trimester/Co-op model, and **Bahçeşehir's** software curriculum) within a single unified schema.

## 📐 Database Architecture & Design
The database was designed following **EER (Enhanced Entity-Relationship)** modeling and **3rd Normal Form (3NF)** principles to ensure data integrity.

* **Superset Integration:** Merged attributes from multiple universities to prevent data loss (e.g., tracking Theory, Practice, and Laboratory hours separately).
* **Disjoint Specialization:** Utilized to categorize course types (Mandatory, Technical Elective, Social Elective) without redundancy.
* **Recursive Relationships:** Implemented to model complex prerequisite chains (e.g., Course A requires Course B).
* **Weak Entities:** Used for "Digital Syllabus" components like *Weekly Plan*, *Assessment*, and *ECTS Workload* which are existence-dependent on the Course entity.

*(Detailed ER Diagrams and Logical Schema mappings are available in the `Erasmus-Project-Report.pdf` file.)*

## 🚀 Key Features

### 1. The 4-Stage Decision Funnel (DSS)
Implemented in the `/Queries` folder, this module acts as a Decision Support System (DSS) for coordinators:
1.  **Identity & Workload Verification:** Compares Official ECTS vs. Calculated Workload (Hours) to detect credit inflation.
2.  **Structural Gatekeeper:** Checks "Go/No-Go" criteria like Language, Credit, and Mode of Delivery side-by-side.
3.  **Semantic Context:** Compares Course Purpose & Descriptions to understand the "spirit" of the course.
4.  **Competency Matching:** Lists Learning Outcomes side-by-side to visualize curriculum gaps (granularity analysis).

### 2. Automated Data Integrity (Triggers)
The system uses SQL Triggers (found in `/Triggers`) to enforce academic rules:
* **`trg_CalculateTotalWorkload`:** Automatically calculates total hours based on activity count and duration.
* **`trg_CheckAssessmentTotal`:** Ensures assessment contributions (Midterm, Final, etc.) do not exceed 100%.
* **`trg_CheckCourseTypeConflict`:** Prevents a course from being classified as both "Mandatory" and "Elective" simultaneously.

### 3. Smart Search & Reporting
* **Dynamic Search:** `sp_SearchCourseByECTS` stored procedure allows students to find courses matching their missing ECTS credits.
* **Hierarchical Reporting:** Uses `LAG()` window functions to generate clean, non-repetitive reports (University -> Faculty -> Department grouping).

## 📂 Repository Structure

* **`/Constraints`**: SQL scripts for data integrity rules (e.g., ECTS limits 0-30, Language validation).
* **`/Queries`**: Contains the core Reporting Logic, Hierarchical Views, and Stored Procedures.
* **`/Triggers`**: Automation scripts for workload calculations and error handling.
* **`Erasmus-Project-Report.pdf`**: The comprehensive documentation containing:
    * Conceptual Design (EER Diagrams)
    * Logical Database Design (Relational Schema)
    * Output Screenshots & Analysis
    * Design Rationale

## 🛠 How to Run
1.  **Setup:** Run the table creation scripts (derived from the Relational Model in the report).
2.  **Constraints:** Execute scripts in `/Constraints` to apply business rules.
3.  **Triggers:** Execute scripts in `/Triggers` to enable automation.
4.  **Populate:** Insert dummy data (provided in the report's "Insert" section).
5.  **Analyze:** Use the reporting scripts in `/Queries` to generate equivalence tables.

---
**Author:** Kutlu Çağan Akın 
