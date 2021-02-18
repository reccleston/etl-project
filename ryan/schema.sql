create table subways (
    StationID primary key,
    StationName varchar,
    address varchar,
    zipcode int,
    line varchar,
    notes varchar
    foreign key (zipcode) references zipcodes
);

create table zipcodes (
    id serial primary key,
    zipcode int
);

create table boroughs (
    id serial primary key,
    borough varchar
);

create table complaints (

);