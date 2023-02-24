-- INNER JOIN -- results will only be included in the output if a corresponding record exists on each table we join to

-- Write a query to retrieve the name and state abbreviation for the 2 cities named "Columbus" in the database
SELECT city_name, state_abbreviation
FROM city
WHERE city_name = 'Columbus';

-- Modify the previous query to retrieve the names of the states (rather than their abbreviations).
SELECT city_name, state_name -- we removed state_abbreviation and replaced it with state_name
FROM city -- the table we are starting in
JOIN state -- the table we are wanting to also get data from
	ON city.state_abbreviation = state.state_abbreviation -- indicate which columns from each table must equal to make the match
WHERE city_name = 'Columbus';

SELECT *
FROM city
JOIN state
	 ON city.state_abbreviation = state.state_abbreviation
WHERE city.state_abbreviation = 'TX';

-- If there are two columns named the same (for instance, area in state and area in city)
-- then we can put the table name in front of the column to specify which one we want
SELECT city.area AS city_area, state.area AS state_area
FROM city
JOIN state
	 ON city.state_abbreviation = state.state_abbreviation
WHERE city.state_abbreviation = 'TX';

-- Write a query to retrieve the names of all the national parks with their state abbreviations.
-- (Some parks will appear more than once in the results, because they cross state boundaries.)
SELECT park_name, state_abbreviation
FROM park
JOIN park_state -- we join to the table we want to include more dta from
     ON park.park_id = park_state.park_id;

-- The park_state table is an associative table that can be used to connect the park and state tables.
-- Modify the previous query to retrieve the names of the states rather than their abbreviations.
SELECT park_name, state_name
FROM park
JOIN park_state -- we join to the table we want to include more dta from
     ON park.park_id = park_state.park_id
JOIN state
	 ON park_state.state_abbreviation = state.state_abbreviation;

-- Modify the previous query to include the name of the state's capital city.
SELECT park_name, state_name, city_name
FROM park
JOIN park_state -- we join to the table we want to include more dta from
     ON park.park_id = park_state.park_id
JOIN state
	 ON park_state.state_abbreviation = state.state_abbreviation
JOIN city
	 ON state.capital = city.city_id;

-- Modify the previous query to include the area of each park.
SELECT park_name, state_name, city_name, park.area
FROM park
JOIN park_state -- we join to the table we want to include more dta from
     ON park.park_id = park_state.park_id
JOIN state
	 ON park_state.state_abbreviation = state.state_abbreviation
JOIN city
	 ON state.capital = city.city_id;

-- Write a query to retrieve the names and populations of all the cities in the Midwest census region.
SELECT city_name, city.population
FROM city
JOIN state
     ON city.state_abbreviation = state.state_abbreviation
WHERE census_region = 'Midwest';

-- Write a query to retrieve the number of cities in the city table for each state in the Midwest census region.
SELECT state_name, COUNT(*)
FROM state
JOIN city
     ON state.state_abbreviation = city.state_abbreviation
WHERE state.census_region = 'Midwest' -- we don't need the state. before the census_region
GROUP BY state.state_abbreviation;

-- Modify the previous query to sort the results by the number of cities in descending order.
SELECT state_name, COUNT(*) AS num_cities -- this runs sixth
FROM state -- this runs first
JOIN city
     ON state.state_abbreviation = city.state_abbreviation
WHERE state.census_region = 'Midwest' -- we don't need the state. before the census_region
GROUP BY state.state_abbreviation
ORDER BY num_cities DESC; -- this runs seventh


-- LEFT JOIN

-- Write a query to retrieve the state name and the earliest date a park was established in that state (or territory) for every record in the state table that has park records associated with it.
SELECT state_name, MIN(date_established)
FROM state -- LEFT JOIN means regardless if we find any corresponding records, still keep the data from the table we started with
JOIN park_state
     ON state.state_abbreviation = park_state.state_abbreviation
JOIN park
     ON park_state.park_id = park.park_id
GROUP BY state_name;

-- Modify the previous query so the results include entries for all the records in the state table, even if they have no park records associated with them.



-- UNION

-- Write a query to retrieve all the place names in the city and state tables that begin with "W" sorted alphabetically. (Washington is the name of a city and a state--how many times does it appear in the results?)
SELECT city_name AS place_name
FROM city
WHERE city_name LIKE 'W%'
UNION
SELECT state_name AS place_name
FROM state
WHERE state_name LIKE 'W%';

-- Modify the previous query to include a column that indicates whether the place is a city or state.
SELECT city_name AS place_name, 'City' AS type
FROM city
WHERE city_name LIKE 'W%'
UNION
SELECT state_name AS place_name, 'State' AS type
FROM state
WHERE state_name LIKE 'W%';


-- MovieDB
-- After creating the MovieDB database and running the setup script, make sure it is selected in pgAdmin and confirm it is working correctly by writing queries to retrieve...

-- The names of all the movie genres


-- The titles of all the Comedy movies

