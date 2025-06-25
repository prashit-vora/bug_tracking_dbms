# Bug Tracking DBMS

This project is a Database Management System for tracking software bugs. It manages data related to employees, projects, issues, roles, comments, and attachments. The system is designed to support querying and analysis of issue-related data in a structured and normalized format.

---

## Features

- Track and display all employees, projects, issues, comments, and attachments
- Count and rank issues per project and employee
- Identify open issues and unresolved critical bugs
- Analyze employee activity and project progress
- Include and track tester teams
- Display issue history and comment frequency
- Detect issues with no comments or multiple attachments

---

## Technologies Used

- PostgreSQL (or any standard relational database system)
- SQL (DDL and DML)
- ER and Relational Diagrams
- Normalization and functional dependency documentation

---

## Files Included

- `queries.sql` – Contains all SQL queries used in the project
- `ddl_fd_normalization.pdf` – Documentation of functional dependencies and normalization
- `requirements_list.pdf` – Project requirements and objectives
- `final_er_diagram.drawio.png` – Entity-Relationship diagram
- `final_relational_diagram.drawio.png` – Relational schema diagram

---

## Usage Instructions

1. Load the database schema using your preferred SQL platform
2. Use the `queries.sql` file to run the required reports and queries
3. Refer to the ER and relational diagrams for schema understanding
4. Use the documentation to understand the design and requirements

---

## Notes

- This project is focused on backend database design only
- Tester teams can be added to the system and tracked through queries
- All queries are compatible with PostgreSQL and follow standard SQL conventions
