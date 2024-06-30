--1
CREATE DATABASE Employee
USE Employee

CREATE TABLE employee(
employee_name nvarchar (50),
street nvarchar (20),
city nvarchar (10),
PRIMARY KEY (employee_name)
);

CREATE TABLE company(
company_name nvarchar (50),
city nvarchar (10),
PRIMARY KEY (company_name)
);

CREATE TABLE works(
employee_name nvarchar (50),
company_name nvarchar (50),
salary int,
PRIMARY KEY (employee_name),
FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
FOREIGN KEY (company_name) REFERENCES company(company_name)
);

CREATE TABLE manages(
employee_name nvarchar (50),
manager_name nvarchar (50),
PRIMARY KEY (employee_name),
FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
FOREIGN KEY (manager_name) REFERENCES employee(employee_name)
);
--2
INSERT INTO employee VALUES
('Linh','CMT8','BH'),
('Binh','NGT','BH'),
('Bunny','Q1','HCM'),
('Tuyet','Q1','HCM'),
('Hang','Q1','HCM'),
('Loan','Q1','HCM'),
('My','PNT','TD');

INSERT INTO company VALUES
('First Bank Corporation','BH'),
('Second Bank Corporation','HCM'),
('Third Bank Corporation','BH'),
('Fourth Bank Corporation','HCM'),
('Small Bank Corporation','TD');

INSERT INTO works VALUES
('Binh','First Bank Corporation','15000'),
('Linh','Second Bank Corporation','10000'),
('Bunny','Third Bank Corporation','30000'),
('Hang','Small Bank Corporation','12000'),
('Tuyet','Fourth Bank Corporation','20000'),
('Loan','First Bank Corporation','29000'),
('My','First Bank Corporation','19000');

INSERT INTO manages VALUES
('Binh','Tuyet'),
('Linh','Tuyet'),
('My','Tuyet'),
('Bunny','Tuyet'),
('Tuyet','Loan'),
('Hang','Tuyet');
--3
--a
SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';
--b
SELECT employee.employee_name , city
FROM employee,works
WHERE 
employee.employee_name = works.employee_name AND
company_name = 'First Bank Corporation';
--c
SELECT employee.employee_name, street, city
FROM employee, works
WHERE
employee.employee_name = works.employee_name AND
company_name = 'First Bank Corporation' AND
salary > 10000;
--d
SELECT employee.employee_name
FROM employee, company, works
WHERE
employee.city = company.city AND
employee.employee_name = works.employee_name AND
company.company_name = works.company_name;
--e
SELECT e1.employee_name
FROM employee e1, manages m, employee e2
WHERE 
e1.employee_name = m.employee_name AND
m.manager_name = e2.employee_name AND
e1.city = e2.city AND
e1.street = e2.street;
--f
SELECT employee_name 
FROM employee 
WHERE employee_name NOT IN (SELECT employee_name
							FROM works
							WHERE company_name = 'First Bank Corporation');
--g
SELECT employee.employee_name
FROM employee, works
WHERE employee.employee_name = works.employee_name
AND salary > (SELECT MAX(salary) 
					FROM works
					WHERE company_name = 'Small Bank Corporation');
--h
SELECT c1.company_name
FROM company c1
WHERE EXISTS (
    SELECT c2.city
    FROM company c2
    WHERE c2.company_name = 'Small Bank Corporation'
    INTERSECT
    SELECT c3.city
    FROM company c3
    WHERE c3.company_name = c1.company_name
);
--i
SELECT e1.employee_name
FROM employee e1, works w1
WHERE e1.employee_name = w1.employee_name
AND w1.salary > (SELECT AVG (DISTINCT w2.salary)
				 FROM works w2
				 WHERE w1.company_name = w2.company_name);
--j
SELECT TOP 1 company_name
FROM works
GROUP BY company_name
ORDER BY COUNT(employee_name) DESC;

--k
SELECT TOP 1 company_name
FROM works
GROUP BY company_name
ORDER BY SUM(salary) ASC;

--l
SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) > (SELECT AVG(salary)
						FROM works
						WHERE company_name = 'First Bank Corporation')