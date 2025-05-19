-- (Database & Table Setup)


-- Create Netflix database
CREATE DATABASE IF NOT EXISTS netflix_db;
USE netflix_db;

-- Drop table if it already exists (to prevent conflicts)
DROP TABLE IF EXISTS netflix_titles;

-- Create Netflix Titles Table
CREATE TABLE netflix_titles (
    show_id VARCHAR(10) PRIMARY KEY, -- Unique identifier for each title
    type ENUM('Movie', 'TV Show'), -- Defines whether content is a Movie or TV Show
    title VARCHAR(255) NOT NULL, -- Name of the title
    director VARCHAR(255), -- Director's name (Nullable)
    cast TEXT, -- List of actors (Nullable)
    country VARCHAR(255), -- Country of production (Nullable)
    date_added DATE DEFAULT NULL, -- Date when Netflix added it (Nullable)
    release_year YEAR NOT NULL, -- Year the content was released
    rating VARCHAR(10), -- Content rating (PG, R, etc.)
    duration INT, -- Stores numeric value of duration
    duration_unit ENUM('Minutes', 'Season'), -- Stores unit type (for TV Shows)
    listed_in TEXT NOT NULL, -- Genres of the content
    description TEXT -- Short summary of the title
);


-- Create the Netflix database
CREATE DATABASE IF NOT EXISTS netflix_db;
USE netflix_db;

-- Drop table if it already exists (to prevent conflicts)
DROP TABLE IF EXISTS netflix_titles;

-- Create Netflix Titles Table
CREATE TABLE netflix_titles (
    show_id VARCHAR(10) PRIMARY KEY, -- Unique identifier for each title
    type ENUM('Movie', 'TV Show') NOT NULL, -- Content type: Movie or TV Show
    title VARCHAR(255) NOT NULL, -- Name of the title
    director VARCHAR(255), -- Director's name (Nullable)
    cast TEXT, -- List of actors (Nullable)
    country VARCHAR(255), -- Country of production (Nullable)
    date_added DATE DEFAULT NULL, -- Date when Netflix added it (Nullable)
    release_year YEAR NOT NULL, -- Year the content was released
    rating VARCHAR(10), -- Content rating (PG, R, etc.)
    duration INT, -- Stores numeric value of duration
    duration_unit ENUM('Minutes', 'Season') NOT NULL, -- Stores unit type (Minutes for Movies, Seasons for TV Shows)
    listed_in TEXT NOT NULL, -- Genres of the content
    description TEXT -- Short summary of the title
);

-- Indexing for faster searches
CREATE INDEX idx_title ON netflix_titles(title);
CREATE INDEX idx_director ON netflix_titles(director);
CREATE INDEX idx_country ON netflix_titles(country);
CREATE INDEX idx_release_year ON netflix_titles(release_year);