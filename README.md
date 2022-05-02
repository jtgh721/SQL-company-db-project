# SQL-company-db-project
 RDBMS-project-sql
# Company Database Project

The purpose of this project is to 
1. create a company database by using SQLTools in Visual Studio Code
2. create reports based on the data in company database

### 1.1 Install Company Database Schemas
To install company database schemas, run the following **2 files** in SQL terminal.

```
1. create_company_db_tables.sql
2. insert_company_db_data.sql
```

### 1.2 Company Schema Diagram
In company database, we have 5 tables

**employee** (*ID*, FIRST_NAME, LAST_NAME, BIRTH_DATE, SEX, SALARY, **SUPERVISOR_ID, **BRANCH_ID)
- employee table stores all employee data including employee id, first name, last name, birth date, sex, salary, supervior employee id and branch id.

**branch** (*ID, NAME, **MANAGER_ID, MANAGER_START_DATE)
- branch table stores all the information related to a branch including branch id, branch name, branch manager employee id, branch manager start date.

**client** (*ID, NAME, **BRANCH_ID)
- client table stores all the information related to a client including client id, client name, branch id that each client belongs to.

**branch_supplier** (*branch_id, *supplier_name, supply_type)
- branch_supplier table stores all the supplier information including supplier name and supply type that a branch works with.

**works_with** (*EMPLOYEE_ID, *CLIENT_ID, TOTAL_SALES)
- works_with table store the total sales for each employee based on the client that he/she works with.


*(Primary key) 
** (Foreign key)

For more details, please see [company schema diagram]()

### 2. reports based on the data in Company Database
```
1. create_report_for_employee_data.sql
2. create_report_for_total_sales_employee_with_client.sql
3. create_report_for_employee_total_sales.sql
```

### 2.1 Create employee data report
To create an employee data report, run **create_report_for_employee_data.sql** file in mySQL.

```
-- employee data report
select emp.emp_id as "EMPLOYEE_ID",
emp.first_name, emp.last_name, emp.birth_day, emp.sex, 
branch.branch_name as "BRANCH_NAME",
CONCAT(manager.first_name, ' ', manager.last_name) AS 'MANAGER_NAME'
from employee as emp
left join branch on (emp.branch_id = branch.branch_id)
left join employee as manager on (emp.super_id = manager.emp_id);
```
This [report]() will show all the related data of each employee with employee id, employee first name, employee last name, birth date, sex, branch that an employee belongs, manager name of each employee.


### 2.2 Create total sales of each employee has with client details report 
To create a yearly report to show total sales, run **create_report_for_total_sales_employee_with_client.sql** file in mySQL.

```
-- Sales of each employee has with each clients 
select emp.emp_id as "EMPLOYEE_ID", emp.first_name, emp.last_name,
branch.branch_name as "BRANCH_NAME",
CONCAT(manager.first_name, ' ', manager.last_name) AS 'MANAGER_NAME',
emp_total_sales.client_name, emp_total_sales.total_sales
from employee as emp
left join branch    on (emp.branch_id = branch.branch_id)
left join employee as manager   on (emp.super_id = manager.emp_id)
left join ( select works_with.emp_id, client.client_name as client_name, works_with.total_sales
            from works_with, client
            where works_with.client_id = client.client_id) 
            as emp_total_sales  on (emp_total_sales.emp_id = emp.emp_id)
order by emp.emp_id;
```
This [report]() will show employee id, employee first name, employee last name, branch that employee belongs, manager name of each employee, client names, total sales of each employee.


### 2.3 Create a report for the sum of total sales of each employee
To create a yearly report to show sum of total sales for each employee, run **create_report_for_employee_total_sales.sql** file in mySQL.

```
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
```
This [report]() will show employee id, employee first name, employee last name, a branch that an employee belongs, manager name of each employee, sum of total sales for each employee has.