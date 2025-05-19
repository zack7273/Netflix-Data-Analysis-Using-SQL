
🔹 Business Problems & SQL Queries


Basic Aggregations & Filtering

-- Count the number of Movies vs TV Shows

SELECT type, COUNT(*) AS content_count
FROM netflix_titles
GROUP BY type;


-- Find the most common rating for movies and TV shows

SELECT rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating
ORDER BY count DESC
LIMIT 1;


-- List all movies released in a specific year (e.g., 2020)
SELECT title, type
FROM netflix_titles
WHERE release_year = 2020;


-- Find content added in the last 5 years

SELECT title, type, date_added
FROM netflix_titles
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);



-- Intermediate Queries

-- Find the top 5 countries with the most content

SELECT country, COUNT(*) AS total_content
FROM netflix_titles
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;


-- Identify the longest movie

SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;



-- Find all the movies/TV shows by director 'Rajiv Chilaka'

SELECT title, type
FROM netflix_titles
WHERE director = 'Rajiv Chilaka';


-- List all TV shows with more than 5 seasons

SELECT title, duration
FROM netflix_titles
WHERE type = 'TV Show' AND duration REGEXP '^[6-9]|[1-9][0-9] Season';


-- Count the number of content items in each genre

SELECT listed_in, COUNT(*) AS genre_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY genre_count DESC;



-- Advanced Analytics

-- Find each year and the average number of content released in India

SELECT release_year, COUNT(*) / 12 AS avg_monthly_releases
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY avg_monthly_releases DESC
LIMIT 5;


-- List all movies that are documentaries

SELECT title
FROM netflix_titles
WHERE listed_in LIKE '%Documentary%'
AND type = 'Movie';


-- Find all content without a director

SELECT title, type
FROM netflix_titles
WHERE director IS NULL;


-- Find how many movies actor 'Salman Khan' appeared in last 10 years

SELECT COUNT(*) AS movie_count
FROM netflix_titles
WHERE cast LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10
AND type = 'Movie';



-- Find the top 10 actors who have appeared in the highest number of movies produced in India

SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n.n), ',', -1)) AS actor,
       COUNT(*) AS movie_count
FROM netflix_titles
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
ON CHAR_LENGTH(cast) - CHAR_LENGTH(REPLACE(cast, ',', '')) >= n.n - 1
WHERE country LIKE '%India%'
AND type = 'Movie'
GROUP BY actor
ORDER BY movie_count DESC
LIMIT 10;



-- Expert-Level Text Analysis

-- Categorize content based on 'kill' and 'violence' in the description

SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total_count
FROM netflix_titles
GROUP BY category;



-- 🔹 Project Summary
-- ✅ Uses real-world dataset (Netflix Titles)
-- ✅ Solves practical business problems (Content trends, directors, actors, genres)
-- ✅ Advanced analysis using SQL techniques (Aggregations, text search, subqueries)
-- ✅ Prepares for deeper insights in streaming industry
-- Would you like to expand this project into visualizations or reports? 🚀
-- Let me know how you'd like to refine it! 🎯
