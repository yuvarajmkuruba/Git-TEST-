--                                      Database TEST – PWS Trainee Batch



-- Part -1 (13 marks)

    -- 1. Write a query to fetch the student details whose name ends with the character ”y”  (1)
select * from student
where student_name like '%y';



    -- 2. Write a query to get the total number of students in each class (1)
select class,count(student_id) from student
where class in (select class from student)  group by class;

    -- 3. Write a query to fetch Student name and the percentage of marks (maximum marks in each subject is 100) (1)
select s.student_name,round(avg(sm.mark),2) "PERCENTAGE"
from student s join student_marks sm
on s.student_id=sm.student_id
group by s.student_name;

    -- 4. Write a query to get Student name , Exam name , Subject name and marks (2)
select s.student_name,e.exam_name,sub.subject_name,sm.mark
from student s
join student_marks sm on s.student_id=sm.student_id
join subject sub on sub.subject_id=sm.subject_id
join exam e on e.exam_id=sm.exam_id;

    -- 5. Write a query to fetch the youngest student details from Class-3  (2)
select * from student where bod in (select max(dob) from student where class='Class-3');
    -- 6. Write a query to get the student details who has got highest total marks in Half-Yearly exam (3)
select * from students
where student_id in(
select student_id from student_marks
group by student_id
having sum(marks)=(select max(sum(marks)) from student_marks
where exam_id in (select exam_id from exam where exam_name='halfyearly')
group by student_id));

    -- 7. Fetch all the student details who are absent for any one of the Quarterly exam (3)

select * from student
where student_id in
(select student_id from student_marks
where exam_id in
(select exam_id from exam
where exam_name='quaterly')
group by student_id
having count(*)<3);




-- Part -2 (17 marks)


    -- 8. Fetch the team name and the corresponding captain name (1)
select t.team_name "TEAM",p.player_name "CAPTAIN"
from team t join player p
on t.captain_id=p.player_id;
    -- 9. Display the player details, by suffixing player name with their team name : Ex:  Dravid-RCB (1)
select concat(p.player_name,'-',t.team_name)
from team t join player p on t.captain_id=p.player_id;
    -- 10. Fetch the current date and time in the following format: YYYY-MON-DD HH24:MI:SS (1)
select now();
    -- 11. Create a  view Vw_TemPlayer  with team name and player name (1)
create view Vw_Teamplayer as
(select t.team_name,p.player_name
from team t
join team_player tp on tp.team_id=t.team_id
join player p on tp.player_id=p.player_id);
select * from Vw_Teamplayer;


    -- 12. Write a SQL to increase player amount by 10% (1)
update player
set Player_Amount=Player_Amount*1.10 ;


    -- 13. Display all the Player details order by the player_name  (1)
select * from player
order by player_name;

    -- 14. Write a statement to add team_location as a new column to Team table (1)

alter table Team
add team_location varchar(50)
 desc Team;
    -- 15. Fetch the total player amount of each team (2)
select tp.team_id "team_id",sum(p.player_amount) "Amount/team"
from player p
join team_player tp on tp.player_id=p.player_id
group by tp.team_id;
    -- 16. Fetch the number of occurrences of S in each player name by using a query (2)

    -- 17. Display all the Player details order by team_name, player_name , by displaying the captain name as the first record for each team (2)
SELECT p.Player_Name, t.Team_Name FROM
    player p JOIN  team_player tp
    ON tp.Player_Id = p.Player_Id
    JOIN Team t on
    tp.Team_Id =t.Team_Id order by Team_name;

    -- 18. Display the highest paid captain name (3)

select player_name from player
where player_amount in
(select max(player_amount)from player
where player_id in
(select captain_id from team));