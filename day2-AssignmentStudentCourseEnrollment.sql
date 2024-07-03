--Day 2: Assignment (Student Table)
-- Students table
CREATE TABLE Students (
	student_id INT PRIMARY KEY,
	student_name VARCHAR(50),
	student_age INT,
	student_grade_id INT,
	FOREIGN KEY (student_grade_id) REFERENCES Grades(grade_id)
);

-- Grades table
CREATE TABLE Grades (
	grade_id INT PRIMARY KEY,
	grade_name VARCHAR(10)
);

-- Courses table
CREATE TABLE Courses (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(50)
);

-- Enrollments table
CREATE TABLE Enrollments (
	enrollment_id INT PRIMARY KEY,
	student_id INT,
	course_id INT,
	enrollment_date DATE,
	FOREIGN KEY (student_id) REFERENCES Students(student_id),
	FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

Insert
	queries: -- Insert into Grades table
INSERT INTO
	Grades (grade_id, grade_name)
VALUES
	(1, 'A'),
	(2, 'B'),
	(3, 'C');

-- Insert into Courses table
INSERT INTO
	Courses (course_id, course_name)
VALUES
	(101, 'Math'),
	(102, 'Science'),
	(103, 'History');

-- Insert into Students table
INSERT INTO
	Students (
		student_id,
		student_name,
		student_age,
		student_grade_id
	)
VALUES
	(1, 'Alice', 17, 1),
	(2, 'Bob', 16, 2),
	(3, 'Charlie', 18, 1),
	(4, 'David', 16, 2),
	(5, 'Eve', 17, 1),
	(6, 'Frank', 18, 3),
	(7, 'Grace', 17, 2),
	(8, 'Henry', 16, 1),
	(9, 'Ivy', 18, 2),
	(10, 'Jack', 17, 3);

-- Insert into Enrollments table
INSERT INTO
	Enrollments (
		enrollment_id,
		student_id,
		course_id,
		enrollment_date
	)
VALUES
	(1, 1, 101, '2023-09-01'),
	(2, 1, 102, '2023-09-01'),
	(3, 2, 102, '2023-09-01'),
	(4, 3, 101, '2023-09-01'),
	(5, 3, 103, '2023-09-01'),
	(6, 4, 101, '2023-09-01'),
	(7, 4, 102, '2023-09-01'),
	(8, 5, 102, '2023-09-01'),
	(9, 6, 101, '2023-09-01'),
	(10, 7, 103, '2023-09-01');

--Questions
--Question:1 Find all students enrolled in the Math course.
select
	*
from
	students s
where
	s.student_id in (
		select
			e.student_id
		from
			enrollments e
		where
			e.course_id =(
				select
					c.course_id
				from
					courses c
				where
					c.course_name = 'Math'--to get only math course data
			)
	);

--Question:2 List all courses taken by students named Bob.
select
	c
from
	courses c
where
	c.course_id =(
		select
			e.course_id
		from
			enrollments e
		where
			e.student_id =(
				select
					s.student_id
				from
					students s
				where
					student_name = 'Bob'-- to get only Bob student data
			)
	);

--Question:3 Find the names of students who are enrolled in more than one course.
select
	*
from
	students s
where
	s.student_id in (
		select
			e.student_id
		from
			enrollments e
		group by
			e.student_id
		having
			count(e.student_id) > 1 --to get courses with count greater than 1 
	);
 
--Question:4 List all students who are in Grade A (grade_id = 1).
select
	*
from
	students s
where
	s.student_grade_id in (
		select
			grade_id
		from
			grades g
		where
			grade_name = 'A' -- to get grades with only A
	);

--Question:5 Find the number of students enrolled in each course.
select
	c.course_name,
	(
		select
			count(e.student_id)
		from
			enrollments e
		where
			e.course_id = c.course_id
	) --to get student id that has course id with current course
from
	courses c;

--Question:6 Retrieve the course with the highest number of enrollments.		
select
	c.course_name
from
	courses c
where
	(
		select
			count(e.student_id)
		from
			enrollments e
		where
			e.course_id = c.course_id
	) =(
		select
			--here we get max enrollment count from the subquery
			max (courseCount)
		from
			(
				select
					-- here we get enrollment count for each grouped course
					count(*) as courseCount
				from
					courses c,
					enrollments e
				where
					e.course_id = c.course_id
				group by
					c.course_name
			)
	);

--Question:7 List students who are enrolled in all available courses
select
	*
from
	students s
where
	(
		select
			count(*)
		from
			courses c
	) = (
		select
			count(student_id)
		from
			enrollments e
		where
			e.student_id = s.student_id
	);

--Question:8 Find students who are not enrolled in any courses.
select
	*
from
	students s
where
	(
		select
			count(student_id)
		from
			enrollments e
		where
			e.student_id = s.student_id
	) = 0;

--Question:9 Retrieve the average age of students enrolled in the Science course.
select
	avg(student_age)
from
	students s
where
	student_id in (
		select
			e.student_id
		from
			enrollments e
		where
			e.course_id = (
				select
					c.course_id
				from
					courses c
				where
					c.course_name = 'Science'
			)
	);

--Question:10 Find the grade of students enrolled in the History course.
select
	s.student_name,
	(
		select
			grade_name
		from
			grades g
		where
			g.grade_id = s.student_grade_id
	)
from
	students s
where
	s.student_id in (
		select
			e.student_id
		from
			enrollments e
		where
			e.course_id =(
				select
					c.course_id
				from
					courses c
				where
					c.course_name = 'History'
			)
	);