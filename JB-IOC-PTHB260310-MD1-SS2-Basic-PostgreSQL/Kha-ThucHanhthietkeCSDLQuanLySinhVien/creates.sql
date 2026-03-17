CREATE SCHEMA university
CREATE TABLE university.Students (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	email VARCHAR(50) UNIQUE NOT NULL
)
CREATE TABLE university.Courses (
	id SERIAL PRIMARY KEY,
	course_name VARCHAR(100) NOT NULL,
	credits int
	
)
CREATE TABLE university.Enrollments (
	id SERIAL PRIMARY KEY,
	student_id INT NOT NULL, 
    course_id INT NOT NULL,
	CONSTRAINT fk_student 
        FOREIGN KEY(student_id) 
        REFERENCES university.Students(id) 
        ON DELETE CASCADE,
        
    CONSTRAINT fk_course 
        FOREIGN KEY(course_id) 
        REFERENCES university.Courses(id) 
        ON DELETE CASCADE
)