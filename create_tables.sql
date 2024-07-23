-- Crear tabla Country
CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla File
CREATE TABLE File (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla Person
CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    country_id INT REFERENCES Country(id),
    primary_photo_id INT REFERENCES File(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla AppUser (anteriormente User)
CREATE TABLE AppUser (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_id INT REFERENCES File(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla Movie
CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2),
    release_date DATE,
    duration INT,
    director_id INT REFERENCES Person(id),
    country_id INT REFERENCES Country(id),
    poster_id INT REFERENCES File(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla Genre
CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Crear tabla MovieGenre
CREATE TABLE MovieGenre (
    movie_id INT REFERENCES Movie(id),
    genre_id INT REFERENCES Genre(id),
    PRIMARY KEY (movie_id, genre_id)
);

-- Crear tabla Character
CREATE TABLE Character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role VARCHAR(20) CHECK (role IN ('leading', 'supporting', 'background')),
    movie_id INT REFERENCES Movie(id),
    person_id INT REFERENCES Person(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla FavoriteMovies
CREATE TABLE FavoriteMovies (
    user_id INT REFERENCES AppUser(id),
    movie_id INT REFERENCES Movie(id),
    PRIMARY KEY (user_id, movie_id)
);
