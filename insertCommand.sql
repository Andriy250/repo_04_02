USE StoredPr_DB; 
set SQL_SAFE_UPDATES = 0;

delete from zone;
delete from medicine;
delete from street;
delete from post;
delete from pharmacy;
delete from pharmacy_medicine;
delete from medicine_zone;
delete from employee;

insert into zone(name) values ('heart'),('stonach'),('kidneys'),('lungs');

insert into medicine(name, ministry_code, recipe, narcotic, psychotropic) values ('ponosolon', '00000', 1,1,1), ('ekkleron', '00001', 1,0,0), ('pemeponom', 00002, 0,0,0), 
('aybolicilin', '00001',1,0,0),	('dekatron', 00000, 0,1,1);
    
insert into street(street) values ('Arhipenka str'),('Slipogo str'),('Strbomna str');

insert into post(post) values ('kombat'),('prinesu poday'),('pidluza'), ('prodavets');	

insert into pharmacy(name, building_number, www, work_time, saturday, sunday,street) values ('n1', '24a' , 'www.batte.net', '24:00:00',1,1,'Arhipenka str'),
('n2', '1b', 'www.brehnya.nit', '12:59:59', 0,0, 'Slipogo str'),
 ('n3', '10', 'www.byut.sk', '23:00:00', 0,1,'Strbomna str');

insert into pharmacy_medicine values (1,1),(1,2), (1,3),(2,2),(2,3),(2,4);

insert into medicine_zone values (1,1), (2,1),(3,4),(4,2),(5,3);

insert into employee(surname, name, midle_name, identity_number, passport, experience, birthday, post, pharmacy_id) values 
('Pess', 'Duke', 'Batkovich', '47', '1234' , 2, '1999-01-01', 'kombat', 2),
('BIke', 'Mike', 'iz Zakarpattya', '00' , '4321', 3, '1980-02-02', 'pidluza', 1),
('Pink', 'Lester', 'American guy', '03', '8841', 10, '1959-09-09', 'prodavets' , 3);