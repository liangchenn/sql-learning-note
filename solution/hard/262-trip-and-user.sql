-- Description
-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
-- Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.
-- Return the result table in any order.
-- The query result format is in the following example.

-- Tables
-- Trips table:
-- +----+-----------+-----------+---------+---------------------+------------+
-- | id | client_id | driver_id | city_id | status              | request_at |
-- +----+-----------+-----------+---------+---------------------+------------+
-- | 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
-- | 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
-- | 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
-- | 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
-- | 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
-- | 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
-- | 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
-- | 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
-- | 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
-- | 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
-- +----+-----------+-----------+---------+---------------------+------------+
-- Users table:
-- +----------+--------+--------+
-- | users_id | banned | role   |
-- +----------+--------+--------+
-- | 1        | No     | client |
-- | 2        | Yes    | client |
-- | 3        | No     | client |
-- | 4        | No     | client |
-- | 10       | No     | driver |
-- | 11       | No     | driver |
-- | 12       | No     | driver |
-- | 13       | No     | driver |
-- +----------+--------+--------+


-- Solution
with CTE as (
    select t.*, c.client_banned, d.driver_banned
    from Trips t
    inner join (
        select 
            users_id, 
            banned as client_banned
        from Users
    ) c
    on c.users_id = t.client_id
    inner join (
        select 
            users_id,
            banned as driver_banned
        from Users
    ) d
    on d.users_id = t.driver_id
)
select 
    request_at as Day,
    ROUND(AVG(cancelled), 2) as 'Cancellation Rate' 
from (
    select 
        *, 
        CASE WHEN (status != 'completed') THEN 1 ELSE 0 END as 'cancelled'
    from CTE
    where client_banned = 'No' and driver_banned = 'No'
) res
where request_at between '2013-10-01' and '2013-10-03'
group by 
    request_at