SELECT datname FROM pg_database;
SELECT schema_name 
FROM information_schema.schemata;
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'books' 
  AND table_schema = 'library';
SELECT * FROM library.books