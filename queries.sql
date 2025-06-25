-- 1. Show all employees
SELECT * FROM Employee;

-- 2. Show all projects
SELECT * FROM Projects;

-- 3. Show all issues
SELECT * FROM Issues;

-- 4. Show all comments
SELECT * FROM Comments;

-- 5. Show all attachments
SELECT * FROM Attachments;

-- 6. Show all roles
SELECT * FROM Roles;

-- 7. Number of issues per project
SELECT projectid, COUNT(issueid) AS num_issues
FROM Issues
GROUP BY projectid;

-- 8. Order employees by the number of issues they solved (descending)
SELECT E.firstname, E.lastname, COUNT(ISOL.issueid) AS issues_solved
FROM Employee E
JOIN IssueSolution ISOL ON E.employeeid = ISOL.employeeid
GROUP BY E.employeeid
ORDER BY issues_solved DESC;

-- 9. Average number of employees per project
SELECT AVG(emp_count) AS avg_employees_per_project
FROM (
    SELECT projectid, COUNT(employeeid) AS emp_count
    FROM EmployeeProjects
    GROUP BY projectid
) AS project_employee_counts;

-- 10. Display issue history
SELECT * FROM IssueHistory;

-- 11. Ascending order of project completion
SELECT projectid, projectname, end_date
FROM Projects
WHERE end_date IS NOT NULL
ORDER BY end_date ASC;

-- 12. Employees with the 'Write' permission on any project
SELECT DISTINCT E.firstname, E.lastname
FROM Employee E
JOIN EmployeePermissions EP ON E.employeeid = EP.employeeid
WHERE EP.permissionname = 'Write';

-- 13. List all open issues with project and priority details
SELECT I.issueid, I.title, I.status, I.priority, P.projectname
FROM Issues I
JOIN Projects P ON I.projectid = P.projectid
WHERE I.status = 'Open';

-- 14. Projects with no issues logged
SELECT P.projectid, P.projectname
FROM Projects P
LEFT JOIN Issues I ON P.projectid = I.projectid
WHERE I.issueid IS NULL;

-- 15. Issues with no comments
SELECT I.issueid, I.title
FROM Issues I
LEFT JOIN Comments C ON I.issueid = C.issueid
WHERE C.commentid IS NULL;

-- 16. Projects with issues solved within the last 30 days
SELECT DISTINCT P.projectid, P.projectname
FROM Projects P
JOIN Issues I ON P.projectid = I.projectid
JOIN IssueHistory IH ON I.issueid = IH.issueid
WHERE IH.solution_date > CURRENT_DATE - INTERVAL '30 days';

-- 17. Projects with more than 5 'Critical' priority issues
SELECT projectid, COUNT(issueid) AS critical_issues
FROM Issues
WHERE priority = 'Critical'
GROUP BY projectid
HAVING COUNT(issueid) > 5;

-- 18. Most recent comment date per issue
SELECT issueid, MAX(date_posted) AS most_recent_comment
FROM Comments
GROUP BY issueid;

-- 19. Count of issues resolved by each employee in the last 6 months
SELECT E.firstname, E.lastname, COUNT(ISOL.issueid) AS issues_resolved
FROM Employee E
JOIN IssueSolution ISOL ON E.employeeid = ISOL.employeeid
JOIN IssueHistory IH ON ISOL.issueid = IH.issueid
WHERE IH.solution_date > CURRENT_DATE - INTERVAL '6 months'
GROUP BY E.employeeid, E.firstname, E.lastname;

-- 20. Employees who resolved issues for at least 3 different projects
SELECT E.firstname, E.lastname, COUNT(DISTINCT P.projectid) AS project_count
FROM Employee E
JOIN IssueSolution ISOL ON E.employeeid = ISOL.employeeid
JOIN Issues I ON ISOL.issueid = I.issueid
JOIN Projects P ON I.projectid = P.projectid
GROUP BY E.employeeid
HAVING COUNT(DISTINCT P.projectid) >= 3;

-- 21. Longest unresolved 'Critical' priority issue
SELECT I.issueid, I.title, CURRENT_DATE - IH.create_date AS days_unresolved
FROM Issues I
JOIN IssueHistory IH ON I.issueid = IH.issueid
WHERE I.status != 'Resolved' AND I.priority = 'Critical'
ORDER BY days_unresolved DESC
LIMIT 1;

-- 22. Employees assigned to projects starting in the future
SELECT DISTINCT E.firstname, E.lastname
FROM Employee E
JOIN EmployeeProjects EP ON E.employeeid = EP.employeeid
JOIN Projects P ON EP.projectid = P.projectid
WHERE P.start_date > CURRENT_DATE;

-- 23. Employees assigned to the most projects
SELECT E.firstname, E.lastname, COUNT(EP.projectid) AS num_projects
FROM Employee E
JOIN EmployeeProjects EP ON E.employeeid = EP.employeeid
GROUP BY E.employeeid
ORDER BY num_projects DESC;

-- 24. Projects with the highest average issue priority
SELECT projectid, AVG(
    CASE priority
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        WHEN 'Critical' THEN 4
    END
) AS avg_priority
FROM Issues
GROUP BY projectid
ORDER BY avg_priority DESC;

-- 25. Count of comments per issue, sorted by most commented
SELECT issueid, COUNT(commentid) AS num_comments
FROM Comments
GROUP BY issueid
ORDER BY num_comments DESC;

-- 26. Issues with multiple attachments
SELECT issueid, COUNT(attachmentid) AS num_attachments
FROM Attachments
GROUP BY issueid
HAVING COUNT(attachmentid) > 1;

