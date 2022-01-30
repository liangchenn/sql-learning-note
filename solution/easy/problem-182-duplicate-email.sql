-- Description
-- Write an SQL query to report all the duplicate emails.
-- Return the result table in any order.
-- The query result format is in the following example.

-- Tables
-- Person table:
-- +----+---------+
-- | id | email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+

-- solution
select p.email as Email
from (
    select *
    from Person
    group by email
    having count(1) > 1
) p;