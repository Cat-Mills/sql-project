--SETUP (Create a database to build our tables)

createdb project-tracker
psql project-tracker

--Step 1a (created table with github, first_name, and last_name as columns)

CREATE TABLE students(github VARCHAR(30), first_name VARCHAR(30),
last_name VARCHAR(30));

--Step 1b (inserted student info twice)

INSERT INTO students VALUES ('jhacks', 'Jane', 'Hacker');

--Step 1c (deleted duplicate created in Step 1b)

DROP TABLE students;

--Step 1d (modified previous CREATE TABLE command so that the github column is the primary key.)

CREATE TABLE students(github VARCHAR(30) PRIMARY KEY, first_name VARCHAR(30), last_name VARCHAR(30));

--Step 1e (re-ran the same INSERT statements to add Jane and Sarah to the students table.  Trying to add the same student twice shouldn't work.)

INSERT INTO students VALUES ('jhacks', 'Jane', 'Hacker');
INSERT INTO students VALUES ('sdevelops', 'Sarah', 'Developer');

-- Step 2a Show only the last name of all students

SELECT last_name FROM students;

-- Step 2b Show only the GitHub username and first name of all students

SELECT github, first_name FROM students;

-- Step 2c Show all columns for students whose first name is Sarah

SELECT * FROM students WHERE first_name = 'Sarah';

-- Step 2d Show all columns for students whose GitHub username is sdevelops

SELECT * FROM students WHERE github='sdevelops';

-- Step 2e Show only the first name and last name of students whose GitHub username is jhacks

SELECT first_name, last_name FROM students WHERE github='jhacks';
--Step 3 Create a projects table in the database.  The title column should be the primary key. (We won’t have two projects with the same title!)  The description column should use the TEXT data type (intended for strings that could be very long, like a long description, or even the contents of an entire book!).  The max_grade column should use the INTEGER data type.  Lastly, populate the table with 5 rows of info.

CREATE TABLE projects(title VARCHAR(30) PRIMARY KEY, description TEXT, max_grade INTEGER);

INSERT INTO projects VALUES('Markov', 'Tweets generated from Markov chains', 50);

INSERT INTO projects VALUES('Blockly', 'Programmatic Logic Puzzle Game', 100);

INSERT INTO projects VALUES('Dashly', 'Racing Game', 75);

INSERT INTO projects VALUES('Puzzle', 'Puzzle Game', 30);

INSERT INTO projects VALUES('DB', 'Database', 1000);

--Construct the CREATE TABLE statement for grades

CREATE TABLE grades(
    id SERIAL PRIMARY KEY,
    student_github VARCHAR(30) REFERENCES students,
    project_title TEXT REFERENCES projects,
    grade INTEGER
);

--Insert grade records

INSERT INTO grades(student_github,project_title,grade)
VALUES('jhacks','Markov',10);

INSERT INTO grades(student_github,project_title,grade)
VALUES('jhacks','Blockly',2);

INSERT INTO grades(student_github,project_title,grade)
VALUES('sdevelops','Markov',50);

INSERT INTO grades(student_github,project_title,grade)
VALUES('sdevelops','Blockly',100);

--Joining the students and grades tables
SELECT *
FROM students
JOIN grades
ON (students.github = grades.student_github);
--? The ON statement tells the query what fields will match up. We’re saying: “Hey query, if the github fields match, you can put the rows from the two tables together for our result.”

--Limit the columns in query
SELECT students.first_name, students.last_name, grades.project_title,grades.grade
FROM students
JOIN grades
ON (students.github = grades.student_github);

--Add the max_grade column
SELECT *
FROM students s
JOIN grades g ON (s.github = g.student_github)
JOIN projects p ON (g.project_title = p.title);

--Filter for Jane's info
SELECT *
FROM students s
JOIN grades g ON (s.github = g.student_github)
JOIN projects p ON (g.project_title = p.title)
WHERE github = 'jhacks';

--final query
SELECT s.first_name, s.last_name, g.project_title, g.grade, p.max_grade
FROM students s
JOIN grades g
ON (s.github = g.student_github)
JOIN projects p 
ON (g.project_title = p.title);