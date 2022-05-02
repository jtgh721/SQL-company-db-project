-- employee data report
select emp.emp_id as "EMPLOYEE_ID",
emp.first_name, emp.last_name, emp.birth_day, emp.sex, 
branch.branch_name as "BRANCH_NAME",
CONCAT(manager.first_name, ' ', manager.last_name) AS 'MANAGER_NAME'
from employee as emp
left join branch on (emp.branch_id = branch.branch_id)
left join employee as manager on (emp.super_id = manager.emp_id);