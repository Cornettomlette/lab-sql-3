/* Instructions
How many distinct (different) actors' last names are there?
In how many different languages where the films originally produced?
How many movies were not originally filmed in English?
Get 10 the longest movies from 2006.
How many days has been the company operating (check DATEDIFF() function)?
Show rental info with additional columns month and weekday. Get 20.
Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
How many rentals were in the last month of activity?
*/

USE sakila;
-- 1) How many distinct (different) actors' last names are there?
SELECT COUNT(distinct last_name) AS distinct_last_names FROM actor;

-- 2) In how many different languages where the films originally produced?
SELECT COUNT(distinct language_id) FROM language;  
SELECT COUNT(distinct language_id) FROM film; 

-- 3) How many movies were not originally filmed in English?
SELECT COUNT(distinct language_id) FROM film;  
-- 			Every film was filmed in English

-- 4) Get 10 the longest movies from 2006.
SELECT film_id, title, length FROM film
WHERE release_year >= 2006 
ORDER BY length
LIMIT 10;

-- 5) How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(max(return_date), min(rental_date)) as operating_in_days, min(rental_date) as first_rental, max(return_date) as last_return from rental;

-- 6) Show rental info with additional columns month and weekday. Get 20.
SELECT *, DATE_FORMAT(rental_date, '%M') AS rental_month, DATE_FORMAT(rental_date, '%W') AS rental_weekday FROM rental
LIMIT 20;

-- 7) Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
	WHEN DATE_FORMAT(rental_date, '%w') BETWEEN 1 and 5 THEN 'weekday' -- %w : Day of the week where Sunday=0 and Saturday=6
	ELSE 'week-end'
END AS 'day_type'
FROM rental;

-- 8) How many rentals were in the last month of activity?
SELECT rental_id, return_date, DATE_FORMAT(return_date, '%M') as return_month FROM rental
ORDER BY return_date DESC;

SELECT COUNT(rental_id) FROM rental
WHERE DATE_FORMAT(return_date, '%M %Y') = 'September 2005';
