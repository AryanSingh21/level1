-- . Print the names of professors who work in departments that have fewer than 50 PhD students.
SELECT pname FROM prof WHERE dname = ANY(
SELECT dname FROM dept WHERE numphds < 50);

-- Print the names of the students with the lowest GPA.
SELECT sname FROM student WHERE gpa = (
SELECT MIN(gpa) FROM student);

--For each Computer Sciences class, print the class number, section number, and the average gpa of the students enrolled in the class section.
SELECT enroll.cno, section.sectno, AVG(student.gpa) as average_gpa
FROM enroll 
JOIN section ON enroll.dname = section.dname AND enroll.cno = section.cno
JOIN student ON enroll.sid = student.sid
WHERE enroll.dname = 'Computer Sciences'
GROUP BY enroll.cno, section.sectno;

-- Print the names and section numbers of all sections with more than six students enrolled in them.
SELECT course.cname, course.cno, enroll.sectno, COUNT (*)
FROM course
JOIN enroll on enroll.cno = course.cno
GROUP BY cname, course.cno, sectno
HAVING COUNT(*)>6;

-- Print the name(s) and sid(s) of the student(s) enrolled in the most sections.
SELECT sname,sid 
FROM student 
WHERE sid IN (SELECT sid 
FROM enroll GROUP BY sid 
HAVING COUNT(*) >= ALL ( 
SELECT COUNT(*) FROM enroll GROUP BY sid ));

-- Print the names of departments that have one or more majors who are under 18 years old.
SELECT dname 
FROM major 
JOIN student ON major.sid = student.sid 
WHERE age < 18;

--Print the names and majors of students who are taking one of the College Geometry courses.
SELECT major.dname , student.sname 
FROM student 
JOIN enroll ON enroll.sid = student.sid
JOIN major ON major.sid = student.sid 
WHERE enroll.cno = 462 OR enroll.cno = 461;

-- For those departments that have no major taking a College Geometry course print the department name and the number of PhD students in the department.
SELECT dept.dname, numphds
FROM dept
JOIN course ON dept.dname = course.dname
WHERE course.cname NOT LIKE '%College Geometry%'
GROUP BY dept.dname;

-- Print the names of students who are taking both a Computer Sciences course and a Mathematics course
SELECT sname FROM student JOIN major ON major.sid = student.sid WHERE major.dname = 'Computer Sciences'
INTERSECT
SELECT sname FROM student JOIN major ON major.sid = student.sid WHERE major.dname = 'Mathematics';

-- Print the age difference between the oldest and the youngest Computer Sciences major.
SELECT (MAX(age) - MIN(age)) AS diff 
FROM student 
JOIN major ON major.sid = student.sid 
WHERE dname = 'Computer Sciences';

-- For each department that has one or more majors with a GPA under 1.0, print the name of the department and the average GPA of its majors.
SELECT dname, ROUND(AVG(gpa) , 2) 
FROM student 
JOIN major ON major.sid = student.sid 
GROUP BY dname 
HAVING MIN(gpa) < 1.0;

-- Print the ids, names and GPAs of the students who are currently taking all the Civil Engineering courses.
SELECT sname , student.sid , gpa FROM student JOIN enroll
ON enroll.sid = student.sid
WHERE dname = 'Civil Engineering'
GROUP BY student.sid ,sname , gpa
HAVING COUNT(*) = (SELECT COUNT(DISTINCT cno)
FROM enroll WHERE dname = 'Civil Engineering');




