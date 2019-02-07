--JOIN///////////////////////////////////

select *
from invoice
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;
--Get all invoices where the unit_price on the invoice_line is greater than $0.99.

select invoice_date,first_name,last_name,total
from invoice
join customer on customer.customer_id = invoice.customer_id;
--Get the invoice_date, customer first_name and last_name, and total from all invoices.

select c.first_name,c.last_name,e.first_name,e.last_name
from customer c
join employee e on e.employee_id = c.support_rep_id;
--Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
--Support reps are on the employee table.

select a.title,ar.name
from album a
join artist ar on a.artist_id = ar.artist_id;
--Get the album title and the artist name from all albums.

select pt.track_id
from playlist_track pt
join playlist p on pt.playlist_id = p.playlist_id 
where p.name = 'Music';
--Get all playlist_track track_ids where the playlist name is Music.

select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id = 5;
--Get all track names for playlist_id 5.

select t.name,p.name
from track t
join playlist_track pt on t.track_id = pt.track_id
join playlist p on pt.playlist_id = p.playlist_id;
--Get all track names and the playlist name that they're on ( 2 joins ).

select t.name,a.title
from track t
join album a on a.album_id = t.album_id
join genre g on t.genre_id = g.genre_id
where g.name = 'Alternative & Punk';
--Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).


--NESTED QUERIES/////////////////////////////////////

select * 
from invoice
where invoice_id in (select invoice_id from invoice_line 
where unit_price > 0.99);
--Get all invoices where the unit_price on the invoice_line is greater than $0.99.

select *
from playlist_track
where playlist_id in (select playlist_id from playlist where name = 'Music');
--Get all playlist tracks where the playlist name is Music.

select name
from track
where track_id in (select track_id from playlist_track where playlist_id = 5);
--Get all track names for playlist_id 5.

select *
from track
where genre_id in (select genre_id from genre where name = 'Comedy');
--Get all tracks where the genre is Comedy.


select * 
from track
where album_id in (select album_id from album where title = 'Fireball');
--Get all tracks where the album is Fireball.

select *
from track
where album_id in (
select album_id from album where artist_id in 
(select artist_id from artist where name = 'Queen'));
--Get all tracks for the artist Queen ( 2 nested subqueries ).

--UPDATING ROWS/////////////////////////////////////

update customer
set fax = null
where fax is not null;
--Find all customers with fax numbers and set those numbers to null.

update customer
set company = 'Self'
where company is null;
--Find all customers with no company (null) and set their company to "Self".

update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett';
--Find the customer Julia Barnett and change her last name to Thompson.

update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';
--Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.

update track
set composer = 'The darkness around us'
where genre_id in (select genre_id from genre where name = 'Metal')
and composer is null;
--Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".

--GROUP BY///////////////////////////////

select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
group by g.name;
--Find a count of how many tracks there are per genre. Display the genre name with the count.

select count(*), g.name
from track t
join genre g on g.genre_id = t.genre_id 
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;
--Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.

select ar.name,count(*)
from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;
--Find a list of all artists and how many albums they have.

--USE DISTINCT//////////////////////////////

select distinct composer
from track;
--From the track table find a unique list of all composers.

select distinct billing_postal_code
from invoice;
--From the invoice table find a unique list of all billing_postal_codes.

select distinct company
from customer;
--From the customer table find a unique list of all companys.

--DELETE ROWS//////////////////////////////////
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;
--dummy table

delete from practice_delete
where type = 'bronze';
--Delete all 'bronze' entries from the table.

delete from practice_delete
where type = 'silver';
-- delete all 'silver' entries

delete from practice_delete
where value = 150;
--Delete all entries whose value is equal to 150.

--ECOMMERCE SIMULATION///////////////////////

-- Let's simulate an e-commerce site. We're going to need users, products, and orders.

-- users need a name and an email.
-- products need a name and a price
-- orders need a ref to product.
-- All 3 need primary keys.
-- Instructions
-- Create 3 tables following the criteria in the summary.
-- Add some data to fill up each table.
-- At least 3 users, 3 products, 3 orders.
-- Run queries against your data.
-- Get all products for the first order.
-- Get all orders.
-- Get the total cost of an order ( sum the price of all products on an order ).
-- Add a foreign key reference from orders to users.
-- Update the orders table to link a user to each order.
-- Run queries against your data.
-- Get all orders for a user.
-- Get how many orders each user has.

create table users (
	user_id serial primary key
  ,name varchar(50) not null
  ,email varchar(50) not null
);
insert into users (name,email)
values ('Ted', 'ted@yahoo.com'),('Bill','bill@yahoo.com'),('Jerry','jerry@yahoo.com');
                                                           
select * from users;       

create table products (
	product_id serial primary key
  ,name varchar(50) not null
  ,price integer not null
);
insert into products (name,price)
values ('Guitar', 200),('Whistle',5),('Harmonica',25);
                                                           
select * from products;  



  


