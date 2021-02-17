create table subways (
    StationID primary key,
    StationName varchar,
    address varchar,
    zipcode int,
    line varchar,
    notes varchar
);

create table zipcodes (
    id serial primary key,
    zipcode int
);

create table boroughs (
    id serial primary key,
    borough varchar
);