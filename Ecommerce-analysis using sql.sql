select * from "ECommerece"
---Retrieve customers who have spent more than the average total spend.
select distinct "Customer ID" from "ECommerece"  where "Total Spend" >  (select avg("Total Spend") from "ECommerece")


---Find the number of customers in each membership type, ordered by count.

select count("Customer ID" ) from "ECommerece" group by "Membership Type" order by count

--Find the top 5 highest-spending customers along with their cities.
with top as (select "City", dense_rank() over(order by "Total Spend" desc) as rank from "ECommerece")
select * from top where rank in (1,2,3,4,5)

--Get the average rating for each city, sorted from highest to lowest.
select "City",avg("Average Rating") from "ECommerece" group by "City" order by avg desc

--Retrieve all customers who received a discount and are classified as ‘Unsatisfied’.

select distinct "Customer ID" from "ECommerece" where "Discount Applied"='true' and "Satisfaction Level"='Unsatisfied' order by "Customer ID" 

--Find the city with the highest total spend per customer.
with high as (select "City",sum("Total Spend") as total from "ECommerece" group by "City")
select "City" from high where total=(select max(total) from high)


---Find customers who purchased more than the average number of items within each membership type.
with avg_spend as (select "Membership Type",avg("Items Purchased") as total from "ECommerece" group by "Membership Type")
select e."Customer ID" from "ECommerece" as e join avg_spend as a on e."Membership Type" = a."Membership Type" WHERE e."Items Purchased" > a.total;

--Calculate the percentage of customers in each satisfaction level per membership type.
with total as (select "Membership Type","Satisfaction Level",count("Customer ID")  as count from "ECommerece" group by "Membership Type","Satisfaction Level"),
sum as (select sum(count) as sum from total)
select t."Membership Type",t."Satisfaction Level",count*100/s.sum from total as t, sum as s


--Find the customers who have not purchased anything in the last 30 days.
select distinct "Customer ID" from "ECommerece" where "Days Since Last Purchase" >= 30




