USE StoredPr_DB; 

#triggers
#2

drop trigger if exists employeeId_number_ControllBI;
delimiter //
create trigger employeeId_number_ControllBI
before insert
on employee for each row
begin
	if (new.identity_number like '%00') 
    then signal sqlstate '45000'
		set message_text = 'wrong identity_number on insert';
	end if;
end //
delimiter ;

drop trigger if exists employeeId_number_ControllBU;
delimiter //
create trigger employeeId_number_ControllBU
before update
on employee for each row
begin
	if (new.identity_number like '%00') 
    then signal sqlstate '45000'
		set message_text = 'wrong identity_number on insert';
	end if;
end //
delimiter ;

#3
drop trigger if exists medicineMinistry_codeCotrollBI;
delimiter //
create trigger medicineMinistry_codeCotrollBI 
before insert
on medicine for each row
begin
	if (new.ministry_code not rlike '^([A-Z&&[^MP]])$1-\d{3}-\d{2}')
    then signal sqlstate '45000'
		set message_text = 'wrong ministry_code ';
	end if;
end //
delimiter ;

drop trigger if exists medicineMinistry_codeCotrollBU;
delimiter //
create trigger medicineMinistry_codeCotrollBU
before update
on medicine for each row
begin
	if (new.ministry_code not rlike '^([A-Z&&[^MP]])$1-\d{3}-\d{2}')
    then signal sqlstate '45000'
		set message_text = 'wrong ministry_code ';
	end if;
end //
delimiter ;

#4
drop trigger if exists postProhibitionChange;
delimiter \/
create trigger postProhibitionChange
before update
on post for each row
begin
	signal sqlstate '45000'
    set message_text = 'you are not allowed to change something';
end \/
delimiter ;

#stored procedures
#1
drop procedure if exists employeeInsert;

delimiter //
create procedure employeeInsert(
	IN id				  INT,
    IN surname            VARCHAR(30),
    IN name               CHAR(30),
    IN midle_name         VARCHAR(30),
    IN identity_number    CHAR(10),
    IN passport           CHAR(10),
    IN experience         DECIMAL(10, 1),
    IN birthday           DATE,
    IN post               VARCHAR(15),
    IN pharmacy_id        INT)
begin 
	insert into employee values (id, surname, name, midle_name, identity_number, passport, experience, birthday, post, pharmacy_id);
end //
delimiter ;

drop function if exists seniority;

delimiter //
create function seniority()
returns decimal(10,1)
begin
	return (select min(expirience) from employee);
end //
delimiter ;