CREATE DATABASE imdb

USE imdb

CREATE TABLE Directors
(
	Id int PRIMARY KEY IDENTITY,
	[Name] varchar(20) 
)

CREATE TABLE Genres
(
	Id int PRIMARY KEY IDENTITY,
	[Name] varchar(20) 
)

CREATE TABLE Actors
(
	Id int PRIMARY KEY IDENTITY,
	[Name] varchar(20) 

)

CREATE TABLE Movies
(
	Id int PRIMARY KEY IDENTITY,
	[Name] varchar(60),
	DirectorId int FOREIGN KEY REFERENCES Directors(Id),
	ImdbScore decimal,
	CHECK (ImdbScore >= 0 AND ImdbScore <= 10)
)


CREATE TABLE MoviesActors
(
	Id int PRIMARY KEY IDENTITY,
	ActorId int FOREIGN KEY REFERENCES Actors(Id),
	MovieId int FOREIGN KEY REFERENCES Movies(Id),
)

CREATE TABLE GenresMovies
(
	Id int PRIMARY KEY IDENTITY,
	GenreId int FOREIGN KEY REFERENCES Genres(Id),
	MovieId int FOREIGN KEY REFERENCES Movies(Id)
)


SELECT m.Id, m.Name, d.Name DirectorName, g.Name GenreName, a.Name ActorName, m.ImdbScore FROM Movies m
JOIN
Directors d
ON
d.Id = m.DirectorId
JOIN
GenresMovies gm
ON
m.Id = gm.MovieId
JOIN
Genres g
ON
gm.GenreId = g.Id
JOIN
MoviesActors ma
ON
m.Id = ma.MovieId
JOIN
Actors a
ON
ma.ActorId = a.Id
WHERE m.ImdbScore > 6









SELECT m.Id, m.Name, d.Name DirectorName, g.Name GenreName, m.ImdbScore FROM Movies m
JOIN
Directors d
ON
d.Id = m.DirectorId
JOIN
GenresMovies gm
ON
m.Id = gm.MovieId
JOIN
Genres g
ON
gm.GenreId = g.Id
WHERE g.Name LIKE '%a%'


SELECT m.Id, m.Name, d.Name DirectorName, g.Name GenreName, m.Duration, m.ImdbScore FROM Movies m
JOIN
Directors d
ON
d.Id = m.DirectorId
JOIN
GenresMovies gm
ON
m.Id = gm.MovieId
JOIN
Genres g
ON
gm.GenreId = g.Id
WHERE LEN(m.Name) > 10 AND m.Name LIKE '%t'




SELECT m.Id, m.Name, d.Name DirectorName, g.Name GenreName, a.Name ActorName, m.ImdbScore FROM Movies m
FULL JOIN
Directors d
ON
d.Id = m.DirectorId
FULL JOIN
GenresMovies gm
ON
m.Id = gm.MovieId
FULL JOIN
Genres g
ON
gm.GenreId = g.Id
FULL JOIN
MoviesActors ma
ON
m.Id = ma.MovieId
FULL JOIN
Actors a
ON
ma.ActorId = a.Id
WHERE m.ImdbScore > (SELECT AVG(ImdbScore) FROM Movies)
