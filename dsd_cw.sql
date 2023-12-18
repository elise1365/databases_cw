create database up2109470_cw;
\c up2109470_cw

-- Creating tables
create table boat_type(
    boat_type_id serial primary key,
    boat_type_name varchar(30)
);

create table role(
    role_id serial primary key,
    role_name varchar(22) not null
);

create table boatyard(
    boatyard_id serial primary key,
    addr_line1 varchar(100) not null,
    addr_line2 varchar(100),
    town varchar(60) not null,
    county varchar(20) not null,
    postcode varchar(9) not null
);

create table staff(
    staff_id serial primary key,
    staff_fname varchar(20) not null,
    staff_lname varchar(20) not null,
    staff_work_email varchar(40) not null,
    staff_pers_email varchar(255) not null,
    staff_tel varchar(10) not null,
    addr_line1 varchar(100) not null,
    addr_line2 varchar(100),
    town varchar(60) not null,
    county varchar(20) not null,
    postcode varchar(9) not null,
    boatyard_id int not null references boatyard(boatyard_id)
);

create table fuel(
    fuel_id serial primary key,
    fuel_name varchar(50) not null
);

create table boat(
    boat_id serial primary key,
    boat_name varchar(20) not null,
    boat_build_date date not null,
    boat_capacity int,
    boat_dimensions varchar(25) not null,
    boat_engine_size varchar(25),
    fuel_id int not null references fuel(fuel_id),
    boatyard_id int not null references boatyard(boatyard_id),
    boat_type_id int references boat_type(boat_type_id)
);

create table customer(
    cust_id serial primary key,
    cust_fname varchar(20) not null,
    cust_lname varchar(20) not null,
    cust_tel varchar(10) not null,
    cust_email varchar(255) not null,
    addr_line1 varchar(100) not null,
    addr_line2 varchar(100),
    town varchar(60) not null,
    county varchar(20) not null,
    postcode varchar(9) not null
);

-- Both future and historic services are stored in the same entity for simplicity, if a user wants to check future services, they can search after a date, and for historic services search before the date. The completed_service attribute indicates if the service has been done or not, true for completed, false otherwise
create table service(
    service_id serial primary key,
    service_date date not null,
    service_time time not null,
    completed_service boolean not null,
    service_description varchar(255) not null,
    boatyard_id int not null references boatyard(boatyard_id),
    boat_id int not null references boat(boat_id)
);

create table cat_of_service(
    cat_id serial primary key,
    cat_name varchar(50)
);

-- Creating link tables

-- links the staff and role entities
-- Both role_id and staff_id are foreign keys, and make up the composite key
create table staff_role(
    staff_id int not null references staff(staff_id),
    role_id int not null references role(role_id),
    primary key(staff_id, role_id)
);

-- Links the staff and service entities
create table staff_service(
    service_id int not null references service(service_id),
    staff_id int not null references staff(staff_id),
    primary key(service_id, staff_id)
);

-- Links the customer and boat entities
create table cust_boat(
    cust_id int not null references customer(cust_id),
    boat_id int not null references boat(boat_id),
    primary key(cust_id, boat_id)
);

-- links service and cat_of_service
create table service_cat(
    service_id int not null references service(service_id),
    cat_id int not null references cat_of_service(cat_id),
    primary key(service_id, cat_id)
);

-- Inserting data into tables

-- boat_type
insert into boat_type(boat_type_name)
values
    ('Dinghy'),
    ('Yacht'),
    ('Sailing boat'),
    ('Fishing boat'),
    ('Jetski'),
    ('Cruiser'),
    ('Houseboat'),
    ('Powerboat'),
    ('Pontoon'),
    ('Rowboat'),
    ('Sailboat');
-- Role
insert into role(role_name)
values
    ('Manager'),
    ('Glass fibre specialist'),
    ('Engine technician'),
    ('General'),
    ('Electrician'),
    ('Technician');

-- Fuel
insert into fuel(fuel_name)
values
    ('Gasoline'),
    ('Diesel'),
    ('Bunker fuel');

-- Boatyard
insert into boatyard(addr_line1, town, county, postcode)
values
    ('331-3788 Fringilla St.','Southampton','Hampshire','O0Y 0QQ'),
    ('801-9650 Massa. Road','Felixstowe','Suffolk','N9U 1DO'),
    ('8655 Mauris Road','Paignton','Devon','JN50 7PU'),
    ('484-1122 Cras Av.','Weston-super-Mare','Somerset','SM88 8LA');

-- Staff
insert into staff(staff_fname, staff_lname, staff_work_email, staff_pers_email, staff_tel, addr_line1, town, county, postcode, boatyard_id)
values
    ('Ray','Woodard','1r_woodard@solentboats.com','woodard-ray@icloud.com','871608212','3776 Nulla Ave','Clovelly','Devon','HS5 1TC', 3),
    ('Virginia','Erickson','2v_erickson@solentboats.com','v_erickson5979@outlook.net','480734883','8278 Mauris Avenue','Southampton','Hampshire','U4 8HD', 1),
    ('Phyllis','Silva','3p_silva@solentboats.com','silva.phyllis6030@outlook.net','434870750','1183 Ac Street','Salcombe','Devon','D6 8FZ', 3),
    ('Quinn','Strickland','4q_strickland@solentboats.com','q.strickland9739@google.org','845216540','453 Hymenaeos. Avenue','Sudbury','Suffolk','MR5 2IC', 2),
    ('Isadora','Estes','5i_estes@solentboats.com','eisadora@icloud.edu','447145145','Ap #924-9344 Donec Rd.','Taunton','Somerset','V76 1IS', 4),
    ('Yasir','Camacho','6y_camacho@solentboats.com','yasir.camacho6725@icloud.com','845841902','3409 Molestie Road','Yeovil','Somerset','T1 3CM', 4),
    ('Garth','Nieves','7g_nieves@solentboats.com','nieves_garth@google.couk','347937897','1663 Sem Ave','Yeovil','Somerset','QX82 5VW', 4),
    ('Reece','Strickland','8r_strickland@solentboats.com','r.strickland@icloud.com','171683471','5124 Eu, Rd.','Felixstowe','Suffolk','LL6 4OS', 2),
    ('Blaze','Frank','9b_frank@solentboats.com','b.frank@icloud.com','733324046','Ap #753-9079 Ornare St.','Wells','Somerset','W5L 2RW', 4),
    ('Zia','Dickerson','10z_dickerson@solentboats.com','dickerson.zia@aol.com','867581128','4825 Nibh Av.','Appledore','Devon','F8X 3RZ', 3),
    ('Rachel','Ortega','11r_ortega@solentboats.com','ortegarachel@aol.org','187406924','Ap #731-9224 Dis Avenue','Weston-super-Mare','Somerset','EE3 2GL', 4),
    ('Armando','Wall','12a_wall@solentboats.com','armando_wall2623@hotmail.com','635552583','2287 Sem St.','Felixstowe','Suffolk','D94 8XY', 2),
    ('Quon','Cole','13q_cole@solentboats.com','cole.quon7853@outlook.couk','171130582','7111 Sed St.','Southampton','Hampshire','S4 0VH', 1),
    ('Magee','Good','14m_good@solentboats.com','magee_good@google.org','031988898','Ap #474-1562 In Avenue','Basingstoke','Hampshire','QU1V 4PE', 1),
    ('Scarlet','Sykes','15s_sykes@solentboats.com','s.scarlet@icloud.org','215883994','770-506 Mi Rd.','Appledore','Devon','FV5E 8PN', 3),
    ('Sara','Dodson','16s_dodson@solentboats.com','sdodson1197@yahoo.com','337095925','Ap #876-1956 Magna. Av.','Exmouth','Devon','L1Y 5ED', 3);

-- Inserting some data into addr_line2
update staff
set addr_line2 = 'Park cul-de-sac'
where staff_id = 7;

update staff
set addr_line2 = 'Apartment #3'
where staff_id = 10;

update staff
set addr_line2 = 'Apartment #16'
where staff_id = 2;

update staff
set addr_line2 = 'Flat 68'
where staff_id = 5;

update staff
set addr_line2 = 'Flat 80'
where staff_id = 3;

-- staff_role
insert into staff_role(staff_id, role_id)
-- staff in boatyard_id = 1
values
    (2,1),
    (2,5),
    (13,2),
    (13,3),
    (14,6),
    (14,4),
-- staff in boatyard_id = 2
    (4,1),
    (4,5),
    (8,6),
    (8,3),
    (12,2),
    (12,4),
-- staff in boatyard_id = 3
    (1,5),
    (3,3),
    (10,2),
    (10,6),
    (15,4),
    (16,1),
-- staff in boatyard_id = 4
    (5,1),
    (6,4),
    (6,6),
    (7,5),
    (9,3),
    (11,2);

-- customer data
insert into customer(cust_fname, cust_lname, cust_tel, cust_email, addr_line1, town, county, postcode) 
values
    ('Maggie','Dalton','530619208','mdalton409@icloud.org','892-9462 Ut Rd.','Croydon','Surrey','QY6 8AO'),
    ('Bert','Salinas','397062761','salinas-bert@aol.org','8750 Dolor St.','Lockerbie','Dumfriesshire','NS1R 5HT'),
    ('Shaine','Curry','608171236','curry_shaine9131@hotmail.couk','Ap #775-7276 Mauris St.','Ayr','Ayrshire','EG36 7QF'),
    ('Honorato','Moses','226784546','moses_honorato39@google.com','222-7603 Arcu. Ave','Pembroke','Pembrokeshire','FM8 2DZ'),
    ('MacKensie','Myers','289543561','m-mackensie8295@google.edu','6277 Pede. Ave','East Linton','East Lothian','LI1 5VK'),
    ('Hamish','Adkins','253121464','adkins_hamish@yahoo.ca','7723 Quis Rd.','Dunstable','Bedfordshire','SS8L 9PW'),
    ('Brynne','Velez','586686876','velez.brynne@hotmail.co.uk','480-8176 Nonummy St.','Abergele','Denbighshire','HK2 4HC'),
    ('Azalia','Justice','723500325','azalia.justice7602@outlook.edu','Ap #427-2113 Tristique St.','Eyemouth','Berwickshire','I11 1MB'),
    ('Fredericka','Chapman','250803645','fchapman@aol.couk','547-7684 In Road','Holywell','Flintshire','GK8 2CH'),
    ('Raja','Langley','572087857','langley.raja@aol.com','Ap #787-9852 Risus St.','Marlborough','Wiltshire','ZV8V 4LS'),
    ('Price','Poole','461138528','sociis@icloud.couk','873-687 Ac Ave','Ammanford','Carmarthenshire','O3 6VQ'),
    ('Jarrod','Stuart','133644642','lacus@yahoo.couk','334 Rutrum Road','Slough','Buckinghamshire','OY7O 3IE'),
    ('Hedley','Morgan','972302925','arcu.vestibulum.ante@hotmail.edu','Ap #546-1170 Sociis Street','Kirkby Lonsdale','Westmorland','J7H 6DQ'),
    ('Guinevere','Taylor','752165684','a.tortor.nunc@protonmail.ca','Ap #699-4747 Cursus St.','Cannock','Staffordshire','S5 2KJ'),
    ('Joel','Mann','738752112','adipiscing.elit@protonmail.net','Ap #642-4233 Penatibus Ave','Barmouth','Merionethshire','RU4J 6MN'),
    ('Raja','Pearson','413361736','pharetra@protonmail.couk','430-8955 Arcu. Street','Dufftown','Banffshire','A12 5LM'),
    ('Eve','Best','445882891','condimentum@hotmail.org','733-3084 Per Rd.','Ruthin','Denbighshire','OD8 2QI'),
    ('Prescott','Wilder','814554505','eget.dictum.placerat@protonmail.edu','P.O. Box 805, 2431 Cras Road','Chelmsford','Essex','PH35 2JY'),
    ('Shaeleigh','Stein','468271764','urna.et@aol.edu','4273 At Av.','Tobermory','Argyllshire','X8O 5CL'),
    ('Giselle','Bright','745288851','non.lacinia@aol.org','Ap #595-8640 Ut Road','St. Ives','Huntingdonshire','V78 5CZ'),
    ('Dora','Matthews','880302792','nec@yahoo.edu','569-4309 Et, Rd.','Chippenham','Wiltshire','UC6X 1YI'),
    ('Gloria','Berger','770541741','phasellus@yahoo.couk','Ap #662-4266 Pede Rd.','Kelso','Roxburghshire','IF5 9BA'),
    ('Fatima','Clements','278601540','magna.duis@hotmail.net','Ap #129-5888 Vulputate Street','Alnwick','Northumberland','V3Q 7VZ'),
    ('Sean','Harris','541175053','pretium.aliquet@protonmail.couk','P.O. Box 105, 2565 Massa. Road','Jedburgh','Roxburghshire','UG49 2ZK'),
    ('Coby','Mcintyre','766524255','volutpat.nunc@outlook.net','777-1423 Vitae Ave','Flint','Flintshire','P75 0TT'),
    ('Andrew','Gilliam','221538737','eget.tincidunt@icloud.edu','879-9464 Magnis Street','Cromer','Norfolk','E6 0UG'),
    ('Lars','Adkins','891377928','lorem@google.com','4229 Nunc. Road','Gateshead','Durham','P2T 6SG'),
    ('Dahlia','Shepard','352811890','sed@aol.org','777-3461 Sem St.','Thame','Oxfordshire','U3J 1PY'),
    ('Zachary','Talley','744046973','vulputate.lacus@yahoo.ca','Ap #355-2390 Integer Road','Tewkesbury','Gloucestershire','JF4 8QI'),
    ('Lysandra','Park','549255606','turpis@yahoo.edu','Ap #498-3384 Quisque Av.','Llanelli','Carmarthenshire','Y1M 1AD');

-- Inserting some data into addr_line2
Update customer
set addr_line2 = 'Apartment 3C'
where cust_id = 13;

update customer
set addr_line2 = 'Sunset cul-de-sac'
where cust_id = 22;

update customer 
set addr_line2 = 'Flat D'
where cust_id = 28;

update customer
set addr_line2 = 'Apartment 4'
where cust_id = 5;

-- boat data
insert into boat(boat_name, boat_build_date, fuel_id, boatyard_id, boat_capacity, boat_dimensions, boat_engine_size, boat_type_id)
values
    ('Azalia','2012-12-26',3,4,6,'711 x 148','500cc',6),
    ('Noah','2018-10-04',2,4,2,'1321 x 1455','279cc',10),
    ('Eliana','1995-08-14',1,2,8,'1007 x 733 x 653','870 x 5cc',3),
    ('Hermione','1985-01-04',2,2,5,'653 x 1235','386cc',7),
    ('Mira','2001-04-26',1,2,8,'201 x 312','1040cc',11),
    ('Joelle','2012-02-16',3,1,4,'1195 x 781 x 936','117cc',10),
    ('Raymond','2006-12-10',3,1,8,'335 x 222','813cc',10),
    ('Keely','2021-05-09',3,3,7,'832 x 734','7 x 911cc',5),
    ('Preston','1988-09-16',2,3,10,'1246 x 446','618cc',5),
    ('Solomon','1989-02-27',1,3,10,'1122 x 1336 x 955','1435cc',5),
    ('Jenette','1985-08-07',1,3,7,'647 x 466','4 x 481cc',7),
    ('Hedwig','2013-09-30',3,4,10,'524 x 1421 x 1460','504cc',11),
    ('Amity','2007-02-21',1,4,5,'797 x 732 x 334','472cc',9),
    ('Samson','2022-03-27',2,4,8,'334 x 1489','764cc',2),
    ('Jared','1982-07-19',3,3,10,'1112 x 478','1453cc',8),
    ('Michelle','2016-01-27',1,2,6,'478 x 542','5 x 262cc',4),
    ('Desiree','1980-03-19',1,2,3,'731 x 627','498cc',3),
    ('Channing','2012-04-03',1,2,4,'627 x 227','2 x 1008cc',8),
    ('Raja','2022-02-05',1,1,6,'357 x 536 x 158','114cc',2),
    ('Hamilton','2010-01-06',3,1,5,'158 x 1229','1068cc',4),
    ('Robin','2012-10-05',2,1,4,'1292 x 521','4 x 43cc',5),
    ('Alexa','2008-02-07',3,1,8,'1200 x 668','3 x 62',6),
    ('Duncan','2001-12-31',1,4,7,'736 x 560','699cc',8),
    ('Berk','1983-12-21',3,4,8,'560 x 1250','687cc',1),
    ('Prescott','1999-07-30',3,3,3,'1403 x 661 x 987','420cc',10),
    ('Erasmus','2005-12-02',3,3,6,'661 x 987','1176cc',8),
    ('Madonna','2001-03-25',2,2,3,'350 x 1068','1311cc',4),
    ('Uriel','2013-05-15',2,2,1,'372 x 1480 x 146','5 x 790cc',4),
    ('Kevin','2009-04-22',3,2,1,'275 x 444','665cc',4),
    ('Daniel','2005-04-15',2,1,10,'1010 x 575','1338cc',6),
    ('Jonas','2013-06-20',1,1,10,'1386 x 1156','371cc',10),
    ('Keely','2014-10-04',1,4,5,'35 x 32 x 1080','501cc',1),
    ('Sonia','1997-03-15',3,4,7,'412 x 913 x 525','698cc',2),
    ('Lucian','1984-10-09',3,4,4,'932 x 554','3 x 20cc',10),
    ('Geraldine','2004-12-23',1,2,10,'350 x 456','792cc',9),
    ('Mark','2007-04-04',3,2,8,'379 x 364','1385cc',1),
    ('Hanae','1994-01-17',3,4,10,'35 x 1218','675cc',3),
    ('Flynn','2012-12-01',2,4,3,'564 x 890','1189cc',10),
    ('Christine','1996-05-30',3,3,10,'564 x 1243','1291cc',5),
    ('Anne','1984-04-05',2,1,1,'628 x 781 x 364','807cc',10);

insert into cust_boat(cust_id, boat_id)
values
-- boatyard_id = 1
    (10,22),
    (16,6),
    (16,21),
    (15,31),
    (17,20),
    (29,30),
    (29,40),
    (28,19),
    (21,7),
-- boatyard_id = 2
    (23,3),
    (7,16),
    (8,27),
    (6,36),
    (20,4),
    (20,17),
    (5,35),
    (25,28),
    (18,5),
    (26,29),
    (27,18),
-- boatyard_id = 3
    (13,26),
    (23,8),
    (14,9),
    (14,39),
    (12,15),
    (19,25),
    (24,10),
    (24,11),
-- boatyard_id = 4
    (2,1),
    (23,12),
    (3,23),
    (20,34),
    (20,38),
    (4,37),
    (9,13),
    (1,32),
    (11,24),
    (22,33),
    (30,2),
    (30,14);

-- Service data
insert into service(service_date, service_time, completed_service, service_description, boatyard_id, boat_id)
values
    ('2023-07-23','10:17:23',false,'missing engine part needs installing',3,26),
    ('2015-12-02','01:48:00',true,'glass fibre in engine room damaged needs repair',3,15),
    ('2018-09-08','01:22:21',true,'electrical wiring in control room needs repair, cable damaged',1,22),
    ('2017-09-18','04:06:04',true,'yearly service required',1,6),
    ('2004-07-04','01:56:37',true,'yearly service required',4,23),
    ('2005-10-18','01:50:44',true,'outdated part in control room needs removing',4,23),
    ('2011-12-03','01:45:38',true,'engine needs immediate repair',2,3),
    ('2019-08-23','01:05:43',true,'new steering wheel installed',3,9),
    ('2000-11-26','01:25:42',true,'yearly service required',1,40),
    ('2015-01-01','12:27:36',true,'fibreglass on hull needs removal as outdated',1,22),
    ('2012-06-22','01:47:49',true,'old engine part needs immediate replacing',3,15), 
    ('2017-12-15','11:09:29',true,'old engine part needs removing and updated part needs installing',1,20), 
    ('2000-03-07','04:21:46',true,'electrical part in engine room needs replacing as old one is broken due to overuse',3,25), 
    ('2014-11-30','11:34:37',true,'Part needs removing as outdated',1,20), 
    ('2008-04-14','02:04:05',true,'fibreglass insulation needs replacing in control room',3,10), 
    ('2000-08-09','02:31:17',true,'old engine part needs removing and a newer version needs installing',1,21),
    ('2015-11-01','12:13:06',true,'new glass fibre piece needs installing on deck',1,30), 
    ('2008-01-22','09:34:47',true,'old glass fibre piece isnt needed in engine room so needs removing',4,23), 
    ('2008-04-14','03:54:48',true,'electrical part isnt needed for boats use, so is being removed',3,26),
    ('2007-03-15','03:43:53',true,'electrical part damaged so needs immediate replacement',4,34), 
    ('2018-11-09','04:17:34',true,'engine needs replacement piece and a general yearly service is due',4,37),
    ('2006-11-18','04:31:04',true,'electrical wiring in control room needs fixing, cables badly damaged',2,27),
    ('2009-03-18','11:08:17',true,'part of the engine is too old and needs replacing',1,7), 
    ('2021-01-12','03:20:46',true,'yearly service on boat is due',3,15), 
    ('2005-02-22','09:31:44',true,'engine part needs replacing regularly',3,39), 
    ('2003-04-07','09:26:05',true,'outdated engine part needs removing and new version needs installing',1,40), 
    ('2002-11-25','01:29:56',true,'electrical wiring needs repairing',1,40), 
    ('2009-06-05','11:07:09',true,'old engine part is unnecessary and uses up power so needs removing',2,27), 
    ('2003-12-13','10:14:42',true,'glass fibre needs replacing in control room',1,40), 
    ('2008-01-14','02:38:05',true,'entire engine needs replacing due to bad storm damage',4,13), 
    ('2020-10-19','10:11:20',true,'new deck needs installing',2,5), 
    ('2004-03-17','09:23:02',true,'engine needs repair due to power issue',3,15), 
    ('2023-09-12','01:43:58',false,'glass fibre in engine room needs replacing',4,32), 
    ('2002-02-08','11:21:22',true,'engine part is too damaged to repair so needs removing and replacing',4,24), 
    ('2002-07-06','09:39:28',true,'yearly service due',2,5), 
    ('2010-07-24','04:10:22',true,'electrical part needs replacing every 10 years due to wear',1,7), 
    ('2000-02-03','02:53:16',true,'electrical wiring in control room needs repair due to small power cut',4,33), 
    ('2014-01-11','02:50:29',true,'yearly service due',1,6), 
    ('2009-04-25','11:31:13',true,'engine part needs removing due to lack of use',1,7), 
    ('2015-11-18','01:01:00',true,'glass fibre in engine room needs replacing',3,25), 
    ('2008-06-02','04:08:36',true,'electrical wiring in control room needs immediate repair',1,7), 
    ('2005-03-10','09:27:29',true,'new glass fibre needs installing in engine room',2,17), 
    ('2018-12-24','02:49:02',true,'yearly service due',2,35), 
    ('2004-06-23','10:38:21',true,'glass fibre in control room needs removing',3,9), 
    ('2016-01-06','03:19:38',true,'engine needs a service as owner claims its not working',1,31), 
    ('2011-03-31','04:17:09',true,'yearly service due',3,15), 
    ('2005-10-19','10:48:26',true,'electrical part in engine room needs repairing and glass fibre needs servicing',4,23), 
    ('2020-05-16','04:15:32',true,'electrical part from deck needs removing, outdated',4,12), 
    ('2015-08-12','04:32:39',true,'door between engine room and control room needs removing',2,4), 
    ('2004-09-17','09:56:31',true,'engine needs servicing, owner has voiced concerns about travelling long distances with old engine',1,40); 

-- cat_of_service
insert into cat_of_service(cat_name)
values
    ('General replacement'),
    ('General part installation'),
    ('General removal'),
    ('General service'),
    ('Electrical repair'),
    ('Electrical service'),
    ('Electrical part installation'),
    ('Electrical part replacement'),
    ('Electrical part removal'),
    ('Engine repair'),
    ('Engine service'),
    ('Engine part replacement'),
    ('Engine part removal'),
    ('Engine part installation'),
    ('Glass fibre service'),
    ('Glass fibre repair'),
    ('Glass fibre replacement'),
    ('Glass fibre installation'),
    ('Glass fibre removal');

-- service_cat
insert into service_cat(service_id,cat_id)
values
    (1,14),
    (2,16),
    (3,5),
    (4,4),
    (5,4),
    (6,3),
    (7,10),
    (8,2),
    (9,4),
    (10,19),
    (11,12),
    (12,13),
    (12,14),
    (13,8),
    (14,3),
    (15,17),
    (16,13),
    (16,14),
    (17,18),
    (18,19),
    (19,9),
    (20,8),
    (21,12),
    (21,4),
    (22,5),
    (23,12),
    (24,4),
    (25,12),
    (26,13),
    (26,14),
    (27,5),
    (28,13),
    (29,16),
    (30,12),
    (31,2),
    (32,10),
    (33,17),
    (34,13),
    (34,12),
    (35,4),
    (36,8),
    (37,5),
    (38,4),
    (39,13),
    (40,17),
    (41,5),
    (42,18),
    (43,4),
    (44,19),
    (45,11),
    (46,4),
    (47,5),
    (47,15),
    (48,9),
    (49,3),
    (50,11);

-- staff_service
insert into staff_service(staff_id, service_id)
values
    (7,48),
    (6,18),
    (11,18),
    (6,6),
    (6,5),
    (6,47),
    (7,47),
    (11,47),
    (6,20),
    (7,20),
    (6,21),
    (9,21),
    (9,30),
    (6,30),
    (11,33),
    (6,33),
    (6,34),
    (9,34),
    (6,37),
    (7,37),
    (3,1),
    (10,1),
    (1,19),
    (10,19),
    (10,8),
    (3,25),
    (10,44),
    (3,11),
    (3,32),
    (10,32),
    (10,2),
    (15,24),
    (15,46),
    (1,13),
    (10,13),
    (10,40),
    (10,15),
    (8,7),
    (8,28),
    (4,22),
    (8,22),
    (12,49),
    (8,42),
    (12,42),
    (12,43),
    (12,35),
    (12,31),
    (8,31),
    (2,3),
    (14,3),
    (13,10),
    (14,4),
    (13,16),
    (14,16),
    (14,38),
    (13,45),
    (13,12),
    (14,12),
    (14,14),
    (13,17),
    (14,17),
    (13,50),
    (13,29),
    (14,9),
    (13,26),
    (14,26),
    (2,27),
    (14,27),
    (13,39),
    (14,39),
    (2,41),
    (14,41),
    (13,23),
    (2,36);
-- Queries
create view future_service_details as
select service.service_id, staff.staff_fname || ' ' || staff.staff_lname as staff_full_name, service.service_date, service.service_time, boat.boat_name, boatyard.county
from service, staff, staff_service, boatyard, boat
where service.completed_service = 'f'
and boatyard.boatyard_id = service.boatyard_id
and boat.boatyard_id = service.boatyard_id
and service.boat_id = boat.boat_id
and service.service_id = staff_service.service_id
and staff_service.staff_id = staff.staff_id
order by service.service_id;
select * from future_service_details;

select fuel.fuel_name, count (fuel.fuel_id) as number_of_boats
from boat, fuel, boatyard
where boatyard.county = 'Somerset'
and boatyard.boatyard_id = boat.boatyard_id
and boat.fuel_id = fuel.fuel_id
group by fuel.fuel_id;

create view cust_contact_details as
select customer.cust_tel as customer_telephone, customer.cust_email as customer_email, service.service_id, service.service_date as date, boat.boat_name
from customer, cust_boat, boat, service
where service.service_date <= '2010-05-30'
and service.service_date >= '2009-04-21'
and customer.cust_id = cust_boat.cust_id
and cust_boat.boat_id = boat.boat_id 
and boat.boatyard_id = service.boatyard_id
and boat.boat_id = service.boat_id;
select * from cust_contact_details;

select staff.staff_fname as first_name, staff.staff_lname as last_name, staff.staff_work_email, staff.town, role.role_name
from staff, staff_role, role
where staff.staff_id = staff_role.staff_id
and staff_role.role_id = role.role_id
and (role.role_name = 'Technician' or role.role_name like '%technician');

select staff.staff_fname || ' ' || staff.staff_lname as staff_full_name, count(staff.staff_id) as total_services
from staff, staff_service, service
where staff.staff_id = staff_service.staff_id
and staff_service.service_id = service.service_id
and service.service_date >= '2015-01-01'
and service.service_date <= '2020-12-31'
group by staff.staff_id
order by count(staff.staff_id) DESC;
