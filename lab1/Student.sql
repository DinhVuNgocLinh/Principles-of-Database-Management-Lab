CREATE DATABASE Student;
CREATE TABLE Students(
	Sid char (10),
	Sname nvarchar (30),
	Dob date,
	Address nvarchar (50),
	ID_char char (12),
	PRIMARY KEY (Sid)
);
CREATE TABLE Course(
	Cid char (12),
	Cname nvarchar (30),
	Credit int,
	PRIMARY KEY (Cid)
);
CREATE TABLE Enrolled(
	Sid char (10),
	Cid char (12),
	Day date,
	PRIMARY KEY(Sid,Cid,Day)
);
INSERT INTO Students VALUES
('10153', 'Ramesh', '2001/02/25', 'Delhi', 'ITIU21984'),
('90232', 'Khilan', '2002/11/12', 'Mumbai', 'ITIU20084'),
('40423', 'Muffy', '2000/07/12', 'Hanoi', 'DSIU20154'),
('82890', 'Chaitali', '2003/08/24', 'Saigon', 'CSIU20024'),
('25902', 'Kaushik', '2001/03/28', 'Bienhoa', 'DSIU20355');
INSERT INTO Course VALUES
('98357', 'CAL', 4),
('73415', 'PDM', 3),
('97325', 'DSA', 4),
('23857', 'LA', 2),
('53167', 'DA', 2);
INSERT INTO Enrolled VALUES
('40423', '73415', '2014/03/24'),
('25902', '23857', '2015/10/10'),
('90232', '98357', '2012/05/28'),
('82890', '97325', '2016/07/23'),
('10153', '53167', '2014/01/13');
SELECT * FROM Students;
SELECT * FROM Course;
SELECT * FROM Enrolled;