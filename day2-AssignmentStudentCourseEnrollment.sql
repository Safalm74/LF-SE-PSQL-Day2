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

Insert queries:

-- Insert into Grades table
INSERT INTO Grades (grade_id, grade_name) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

-- Insert into Courses table
INSERT INTO Courses (course_id, course_name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

-- Insert into Students table
INSERT INTO Students (student_id, student_name, student_age, student_grade_id) VALUES
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
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
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
select s
	from enrollments e , courses c,students s 
	where c.course_id =e.course_id 
	 and s.student_id =e.student_id 
	and c.course_name ='Math';--to get only math course data

--Question:2 List all courses taken by students named Bob.
select c
	from enrollments e,  courses c,students s
	where c.course_id =e.course_id 
	and s.student_id =e.student_id 
	and s.student_name ='Bob'; -- to get only sob student data

--Question:3 Find the names of students who are enrolled in more than one course.
select 
		s.student_name as StudentName, 
		count(distinct c.course_id) as TotalCourse
	from enrollments e ,courses c ,students s 
	where c.course_id =e.course_id 
	and s.student_id =e.student_id 
	group by s.student_name
	having count(c.course_id)>1; --to get courses with count greater than 1  

--Question:4 List all students who are in Grade A (grade_id = 1).
select s 
	from students s ,grades g 
	where g.grade_id =s.student_grade_id
	and g.grade_name ='A'; -- to get grades with only A

--Question:5 Find the number of students enrolled in each course.
select 
		c.course_name , 
		count(distinct s.student_id) as TotalStudents --counting students in each group of courses
	from enrollments e ,courses c,students s 
	where c.course_id =e.course_id --to get course
	and s.student_id =e.student_id --to get student
	group by c.course_name ; --to group acording to courses name

--Question:6 Retrieve the course with the highest number of enrollments.
select 
	c.course_name as course_with_the_highest_number_of_enrollments
	from enrollments e 
	join courses c on c.course_id =e.course_id --to get courses
	group by c.course_name  --togroup according to coursename
	having count(e.enrollment_id)=(-- counting enrollments in each grouped course then getting only with count equal to max enrollments
		select --here we get max enrollment count from the subquery
		max (courseCount)
		from (
			select -- here we get enrollment count for each grouped course
			count(*) as courseCount
			from courses c 
			join enrollments e 
			on e.course_id =c.course_id 
			group by c.course_name
		)
	);

--Question:7 List students who are enrolled in all available courses
select count(*) from courses c ;--total courses
select 
		s
	from enrollments e ,courses c,students s
	where c.course_id =e.course_id  
	and s.student_id =e.student_id 
	group by s --grouped by students
	having count(distinct c.course_id)=(select count(distinct c.course_id) from courses c);--to get data count of course in 
																		--each grouped student equal to count of distint course
	
--Question:8 Find students who are not enrolled in any courses.
/*
 * removing students that is referenced in enrollements:
 * first getting all students
 * then subtracting with student data that is output of enrollment join student*/
select s from students s -- getting all students
except  
select --geting student that is referenced in enrollment table
		s
	from enrollments e ,students s 
	where s.student_id =e.student_id;


--Question:9 Retrieve the average age of students enrolled in the Science course.
select 
		avg(s.student_age) as average_age_of_students_enrolled_in_the_Science_course
	from enrollments e ,courses c, students s
	where c.course_id =e.course_id 
	and s.student_id =e.student_id 
	and c.course_name ='Science' --getting only data with course science
	group by c.course_name;-- grouping by course

--Question:10 Find the grade of students enrolled in the History course.
select 
		s.student_id  as StudentId,
		s.student_name as StudentName,
		c.course_name as course_name ,
		g.grade_name as Grade
	from enrollments e,courses c,students s,grades g 
	where c.course_id =e.course_id   
	and s.student_id =e.student_id
	and g.grade_id =s.student_grade_id --to get grade
	and c.course_name ='History'; -- course with only history
	


