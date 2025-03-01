## Challenge - Joining on multiple tables
-- Write SQL queries to perform the following tasks using the Sakila database:

use sakila;
-- 1. List the number of films per category.
select count(f.film_id) ,c.name
from film f
join 
film_category fc
on f.film_id=fc.film_id
join 
category c
on fc.category_id=c.category_id
group by c.name;
-- 2. Retrieve the store ID, city, and country for each store.
select s.store_id , c.city , ct.country
from store s
join address ad
on s.address_id=ad.address_id
join city c  
on ad.city_id=c.city_id
join country ct
on ct.country_id=c.country_id;
-- 3.  Calculate the total revenue generated by each store in dollars.
select sum(s.total_revenue) as total_revenue ,s.store_id
from
(select sum(p.amount) as total_revenue, c.customer_id ,c.store_id
from payment p
join customer c
group by c.customer_id )s
group by s.store_id;


-- 4.  Determine the average running time of films for each category.

select SEC_TO_TIME(FLOOR(ROUND(avg(length*60),2))) as average_duration ,c.name
from film f
join 
film_category fc
on f.film_id=fc.film_id
join 
category c
on fc.category_id=c.category_id
group by c.name;




-- **Bonus**:

-- 5.  Identify the film categories with the longest average running time.

select SEC_TO_TIME(FLOOR(ROUND(avg(length*60),2))) as average_duration ,c.name
from film f
join 
film_category fc
on f.film_id=fc.film_id
join 
category c
on fc.category_id=c.category_id
group by c.name
ORDER BY average_duration DESC
LIMIT 1;


-- 6.  Display the top 10 most frequently rented movies in descending order.
select title , rental_duration from film
order by rental_duration desc
limit 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
select count(distinct i.store_id) 
from inventory i
join
film f
on f.film_id=i.film_id
where f.title='Academy Dinosaur';

-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. 
 select f.title,
  case
 when  i.film_id is not null  then 'available'
 else 'Not Available'
 end as status
 
 from film f 
 join inventory i 
 on f.film_id =i.film_id
 group by f.film_id;
-- Include a column indicating whether each title is 'Available' or 'NOT available.' 
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained 
-- using a `CASE` statement combined with `IFNULL`."

