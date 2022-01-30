-- Description
-- Write an SQL query to find employees who have the highest salary in each of the departments.
-- Return the result table in any order.
-- The query result format is in the following example.

-- Table
-- Employee table:
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- Department table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+


-- solution
select 
    d.name as Department,
    e.name as Employee,
    e.salary as Salary
from
    Department d,
    Employee e
where
    d.id = e.departmentId
    and e.Salary = (
        select max(salary)
        from Employee etmp
        where etmp.departmentId = d.id
    )