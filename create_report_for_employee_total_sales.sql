-- sum of total sales for each employee
select emp.emp_id as "EMPLOYEE_ID",
emp.first_name, emp.last_name,
branch.branch_name as "BRANCH_NAME",
CONCAT(manager.first_name, ' ', manager.last_name) AS 'MANAGER_NAME',
emp_total_sales.total_sales as "SUM_OF_TOTAL_SALES"
from employee as emp
left join branch on (emp.branch_id = branch.branch_id)
left join employee as manager on (emp.super_id = manager.emp_id)
left join(  select emp_id, sum(total_sales) as total_sales
            from works_with group by emp_id ) as emp_total_sales 
on (emp.emp_id = emp_total_sales.emp_id);
