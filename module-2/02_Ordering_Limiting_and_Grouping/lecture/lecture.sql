-- ORDERING RESULTS

-- Populations of all states from largest to smallest.
SELECT *
FROM state
ORDER BY population DESC;

-- States sorted alphabetically (A-Z) within their census region. The census regions are sorted in reverse alphabetical (Z-A) order.
SELECT state_name, census_region
FROM state
WHERE census_region IS NOT NULL
ORDER BY census_region DESC, state_name ASC;

-- The biggest park by area
SELECT *
FROM park
ORDER BY area DESC
LIMIT 1;

-- LIMITING RESULTS

-- The 10 largest cities by populations
SELECT city_name, population
FROM city
ORDER BY population DESC
LIMIT 10;

-- The 20 oldest parks from oldest to youngest in years, sorted alphabetically by name.
SELECT *
FROM park
ORDER BY date_established ASC, park_name
LIMIT 20;

SELECT park_name, (CURRENT_DATE - date_established) AS age
FROM park
ORDER BY age DESC
LIMIT 20;

-- Or we can calculate an age using the built in CURRENT_DATE and we can divide by 365 to get the years
SELECT park_name, (CURRENT_DATE - date_established)/365 AS age
FROM park
ORDER BY age DESC
LIMIT 20;

-- CONCATENATING OUTPUTS

-- In Java, if I wanted to combine my first name "Christopher" and my last initial "G", then I would do something like:
-- firstName + " " + lastInitial
-- in SQL we don't use the +, instead we use ||
SELECT 'Christopher' || ' ' || 'G';

-- All city names and their state abbreviation.
SELECT city_name || ' (' || state_abbreviation || ')' AS city_state
FROM city;

SELECT *
FROM state
ORDER BY census_region DESC;

-- The all parks by name and date established.
SELECT 'NAME: ' || park_name || '  DATE ESTABLISHED: ' || date_established
FROM park;

-- The census region and state name of all states in the West & Midwest sorted in ascending order.
SELECT census_region || ' - ' || state_name AS region_state
FROM state
WHERE census_region in ('West','Midwest')
ORDER BY region_state;

-- AGGREGATE FUNCTIONS

-- Average population across all the states. Note the use of alias, common with aggregated values.
SELECT AVG(population) AS avg_population
FROM state;

-- Total population in the West and South census regions
SELECT SUM(population) AS total_west_south_population
FROM state
WHERE census_region in ('West','South');

SELECT SUM(population) AS total_west_south_population
FROM state
WHERE census_region = 'West' OR census_region = 'South';

-- The number of cities with populations greater than 1 million
SELECT COUNT(*) -- count (*) will return the number of rows
FROM city
WHERE population > 1000000;

-- The number of state nicknames.
SELECT COUNT(*) -- count(*) will count all rows
FROM state;

SELECT COUNT(state_nickname) -- count(cloumn) will count all the non-null values in that column
FROM state;

SELECT *
FROM state;

SELECT COUNT(DISTINCT census_region) -- if we want unique values from the column use DISTINCT
FROM state;

-- The area of the smallest and largest parks.
SELECT MAX(area) AS largest, MIN(area) AS smallest
FROM park;

-- GROUP BY

-- Count the number of cities in each state, ordered from most cities to least.
SELECT state_abbreviation, COUNT(*) as num_cities
FROM city
GROUP BY state_abbreviation
ORDER BY num_cities DESC;

-- Determine the average park area depending upon whether parks allow camping or not.
SELECT has_camping, AVG(area) AS avg_park_area
FROM park
GROUP BY has_camping;

-- Sum of the population of cities in each state ordered by state abbreviation.
SELECT state_abbreviation, SUM(population) AS total_population
FROM city
GROUP BY state_abbreviation
ORDER BY state_abbreviation;

-- The smallest city population in each state ordered by city population.
SELECT state_abbreviation, MIN(population) AS smallest_city
FROM city
GROUP BY state_abbreviation
ORDER BY smallest_city;

-- Miscelleneous

-- While you can use LIMIT to limit the number of results returned by a query,
-- it's recommended to use OFFSET and FETCH if you want to get
-- "pages" of results.
-- For instance, to get the first 10 rows in the city table
-- ordered by the name, you could use the following query.
-- (Skip 0 rows, and return only the first 10 rows from the sorted result set.)
SELECT *
FROM city
ORDER BY city_name
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- SUBQUERIES (optional)

-- Include state name rather than the state abbreviation while counting the number of cities in each state,
SELECT COUNT(*) as num_cities, 
	(SELECT state_name 
	 FROM state 
	 WHERE state_abbreviation = city.state_abbreviation)
FROM city 
GROUP BY state_abbreviation
ORDER BY state_abbreviation;

-- Include the names of the smallest and largest parks
SELECT park_name, area
FROM park p, (
	SELECT MIN(area) as smallest, MAX(area) as largest
	FROM park	
) as largest_smallest
WHERE p.area = largest_smallest.smallest OR p.area = largest_smallest.largest;

-- List the capital cities for the states in the Northeast census region.

