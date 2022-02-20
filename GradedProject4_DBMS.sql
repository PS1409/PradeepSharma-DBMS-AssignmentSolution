-- create a new database TravelOnTheGo
create database TravelOnTheGo;

-- use the newly created database TravelOnTheGo
use TravelOnTheGo;

-- 1). creating new table PASSENGER and PRICE
create table PASSENGER
(
  Passenger_id int primary key auto_increment, 
  Passenger_name varchar(150),
  Category varchar(100),
  Gender varchar(1),
  Boarding_City varchar(100),
  Destination_City varchar(100),
  Distance int,
  Bus_Type varchar(50)
);

create table PRICE
(
   Price_id int primary key auto_increment, 
   Bus_Type varchar(50),
   Distance int,
   price int
);

-- 2). inserting the values into PASSENGER and PRICE table

Insert into PASSENGER(Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, Bus_Type)
values ('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper'),('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting')
,('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper'),('Khusboo','AC','F','Chennai','Hyderabad',1500,'Sleeper')
,('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper'),('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting')
,('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper'),('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting')
,('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

insert into PRICE(Bus_Type, Distance, price)
values('Sleeper',350,770),('Sleeper',500,1100),('Sleeper',600,1320),('Sleeper',700,1540),('Sleeper',1000,2200),('Sleeper',1200,2640)
,('Sleeper',1500,2700),('Sitting',500,620),('Sitting',600,744),('Sitting',700,868),('Sitting',1000,1240),('Sitting',1200,1488),('Sitting',1500,1860);

-- Select * from PASSENGER;
-- Select * from PRICE;

-- 3). How many females and how many male passengers travelled for a minimum distance of 600 KMs?
Select psn.Gender, count(*) as totalcount from PASSENGER as psn where psn.Distance >= 600  Group By psn.Gender; 

-- 4). Find the minimum ticket price for Sleeper Bus
Select Bus_Type,  min(price) from price where Bus_Type = 'Sleeper';

-- 5). Select passenger names whose names start with character 'S'
Select psg.Passenger_name  from PASSENGER as psg where psg.Passenger_name like 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output

Select psg.Passenger_name,Boarding_City, Destination_City, psg.Bus_Type, pr.Price  from PASSENGER as psg 
inner join PRICE as pr ON psg.Bus_Type = pr.Bus_Type and psg.Distance = pr.Distance
order by psg.Passenger_id;


-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
-- for a distance of 1000 KM s

Select  psg.Passenger_name As 'Passenger Name',  pr.Price  As 'Ticket price' from PASSENGER as psg 
inner join PRICE as pr ON psg.Bus_Type = pr.Bus_Type and psg.Distance = pr.Distance
where psg.Distance >= 1000 and psg.Bus_Type = 'Sitting'
order by psg.Passenger_id;


-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
-- Panaji?

Select pr.Bus_Type As 'Bus Type', pr.price As 'Bus Charge' from PRICE as pr Where pr.Bus_Type In ('Sitting','Sleeper') 
   and pr.Distance = (Select psg.Distance from  PASSENGER as psg where psg.Passenger_name = 'Pallavi'
);

-- 9) List the distances from the "Passenger" table which are unique (non-repeated
-- distances) in descending order.

Select distinct psg.Distance from PASSENGER as psg 
order by  psg.Distance desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables 

Select psg.Passenger_name AS 'Passanger Name',  CAST((psg.distance/(Select SUM(distance) from PASSENGER))*100  AS Decimal(18,2)) AS 'Pecentage'
from PASSENGER as psg ;

-- Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

Select pr.Distance as 'Distance', pr.price AS 'Price'
, CASE WHEN pr.price >  1000 THEN 'Expensive'
   WHEN pr.price >  500 AND  pr.price <=  1000 THEN 'Average'
   ELSE 'Cheap'
   END AS 'Category'
 from PRICE as pr;


