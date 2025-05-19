# Netflix SQL Analysis Project

![](https://github.com/zack7273/Netflix-Data-Analysis-Using-SQL/blob/main/logo.png)

## 🔹 Overview
This project analyzes **Netflix content trends** using SQL to uncover insights about:
- Movie vs TV Show distribution
- Director and Actor statistics
- Genre trends
- Rating analysis
- Yearly content releases

## 🔹 SQL Topics Covered
✅ Aggregation (`COUNT`, `GROUP BY`, `ORDER BY`)  
✅ String Filtering (`LIKE`, `REGEXP`)  
✅ Date Functions (`DATE_SUB`, `CURDATE`)  
✅ Subqueries & Ranking (`LIMIT`, `AVG`)  
✅ Sentiment Analysis (`CASE` Statements)  



## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```


🔹 Business Problems & SQL Queries


Basic Aggregations & Filtering

-- Count the number of Movies vs TV Shows

```sql
SELECT type, COUNT(*) AS content_count
FROM netflix_titles
GROUP BY type;
```


-- Find the most common rating for movies and TV shows

```sql
SELECT rating, COUNT(*) AS count
FROM netflix_titles
GROUP BY rating
ORDER BY count DESC
LIMIT 1;
```


-- List all movies released in a specific year (e.g., 2020)

```sql
SELECT title, type
FROM netflix_titles
WHERE release_year = 2020;
```

-- Find content added in the last 5 years

```sql
SELECT title, type, date_added
FROM netflix_titles
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
```

-- Intermediate Queries

-- Find the top 5 countries with the most content

```sql
SELECT country, COUNT(*) AS total_content
FROM netflix_titles
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;
```


-- Identify the longest movie

```sql
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;
```



-- Find all the movies/TV shows by director 'Rajiv Chilaka'

```sql
SELECT title, type
FROM netflix_titles
WHERE director = 'Rajiv Chilaka';
```

-- List all TV shows with more than 5 seasons

```sql
SELECT title, duration
FROM netflix_titles
WHERE type = 'TV Show' AND duration REGEXP '^[6-9]|[1-9][0-9] Season';
```

-- Count the number of content items in each genre

```sql
SELECT listed_in, COUNT(*) AS genre_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY genre_count DESC;
```


-- Advanced Analytics

-- Find each year and the average number of content released in India

```sql
SELECT release_year, COUNT(*) / 12 AS avg_monthly_releases
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY avg_monthly_releases DESC
LIMIT 5;
```


-- List all movies that are documentaries

```sql
SELECT title
FROM netflix_titles
WHERE listed_in LIKE '%Documentary%'
AND type = 'Movie';
```

-- Find all content without a director


```sql
SELECT title, type
FROM netflix_titles
WHERE director IS NULL;
```

-- Find how many movies actor 'Salman Khan' appeared in last 10 years

```sql
SELECT COUNT(*) AS movie_count
FROM netflix_titles
WHERE cast LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10
AND type = 'Movie';
```


-- Find the top 10 actors who have appeared in the highest number of movies produced in India


```sql
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
```

-- Expert-Level Text Analysis

-- Categorize content based on 'kill' and 'violence' in the description


```sql
SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total_count
FROM netflix_titles
GROUP BY category;
```


**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

-- **🔹 Project Summary **
-- ✅ Uses real-world dataset (Netflix Titles).
-- ✅ Solves practical business problems (Content trends, directors, actors, genres).
-- ✅ Advanced analysis using SQL techniques (Aggregations, text search, subqueries).
-- ✅ Prepares for deeper insights in streaming industry.

