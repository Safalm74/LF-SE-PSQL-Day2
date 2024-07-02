--creating schema for salary management
create schema salary_management;

--creating employee table
create table if not exists
	salary_management.Employees(
	emp_id int primary key,
	emp_name varchar(50) not null,
	Email varchar(50) unique,
	salary decimal check (salary>25000),
	department varchar(50) default 'unknown',
	created_at timestamp default current_timestamp
	);

--creating locations table
create table if not exists
	salary_management.locations(
	loaction_id serial primary key,
	emp_id int,
	city varchar(50),
	state varchar(50),
	foreign key (emp_id)
		references salary_management.Employees(emp_id)
	);

--Exercise Questions
--Question 1: Insert an employee record (at least 10 record in each table) and at least one should have default department ‘UNKNOWN’
--inserting 9 data
insert into
	salary_management.employees 
	(emp_id ,emp_name ,email ,salary ,department)
	values
	(1,'safal manandhar','safalm74@gmail.com',35000,'computer'),
	(2,'ganga manandhar','ganga@gmail.com',50000,'sales'),
	(3,'nirmala manandhar','nirmala@gmail.com',45000,'account'),
	(4,'nirusha manandhar','nirusha@gmail.com',42000,'civil'),
	(5,'kriti manandhar','kriti@gmail.com',260000,'computer'),
	(6,'subina nhuchhe','subina@gmail.com',206000,'architecture'),
	(7,'jayaram pandey','jayaram@gmail.com',230000,'sales'),
	(8,'jenish shrestha','jenish@34gmail.com',200100,'staff'),
	(9,'jayan ghimire','jayan@gm31ail.com',200030,'sales');

--inserting data with unknown department
insert into
	salary_management.employees 
	(emp_id ,emp_name ,email ,salary)
	values
	(11,'jayan pandey','safalm74@wgm31ail.com',200030);

--checking inserted data in employe table
select * from salary_management.employees e ;

--inserting into locations table
--
insert  into 
	salary_management.locations 
		(emp_id,city,state)
	values
		(1,'bhaktapur','bagmati'),
		(2,'kathmandu','bagmati'),
		(3,'lalitpur','bagmati'),
		(4,'kavre','bagmati'),
		(5,'bhaktapur','bagmati'),
		(6,'kathmandu','bagmati'),
		(7,'lalitpur','bagmati'),
		(8,'kavre','bagmati'),
		(9,'bhaktapur','bagmati'),
		(11,'lalitpur','bagmati');

-- checking inserted data in locations table
select * from salary_management.locations l ;
	
--Question 2: Write an SQL query to retrieve employees whose salary is between 30000 and 50000.
select * from salary_management.employees e  where e.salary between 30000 and 50000;

--Question 3: Write an SQL query to increase the salary of all employees by 5000 units.
update salary_management.employees 
	set salary =salary +5000;
--checking updated data
select * from salary_management.employees e;

--Question 4: Retrieve employees who work in the 'Sales' department.
select * 
	from salary_management.employees e 
	where  department ='sales';

--Question 5: Retrieve employees whose email starts with 'j'.
select * 
	from salary_management.employees e 
	where e.email like 'j%';


--Question 6: Calculate the average , minimum and maximum salary for each department.
select  
	e.department as department,
	avg(salary) as Average_Salary,
	min(salary) as Minimum_Salary,
	max(salary) as Maximum_salary 
	from salary_management.employees e 
	group by e.department ;

-- Question7: Calculate Total Number of Locations per City
select 
	l.city ,
	count(l.loaction_id) 
	from salary_management.locations l 
	group by l.city;




















