--creating schema
create schema bookStore;

--creating tables:
--authors
create table if not exists
	bookStore.Authors(
		author_id serial primary key,
		author_name varchar(50) not null,
		birth_date timestamp,
		nationality varchar(20)
	);
--Publishers 
create table if not exists
	bookStore.Publishers(
		publisher_id serial primary key,
		publisher_name varchar(50) unique,
		country varchar(20)
	);

--Book 
create table if not exists
	bookStore.Book(
		book_id serial primary key,
		title varchar(50) not null,
		genre varchar(20) default 'unknown',
		publisher_id int,
		publication_year timestamp,
		foreign key (publisher_id)
			references bookStore.Publishers(publisher_id)
	);
--Customers 
create table if not exists
	bookStore.Customers(
		customer_id serial primary key,
		customer_name varchar(50),
		email varchar(50) unique,
		address varchar(50)
	);
--Orders 
create table if not exists
	bookStore.Orders(
		order_id serial primary key,
		order_date timestamp,
		customer_id int,
		total_amount decimal,
		foreign key (customer_id)
			references bookStore.Customers(customer_id)
	);
--book authors
create table if not exists
	bookStore.Book_Authors(
		book_id int,
		author_id int,
		foreign key (book_id)
			references bookStore.Book(book_id),
		foreign key (author_id)
			references bookStore.Authors(author_id)
	);
--order items
create table if not exists
	bookStore.Order_Items(
		book_id int,
		order_id int,
		foreign key (book_id)
			references bookStore.Book(book_id),
		foreign key (order_id)
			references bookStore.Orders(order_id)
	);
	

--inserting data
--Authors
insert into 
	bookstore.authors 
		(author_name, birth_date, nationality)
	values
		('Alice','2022-01-01','Nepali'),
		('Bekey','2022-02-21','Indian'),
		('Cristina','2022-11-11','Japnese');
--Publishers
insert into 
	bookstore.Publishers 
		(publisher_name ,country)
	values
		('A','Nepal'),
		('B','India'),
		('C','Japan');
--Customers
insert into 
	bookstore.Customers 
		(customer_name,email,address)
	values
		('c','C@gmail.com','Bhaktapur'),
		('d','d@gmail.com','Kathmandu'),
		('e','e@gmail.com','Lalitpur');
	
--book
insert into 
	bookstore.book 
		(title,genre,publisher_id,publication_year)
	values
		('Book Title A','genre A',1,'2022-02-02'),
		('Book Title AB','genre A',1,'2022-02-02'),
		('Book Title B','genre A',2,'2022-02-02'),
		('Book Title C','genre A',3,'2022-02-02'),
		('Book Title D','genre A',1,'2022-02-02'),
		('Book Title E','genre A',2,'2022-02-02'),
		('Book Title F','genre A',3,'2022-02-02');

--book authors
insert into 
	bookstore.book_authors 
		(book_id,author_id)
	values
		(1,3),
		(2,2),
		(3,1),
		(4,1),
		(5,2),
		(6,3),
		(7,3);

--orders
insert into 
	bookstore.orders 
		(order_date ,customer_id ,total_amount)
	values
		('2022-03-03',1,1000),
		('2022-03-03',1,2000),
		('2022-03-03',1,3000),
		('2022-03-03',2,3000),
		('2022-03-03',3,2000),
		('2022-03-03',2,1000),
		('2022-03-03',1,2000),
		('2022-03-03',2,3000),
		('2022-03-03',2,4000),
		('2022-03-03',2,5000),
		('2022-03-03',3,4000),
		('2022-03-03',1,3000);

--order items
insert into 
	bookstore.order_items 
		(book_id ,order_id)
	values
		(1,1),
		(1,2),
		(2,3),
		(3,4),
		(4,5),
		(5,6),
		(6,7),
		(3,8),
		(1,9),
		(3,10),
		(1,11),
		(1,12);
		
	

