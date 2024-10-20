-- Part 1
drop table Reservation;
drop table Cruise;
drop table Ship;
drop table Customer;
drop table TravelAgent;
drop table Company;

drop sequence reservationID_seq;
drop sequence cruiseID_seq;
drop sequence customerID_seq;
drop sequence travelAgentID_seq;

-- Part 2
create table Customer (
	customerID number,
	firstName varchar2(15),
	lastName varchar2(15),
	address varchar2(30),
	phone number(10),
	age number(3),
	Constraint Customer_PK Primary Key (customerID), 
	Constraint Customer_UQ UNIQUE (firstName, lastName, phone),
	Constraint CustomerVal Check (phone is not null)
);

create sequence customerID_seq
start with 0
increment by 5
minvalue 0;

insert into Customer values (customerID_seq.nextval, 'Dylan', 'Ward', '42 Elm Place', 8915367188, 22);
insert into Customer values (customerID_seq.nextval, 'Austin', 'Ross', '657 Redondo Ave.', 1233753684, 25);
insert into Customer values (customerID_seq.nextval, 'Lisa', 'Powell', '5 Jefferson Ave.', 6428369619, 17);
insert into Customer values (customerID_seq.nextval, 'Brian', 'Martin', '143 Cambridge Ave.', 5082328798, 45);
insert into Customer values (customerID_seq.nextval, 'Nicole', 'White', '77 Massachusetts Ave.', 6174153059, 29);
insert into Customer values (customerID_seq.nextval, 'Tyler', 'Garcia', '175 Forest St.', 9864752346, 57);
insert into Customer values (customerID_seq.nextval, 'Anna', 'Allen', '35 Tremont St.', 8946557732, 73);
insert into Customer values (customerID_seq.nextval, 'Michael', 'Sanchez', '9 Washington Court', 1946825344, 18);
insert into Customer values (customerID_seq.nextval, 'Justin', 'Myers', '98 Lake Hill Drive', 7988641411, 26);
insert into Customer values (customerID_seq.nextval, 'Bruce', 'Clark', '100 Main St.', 2324648888, 68);
insert into Customer values (customerID_seq.nextval, 'Rachel', 'Lee', '42 Oak St.', 2497873464, 19);
insert into Customer values (customerID_seq.nextval, 'Kelly', 'Gray', '1414 Cedar St.', 9865553232, 82);
insert into Customer values (customerID_seq.nextval, 'Madison', 'Young', '8711 Meadow St.', 4546667821, 67);
insert into Customer values (customerID_seq.nextval, 'Ashley', 'Powell', '17 Valley Drive', 2123043923, 20);
insert into Customer values (customerID_seq.nextval, 'Joshua', 'Davis', '1212 8th St.', 7818914567, 18);

select * from Customer;

create table TravelAgent (
	travelAgentID number,
	firstName varchar2(15),
	lastName varchar2(20),
	title varchar2(15),
	salary number(7,2),
	Constraint TravelAgent_PK Primary Key (travelAgentID),
	Constraint TravelAgentVal check (title in ('Assistant', 'Agent', 'Manager'))
);

create sequence travelAgentID_seq
start with 0
increment by 5
minvalue 0;

insert into TravelAgent values (travelAgentID_seq.nextval, 'Chloe', 'Rodriguez', 'Assistant', 31750);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Ben', 'Wilson', 'Agent', 47000.22);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Mia', 'Smith', 'Manager', 75250);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Noah', 'Williams', 'Assistant', 32080.9);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Liam', 'Brown', 'Manager', 60500.75);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Mason', 'Jones', 'Manager', 79000);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Olivia', 'Miller', 'Agent', 54000.5);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Sofia', 'Davis', 'Agent', 45000);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Jason', 'Garcia', 'Manager', 52025.95);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Emily', 'Johnson', 'Assistant', 22000.5);
insert into TravelAgent values (travelAgentID_seq.nextval, 'Ethan', 'Elm', 'Agent', 27044.52);

select * from TravelAgent;

create table Company (
	companyName varchar2(15),
	stockSymbol char(4),
	website varchar2(40),
	Constraint Company_PK Primary Key (companyName),
	Constraint Company_UQ Unique (stockSymbol)
);

insert into Company values ('Carnival', 'CRVL', 'http://www.carnival.com');
insert into Company values ('Celebrity', 'CELB', 'http://www.celebritycruises.com');
insert into Company values ('NCL', 'NCLC', 'http://www.ncl.com');
insert into Company values ('Princess', 'PRCS', 'http://www.princess.com');

select * from Company;

create table Ship (
    shipName varchar2(20),
    companyName varchar2(15),
    yearBuilt number(4),
    crew number(4),
    passengers number(4),
    tonnage number(6),
    dailyTips number(5,2),
    Constraint Ship_PK Primary Key (shipName, companyName),
    Constraint Ship_FK Foreign Key (companyName)
        References Company (companyName) on Delete Cascade,
    Constraint check_year_built check (yearBuilt >= 1822),
    Constraint check_tonnage check (tonnage between 50000 and 110000)
);

insert into Ship values ('Spirit', 'Carnival', 1997, 930, 2124, 95000, 9.95);
insert into Ship values ('Equinox', 'Celebrity', 2009, 1255, 2850, 95000, 15.50);
insert into Ship values ('Jewel', 'NCL', 2005, 1069, 2376, 50000, 12.75);
insert into Ship values ('Pearl', 'NCL', 2006, 1072, 2394, 65000, 12.75);
insert into Ship values ('Crown', 'Princess', 2018, 1200, 3080, 110000, 14.00);

select * from Ship;

create sequence cruiseID_seq
start with 0
increment by 5
minvalue 0;

create table Cruise (
    cruiseID number,
    cruiseName varchar2(25),
    departurePort varchar2(20),
    days number(2),
    shipName varchar2(20),
    companyName varchar2(15),
    price number(7,2),
    constraint Cruise_PK primary key (cruiseID),
    constraint foreign_key_ship foreign key (shipName, companyName)
        references Ship (shipName, companyName) on delete cascade
);

insert into Cruise values (cruiseID_seq.nextval, 'Mexico', 'Miami', 7, 'Pearl', 'NCL', 799);
insert into Cruise values (cruiseID_seq.nextval, 'New England', 'Boston', 7, 'Jewel', 'NCL', 895.75);
insert into Cruise values (cruiseID_seq.nextval, 'ABC Islands', 'Miami', 4, 'Equinox', 'Celebrity', 450.5);
insert into Cruise values (cruiseID_seq.nextval, 'Hawaii', 'San Francisco', 14, 'Crown', 'Princess', 2310);
insert into Cruise values (cruiseID_seq.nextval, 'Panama Canal', 'Miami', 10, 'Spirit', 'Carnival', 1432.99);

select * from Cruise;

create table Reservation (
	reservationID number,
	customerID number,
	cruiseID number,
	travelAgentID number,
	travelDate date,
    paymentDate date,
	Constraint Reservation_PK Primary Key (reservationID),
	Constraint Reservation_FK1 Foreign Key (customerID)
	    References Customer (customerID) On Delete Cascade,
	Constraint Reservation_FK2 Foreign Key (cruiseID)
		References Cruise (cruiseID) On Delete Cascade,
	Constraint Reservation_FK3 Foreign Key (travelAgentID)
		References TravelAgent (travelAgentID) On Delete Cascade
);

create sequence reservationID_seq
start with 0
increment by 5
minvalue 0;

insert into Reservation values (reservationID_seq.nextval, 55, 0, 5, '9-Nov-24', null);
insert into Reservation values (reservationID_seq.nextval, 65, 15, 20, '21-Jan-25', null);
insert into Reservation values (reservationID_seq.nextval, 20, 15, 0, '11-Dec-24', null);
insert into Reservation values (reservationID_seq.nextval, 40, 20, 15, '31-Aug-25', null);
insert into Reservation values (reservationID_seq.nextval, 60, 0, 5, '10-Apr-25', null);
insert into Reservation values (reservationID_seq.nextval, 20, 15, 25, '29-Jul-24', null);
insert into Reservation values (reservationID_seq.nextval, 5, 5, 5, '17-May-25', null);
insert into Reservation values (reservationID_seq.nextval, 15, 0, 45, '11-Apr-25', null);
insert into Reservation values (reservationID_seq.nextval, 45, 20, 10, '3-Jun-24', null);
insert into Reservation values (reservationID_seq.nextval, 20, 10, 40, '15-Oct-24', null);
insert into Reservation values (reservationID_seq.nextval, 0, 5, 30, '8-Mar-25', null);
insert into Reservation values (reservationID_seq.nextval, 20, 15, 30, '24-Nov-24', null);
insert into Reservation values (reservationID_seq.nextval, 35, 0, 0, '3-Aug-25', null);
insert into Reservation values (reservationID_seq.nextval, 70, 20, 45, '13-Dec-24', null);
insert into Reservation values (reservationID_seq.nextval, 15, 10, 30, '6-Feb-25', null);
insert into Reservation values (reservationID_seq.nextval, 25, 15, 20, '12-Aug-25', null);
insert into Reservation values (reservationID_seq.nextval, 65, 5, 35, '22-Jun-25', null);
insert into Reservation values (reservationID_seq.nextval, 50, 20, 40, '1-Feb-25', null);
insert into Reservation values (reservationID_seq.nextval, 30, 15, 35, '15-Mar-25', null);
insert into Reservation values (reservationID_seq.nextval, 65, 15, 10, '28-Feb-25', null);

-- Part 3
update Reservation
set paymentDate = greatest(travelDate - 120, sysdate);
select reservationID, travelDate, paymentDate
from Reservation;

select * from Reservation;

-- Part 4a
select S.shipName, S.companyName, (S.crew + S.passengers) as TotalPeople
from Ship S, Company C
where S.companyName = C.companyName
and C.stockSymbol like '%R%'
and (S.crew + S.passengers) > 3500;

-- Part 4b
select TA.firstName, TA.lastName, 
       to_char(sum(C.price), '$99999.99') as TotalSales
from TravelAgent TA
join Reservation R on TA.travelAgentID = R.travelAgentID
join Cruise C on R.cruiseID = C.cruiseID
group by TA.firstName, TA.lastName
order by sum(C.price) desc, TA.lastName asc, TA.firstName asc;

-- Part 4c
select 
    nvl(to_char(r.paymentDate, 'DD-MON-YY'), 'No Payment Date') as paymentDate,
    count(distinct c.customerID) as "Number of Unique Customers Under 30"
from 
    Customer c
left join 
    Reservation r on c.customerID = r.customerID
where 
    c.age < 30
group by 
    r.paymentDate
order by 
    r.paymentDate nulls last;

-- Total count of unique customers under 30
select count(distinct c.customerID) as "Total Unique Customers Under 30"
from 
    Customer c
left join 
    Reservation r on c.customerID = r.customerID
where 
    c.age < 30;

