-- (A) CREATE, ALTER, DROP - DDL exercise 
-- 1.Creating a new table named (vehicle fleet)
create table vehicle_fleet(
vehicle_id INT,
license_plate VARCHAR(15),
capacity_tons DECIMAL(4,1),
);

-- 2.Modifying the table by adding a new column
alter table vehicle_fleet
add last_service_date DATE;

-- 3. Dropping the capacity_tons column
alter table vehicle_fleet
drop column capacity_tons;



-- (B) Data maintenance - DML exercise
-- 1. Inserting a new delivery record INTO the 'deliveries' table
insert into deliveries
values (111, 'John Wick', 'South', 18.50, 140, 'In Transit', 290);

-- 2. Updating a record bcos the delivery status has changed
update deliveries
	set status = 'Delivered',
		delivery_fee = 350
	where delivery_id = 103;

-- 3. Removing (DELETE) all records where 'status' is cancelled
delete from deliveries
where status = 'Cancelled';


-- (C) Advanced filtering and Pattern Matching
-- Find all successful deliveries with; 1. distance btw 40 and 120, 2. region is either north or west 3. driver's 1st name starts with 'S'
select *
from deliveries
where 
	status = 'Delivered' AND
	distance_km between 40 and 120 AND
	region in ('North', 'West') AND
	driver_name like 'S%';


-- (D) Business insights (Aggregations and Grouping)
-- 1. Find the total no. of unique drivers who have attempted deliveries
select count(distinct driver_name) as total_drivers
from deliveries;

-- 2. Find the total delivery fees collected and average distance covered for each region
select
	region,
	sum(delivery_fee) as total_fee,
	avg(distance_km) as average_distance
from deliveries
group by region
-- 3. Filtering the result to only show regions where the average distance is greater than 50km
having avg(distance_km) > 50;

-- (E) Ranking & Capping - Sorting and TOP
-- Writing a query to retrieve the TOP 3 longest deliveries that delivered successfully
select top 3 delivery_id, driver_name, region, distance_km
from deliveries
where status = 'Delivered'
order by distance_km desc


