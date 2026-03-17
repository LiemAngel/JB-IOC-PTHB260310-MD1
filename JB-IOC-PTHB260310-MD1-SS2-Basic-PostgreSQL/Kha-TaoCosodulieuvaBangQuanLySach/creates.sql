CREATE SCHEMA library;
DROP TABLE IF EXISTS library.books;
CREATE table library.books (
	book_id serial PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	author VARCHAR(50) NOT NULL,
	published_year int,
	price numeric(10,2)
);