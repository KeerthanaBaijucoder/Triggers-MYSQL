use five;

create table teachers (
id int primary key,
namme varchar(50),
subjectt varchar(50),
experience int,
salary float
);

insert into teachers(id, namme, subjectt, experience, salary)  values
(1, "Alice", "Math", 5, 45000.00),
(2, "Jhonny", "Science", 12, 60000.00),
(3, "Charlie", "History", 9, 47000.00),
(4, "Diana", "English", 15, 70000.00),
(5, "George", "Chemistry", 4, 44000.00),
(6,"Helen", "Biology", 10, 51000.00),
(7, "David", "Physics", 11, 62000.00),
(8, "Chris", "Math", 7, 48000.00);

delimiter $$
create trigger before_insert_teacher
before insert on teachers
for each row
begin
	if new.salary < 0 then
        signal sqlstate '45000'
        set message_text = 'Salary cannot be negative';
    end if;
end$$
delimiter ;

create table teacher_log (
    teacher_id int,
    action_ varchar(50),
    log_time datetime
);    

delimiter $$
create trigger after_insert_teacher
after insert on teachers
for each row
begin
    insert into teacher_log values(new.id, 'INSERT', NOW());
end$$
delimiter ;

insert into teachers values(9, "Robert", "Science", 8, 50000.00);
select *from teacher_log;

delimiter $$
create trigger before_delete_teacher
before delete on teachers
for each row
begin
    if old.experience > 10 then
        signal sqlstate '45000'
        set message_text = 'Cannot delete teacher with more than 10 years of experience';
    end if;
end$$
delimiter ;

delete from teachers where id=2;

delimiter $$
create trigger after_delete_teacher
after delete on teachers
for each row
begin
    insert into teacher_log values(old.id, 'DELETE', NOW());
end$$
delimiter ;

delete from teachers where id=5;
select *from teacher_log;