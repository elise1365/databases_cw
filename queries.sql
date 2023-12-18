-- Queries
-- Select all staff first names where their role is 'general'
select staff.staff_fname as Staff_First_Name
from staff, role, staff_role
where role.role_name = 'General'
and role.role_id = staff_role.role_id
and staff.staff_id = staff_role.staff_id;

-- Select all staff members involved in a service
select staff.staff_id, service.service_id
from staff, staff_service, service
where service.service_id = staff_service.service_id
and staff_service.staff_id = staff.staff_id;

-- Select service_id and cat_id where the category of service is general removal
select service.service_id, cat_of_service.cat_id
from service, cat_of_service, service_cat
where cat_of_service.cat_id = service_cat.cat_id
and service.service_id = service_cat.service_id
and cat_of_service.cat_name = 'General removal';

-- select all future services
select service_id
from service
where completed_service = 'False';

-- Select all customers from boatyard 1
select customer.cust_id, boatyard.town
from customer, cust_boat, boatyard, boat
where boatyard.boatyard_id = 1
and boat.boatyard_id = boatyard.boatyard_id
and boat.boat_id = cust_boat.boat_id
and cust_boat.cust_id = customer.cust_id;

-- Select all boats that are jetskis
select boat.boat_name, boat.fuel_id
from boat, boat_type
where boat.boat_type_id = boat_type.boat_type_id
and boat_type.boat_type_name = 'Jetski';

-- Views!!!
-- Shows all the members of staff and boats involved in all services in the boatyard in Devon
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

-- List all the fuel names and boat ids for all boats in a boatyard
Select boat.boat_id, fuel.fuel_name
from boat, fuel
where boat.boatyard_id = 4
and boat.fuel_id = fuel.fuel_id;

select fuel.fuel_name, count (fuel.fuel_id) as number_of_boats
from boat, fuel, boatyard
where boatyard.county = 'Somerset'
and boatyard.boatyard_id = boat.boatyard_id
and boat.fuel_id = fuel.fuel_id
group by fuel.fuel_id;

select * from boatyard where boatyard_id = 4;

-- Customer contact details for all boats serviced between two dates
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

select * from service 
where service_date <= '2010-05-30'
and service_date >= '2009-04-21';

select customer.cust_email
from customer, cust_boat
where cust_boat.boat_id = 7
and cust_boat.cust_id = customer.cust_id;

-- Select all boats that had a general service 5 years ago, because they will need another one now

-- finding all the members of staff who are technicians and their locations, to sign them up for a refresher course in first aid
select staff.staff_fname as first_name, staff.staff_lname as last_name, staff.staff_work_email, staff.town, role.role_name
from staff, staff_role, role
where staff.staff_id = staff_role.staff_id
and staff_role.role_id = role.role_id
and (role.role_name = 'Technician' or role.role_name like '%technician');

-- Doinga n award for the member of staff involved with the most services this year
-- Identify number of services done by each member of staff, print off boatyard and order by num of services desc
select staff.staff_fname as first_name, staff.staff_lname as last_name, count(service.service_id), staff.boatyard_id
from staff, staff_service, service
where staff.staff_id = staff_service.staff_id
and staff_service.service_id = service.service_id;

select staff.staff_fname || ' ' || staff.staff_lname as staff_full_name, count(staff.staff_id) as total_services
from staff, staff_service, service
where staff.staff_id = staff_service.staff_id
and staff_service.service_id = service.service_id
and service.service_date >= '2015-01-01'
and service.service_date <= '2020-12-31'
group by staff.staff_id
order by count(staff.staff_id) DESC;

select * from service where service.service_date >= '2020-01-01'
and service.service_date <= '2020-12-31';

select staff.staff_fname, staff.staff_lname
from staff, staff_service
where staff_service.service_id = 48
and staff.staff_id = staff_service.staff_id;
