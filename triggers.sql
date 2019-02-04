USE StoredPr_DB; 
drop trigger if exists beforeInsertEmployee ;

#foreign keys for employee
delimiter //
create trigger beforeInsertEmployee
before insert
on employee for each row
begin 
	if (new.post not in (select post from post))
    then signal sqlstate '45000'
		set MESSAGE_TEXT = 'wrong post on insert';
	END IF;
    if (new.pharmacy_id not in (select id from pharmacy))
	then signal sqlstate '45000'
		set MESSAGE_TEXT= 'wrong pharmacy_id on insert';
	END IF;
END//
delimiter ;


drop trigger if exists beforeUpdateEmployee;

delimiter //
create trigger beforeUpdateEmployee
before update
on employee for each row
begin
	if (new.post not in (select post from post))
    then signal sqlstate '45000'
		set message_text = 'wrong post on update';
	end if;
    if (new.pharmacy_id not in (select id from pharmacy))
    then signal sqlstate '45000'
		set message_text = 'wrong pharmacy_id on update';
	end if;
end//
delimiter ;

drop trigger if exists beforeDeletePost;

delimiter //
create trigger beforeDeletePost
before delete 
on post for each row
begin 
	if (old.post in (select post from employee))
    then signal sqlstate '45000'
		set message_text = 'cant delete this post' ;
	end if;
end //
delimiter ;


drop trigger if exists beforeUpdatePost;
delimiter //
create trigger beforeUpdatePost
before update 
on post for each row
begin 
	if (old.post in (select post from employee))
    then update employee
		set post = new.post;
	end if;
end //
delimiter ;

drop trigger if exists beforeDeletePharmacy;
delimiter //
create trigger beforeDeletePharmacy
before delete 
on pharmacy for each row
begin 
	if (old.id in (select pharmacy_id from employee))
    then update employee
			set pharmacy_id = NULL
			where pharmacy_id = old.id;
		delete from pharmacy_medicine
			where pharmacy_id = old.id;
	end if;
end //
delimiter ;


#foreign keys ofr Pharmacy

drop trigger if exists beforeInsertPharmacy;
delimiter //
create trigger beforeInsertPharmacy
before insert
on pharmacy for each row
begin
	if (new.street not in (select street from street))
    then signal sqlstate '45000'
		set MESSAGE_TEXT = 'street does not exist';
	END IF;
END //
delimiter ;


drop trigger if exists beforeUpdatePharmacy;
delimiter //
create trigger beforeUpdatePharmacy
before update
on pharmacy for each row
begin
	if (new.street not in (select street from street))
    then signal sqlstate '45000'
		set MESSAGE_TEXT = 'street does not exist';
	END IF;
    if (old.id in (select pharmacy_id from employee))
    then update employee
			set pharmacy_id = new.id
			where pharmacy_id = old.id;
		update pharmacy_medicine
			set pharmacy_id = new.id
			where pharmacy_id = old.id;
	end if;
END //
delimiter ;


drop trigger if exists beforeDeleteStreet;
delimiter //
create  trigger beforeDeleteStreet
before delete
on street for each row
	if (old.street in (select street from street))
    then update pharmacy
			set street = 'none'
            where street = old.street;
	end if;
end //
delimiter ;

drop trigger if exists beforeUpdateStreet;
delimiter //
create  trigger beforeUpdateStreet
before update
on street for each row
	if (old.street in (select street from street))
    then update pharmacy
			set street = 'none'
            where street = old.street;
	end if;
end//
delimiter ;

#foreign keys for pharmacy_medicine

drop trigger if exists beforeInsertPharmacy_medicine;
delimiter //
create trigger beforeInsertPharmacy_medicine
before insert
on pharmacy_medicine for each row
	if (new.pharmacy_id not in (select id from pharmacy))
    then signal sqlstate '45000'
		set message_text = 'wrong pharmacy_id on insert';
	end if;
    if (new.medicine_id not in (select od from medicine))
    the signal sqlstate '45000'
		set message_text = 'wrong medicine_id on insert';
	end if;
end//
delimiter ;

drop trigger if exists beforeUpdatePharmacy_medicine;
delimiter //
create trigger beforeUpdatePharmacy_medicine
before update
on pharmacy_medicine for each row
	if (new.pharmacy_id not in (select id from pharmacy))
    then signal sqlstate '45000'
		set message_text = 'wrong pharmacy_id on update';
	end if;
    if (new.medicine_id not in (select od from medicine))
    the signal sqlstate '45000'
		set message_text = 'wrong medicine_id on update';
	end if;
end//
delimiter ;


#FK for Pharmacy_medicine 
drop trigger if exists beforeDeteleMedicine;
delimiter // 
create trigger beforeDeteleMedicine
before delete 
on medicine for each row 
	if (old.id in (select medicine_id from pharmacy_medicine))
    then 
		delete from pharmacy_medicine where medicine_id = old.id;
	end if;
    if (old.id in (select medicine_id from medicine_zone))
    then 
		delete from medicine_zone where medicine_id = old.id;
	end if;
end //
delimiter ;

drop trigger if exists beforeUpdeteMedicine;
delimiter // 
create trigger beforeUpdeteMedicine
before update
on medicine for each row 
	if (old.id in (select medicine_id from pharmacy_medicine))
    then 
		update pharmacy_medicine 
		set mediicine_id = new.id
        where medicine_id = old.id;
	end if;
    if (old.id in (select medicine_id from medicine_zone))
    then 
		update medicine_zone 
        set medicine_id = new.id;
        where medicine_id = old.id;
	end if;
end //
delimiter ;

drop trigger if exists beforeDeleteZone;
delimiter //
create trigger beforeDeleteZone
before delete
on zone for each row
	if (old.id in (select zone_id from medicine_zone))
    then delete from medicine_zone where zone_id = old.id;
	end if;
end //

drop trigger if exists beforeUpdateZone;
delimiter //
create trigger beforeUpdateZone
before update
on zone for each row
	if (old.id in (select zone_id from medicine_zone))
    then update medicine_zone 
		set zone_id = new.id
        where zone_id = old.id;
	end if;
end //

drop trigger if exists beforeInsertMedicine_zone
delimiter //
create trigger beforeInsertMedicine_zone
before insert
on medicine_zone for each row
	if (new.medicine_id not in (select id from medicine) or new.zone_id not in (select id from zone))
    then signal sqlstate '45000'
		set message_text = 'wrong medicine_id or zone_id';
     end if;
end //
delimiter ;

drop trigger if exists beforeUpdateMedicine_zone
delimiter //
create trigger beforeUpdateMedicine_zone
before update
on medicine_zone for each row
	if (new.medicine_id not in (select id from medicine) or new.zone_id not in (select id from zone))
    then signal sqlstate '45000'
		set message_text = 'wrong medicine_id or zone_id';
     end if;
end //
delimiter ;