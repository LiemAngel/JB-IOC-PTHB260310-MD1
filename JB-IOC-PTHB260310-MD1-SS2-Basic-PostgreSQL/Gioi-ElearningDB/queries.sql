CREATE SCHEMA IF NOT EXISTS elearning;

-- 1. Bảng Students
CREATE TABLE elearning.Students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email TEXT NOT NULL UNIQUE 
);

-- 2. Bảng Instructors
CREATE TABLE elearning.Instructors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Bảng Courses
CREATE TABLE elearning.Courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT NOT NULL,
    CONSTRAINT fk_instructor
        FOREIGN KEY(instructor_id)
        REFERENCES elearning.Instructors(id)
);

-- 4. Bảng Enrollments
CREATE TABLE elearning.Enrollments (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES elearning.Students(id),
    CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES elearning.Courses(id)
);

-- 5. Bảng Assignments (Đã thêm dấu phẩy thiếu)
CREATE TABLE elearning.Assignments (
    id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    due_date TIMESTAMP NOT NULL,
    CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES elearning.Courses(id)
);

-- 6. Bảng Submissions 
CREATE TABLE elearning.Submissions (
    id SERIAL PRIMARY KEY,
    submission_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    grade NUMERIC(2, 2) CHECK (grade >= 0 AND grade <= 10), -- Ràng buộc điểm từ 0-100
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES elearning.Students(id),
    CONSTRAINT fk_assignment FOREIGN KEY(assignment_id) REFERENCES elearning.Assignments(id)
);