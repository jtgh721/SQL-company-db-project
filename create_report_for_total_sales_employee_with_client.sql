-- Sales of each employee has with each clients 
select emp.emp_id as "EMPLOYEE_ID", emp.first_name, emp.last_name,
branch.branch_name as "BRANCH_NAME",
CONCAT(manager.first_name, ' ', manager.last_name) AS 'MANAGER_NAME',
emp_total_sales.client_name, emp_total_sales.total_sales
from employee as emp
left join branch 
on (emp.branch_id = branch.branch_id)
left join employee as manager 
on (emp.super_id = manager.emp_id)
left join ( select works_with.emp_id, client.client_name as client_name, works_with.total_sales
            from works_with, client
            where works_with.client_id = client.client_id) 
            as emp_total_sales 
on (emp_total_sales.emp_id = emp.emp_id)
order by emp.emp_id;