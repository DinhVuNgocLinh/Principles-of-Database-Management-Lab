-- create schemas
CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

-- create tables
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

--1. Finds the top 10 most expensive products follow list_price descending order. 
select top 10 product_name, list_price
from production.products
order by list_price;

--2. Finds the customer id and the ordered year (year(order_date)) of the customers with the customer id one and two follow customer_id order 
select customer_id, year(order_date) as ordered_year
from sales.orders
where customer_id in (1, 2)
order by customer_id;

--3. Finds the number of orders placed by the customer by year 
select customer_id, year(order_date) as ordered_year, count(customer_id) as number_of_orders
from sales.orders
group by customer_id, year(order_date);

--4. Finds the number of customers in every city
select city, count(customer_id)
from sales.customers
group by city;

--5. Finds the number of customers by state and city follow City and State order
select state, city, count(customer_id) as number_of_customers
from sales.customers
group by city, state
order by city, state;

--6. Finds the minimum and maximum list prices of all products with the model 2018 by brand follow brand_name order
select min(list_price) as min_price, max(list_price) as max_price, (select brand_name
										  from production.brands b
										  where b.brand_id = p.brand_id) as brand_name

from production.products p
where model_year = 2018
group by brand_id
order by brand_name;

-- 7. Finds the average list price by brand for all products with the model year 2018 follow brand_name order
select avg(list_price) as average_price, (select brand_name 
						 from production.brands b 
						 where b.brand_id = p.brand_id) as brand_name
from production.products p
where model_year = 2018
group by brand_id
order by brand_name;

--8. Finds the customers who placed at least two orders per year follow Customer_id order 
select customer_id, year(order_date), count(order_id) as number_of_orders
from sales.orders
group by customer_id, year(order_date)
having count(order_id) >= 2
order by customer_id;

--9. Finds the sales orders whose net values are greater than 20,000
SELECT o.order_id, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as net_value
FROM sales.orders o
JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount)) > 20000;

--10. Finds product categories whose average list prices are between 500 and 1,000 
SELECT c.category_name, AVG(p.list_price) as avg_list_price
FROM production.categories c
JOIN production.products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.list_price) BETWEEN 500 AND 1000;

--11. Find the sales orders of the customers (order_id, order_date, customer_id) who locate in New York follow order_date descending order.
SELECT o.order_id, o.order_date, o.customer_id
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
WHERE c.city = 'New York'
ORDER BY o.order_date DESC;

--12. Finds the names of all mountain bikes and road bikes products that the Bike Stores sell (used subquery) 
SELECT p.product_name
FROM production.products p
WHERE p.category_id IN (
    SELECT c.category_id
    FROM production.categories c
    WHERE c.category_name IN ('Mountain Bikes', 'Road Bikes')
);

--13. Finds the products whose list prices are greater than or equal to the maximum list price of any product brand 
SELECT p.product_name, p.list_price
FROM production.products p
WHERE p.list_price >= ALL (
    SELECT MAX(p2.list_price)
    FROM production.products p2
    GROUP BY p2.brand_id
);

--14. Finds the products whose list price is greater than or equal to the maximum list price returned by the subquery 
SELECT p.product_name, p.list_price
FROM production.products p
WHERE p.list_price >= (
    SELECT MAX(p2.list_price)
    FROM production.products p2
);

--15. Finds the customers who bought products in 2017 (used subquery) follow by first_name, last_name order
SELECT DISTINCT c.first_name, c.last_name
FROM sales.customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM sales.orders o
    WHERE YEAR(o.order_date) = 2017
)
ORDER BY c.first_name, c.last_name;

--16. Finds the customers who did not buy any products in 2017 
SELECT c.first_name, c.last_name
FROM sales.customers c
WHERE c.customer_id NOT IN (
    SELECT o.customer_id
    FROM sales.orders o
    WHERE YEAR(o.order_date) = 2017
)
ORDER BY c.first_name, c.last_name;

--17. Finds the sales amount grouped by brand and category 
SELECT b.brand_name, c.category_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount
FROM production.brands b
JOIN production.products p ON b.brand_id = p.brand_id
JOIN production.categories c ON p.category_id = c.category_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY b.brand_name, c.category_name;

--18. Finds the sales amount by brand. It defines a grouping set (brand) 
SELECT b.brand_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount
FROM production.brands b
JOIN production.products p ON b.brand_id = p.brand_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY b.brand_name;

--19. Finds the sales amount by category. It defines a grouping set (category)
SELECT c.category_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount
FROM production.categories c
JOIN production.products p ON c.category_id = p.category_id
JOIN sales.order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

--20. Sorts the customers by the city in descending order and the sort the sorted result set by the first name in ascending order 
SELECT c.first_name, c.last_name, c.city
FROM sales.customers c
ORDER BY c.city DESC, c.first_name ASC;

--21. Finds a customer list sorted by the length of the first name 
SELECT c.first_name, c.last_name
FROM sales.customers c
ORDER BY LEN(c.first_name);
