Create table courses (
	course_id varchar(10)primary key,
	course_name varchar(250),
	course_unit int,
	department varchar(25));
	
	Create Table department (
		department_id varchar(10),
		department_name varchar(250));
		
		Create Table scores (
			student_id int primary key,
			student_name varchar(250),
			course_id varchar(10),
			scores int,
			Foreign key (course_id) References courses(course_id));
			

select * from courses;
select * from department;
select * from scores;

-- . Categorize Student Scores: How would you categorize student scores into the following?
-- • 90 and above: Excellent
-- • 80 to 89: Very Good
-- • 70 to 79: Good
-- • 60 to 69: Fair
-- • Below 60: Fail

select student_name, scores,
case
	when scores >=90 then 'Excellent'
	when scores between 80 and 89 then 'very good'
	when scores between 70 and 79 then 'Good'
	when "scores" between 60 and 69 then 'Fair'
	else 'Fail'
	end as score_category
from scores;

-- . Above Average Scorers: Which students have scored higher than the average score of all students?
SELECT  student_name, scores
from scores
where scores > (select avg(scores) from scores);

-- . Missing Scores: If a student has a missing score for a course, how would you consider it as 0 and display the student's name,
-- course, and the adjusted score?

select student_name, course_id, 
coalesce(scores,0) As "Adjusted_Score"
from scores;
where scores = 0;

-- . Textual Score Representation: How can you convert the numerical scores of students into a textual representation and
-- display the student's name alongside this textual score?
select student_name, CAST(scores AS varchar(10)) AS "Textual Score"
from scores

select student_name, course_id, scores
from scores;

-- . Student Achievement Levels: Can you categorize students based on their scores as:
-- • 90 and Above 90: Excellent Student
-- • 80 to 89: Very Good Student
-- • 70 to 79:  Good Student
-- . 60 to 69: fair
-- • Below 60: fail
select student_name, scores,
	case
		when scores >=90 then 'Excellent'
		when scores between 80 and 89 then 'Very Good'
		when scores between 70 and 79 then 'Good'
		when scores between 60 and 69 then 'Fair'
		else 'Fail'
		end as Achievement_Level
		from scores;


-- . Top Scoring Course: Which course has the highest average score among all courses?
select c.course_id, c.course_name, round(avg(scores),2) as "Average_Score"
from courses c
join scores s
on c.course_id = s.course_id
group by c.course_id, c.course_name
order by avg(scores) desc
limit 1;

-- . Student's Top Course: For each student, can you display the course in which they scored the highest? If they haven't taken any
-- courses,
-- display 'No Courses Taken'.
SELECT
	s.student_id,
    s.student_name,
	scores,
    COALESCE(c.course_name, 'No Courses Taken') AS Top_Course
FROM
    scores s
LEFT JOIN courses c 
ON s.course_id = c.course_id
WHERE
    (s.scores, s.course_id) IN (
        SELECT
            MAX(scores) AS max_score,
            course_id
        FROM
            scores
        GROUP BY
            course_id
    );

-- . Department ID Transformation: How would you convert department IDs to a character data type and display them alongside the
-- department names?
select department_name, d.department_id
from department d,
cast(department_id as varchar;

SELECT
    d.department_id::varchar,
    d.department_name
FROM
    department d;



-- . Course Popularity: How can you categorize courses based on the number of students who have taken them? Categories are:
-- • More than 5 students: Popular
-- • 3 to 5 students: Moderate
-- • Fewer than 3 students: Unpopular
 
 select  c.course_id, c.course_name,count(s.student_id) as Number_Student,
 case
	 	when count(s.student_id) >=5 then 'Popular'
	 	when count(s.student_id) between 3 and 5 then 'Moderate'
	 	else 'Unpopular'
	 	end as Course_Popularity
from courses c
left join scores s
on c.course_id = s.course_id
Group by c.course_id, c.course_name;
	 
	 
 SELECT
    c.course_id,
    c.course_name,
    COUNT(s.student_id) AS num_students,
    CASE
        WHEN COUNT(s.student_id) > 5 THEN 'Popular'
        WHEN COUNT(s.student_id) BETWEEN 3 AND 5 THEN 'Moderate'
        ELSE 'Unpopular'
    END AS popularity_category
FROM
    courses c
LEFT JOIN
    scores s ON c.course_id = s.course_id
GROUP BY
    c.course_id, c.course_name;

	 