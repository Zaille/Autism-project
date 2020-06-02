drop table if exists users;
drop table if exists answers;
drop table if exists scores;


 -- Create tables --

create table users (
    patientId int primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    age int not null,
    parentFirstName varchar(50) not null,
    parentLastName varchar(50) not null,
    parentMail varchar(70) not null,
    phoneNumber varchar(20) not null
);

create table answers (
    patientId int primary key,
    answer1 varchar(30) not null
);

create table scores (
    patientId int primary key,
    score int not null
);

create table pictures (
    patientId int primary key,
    picture1Id int not null,
    picture2Id int not null,
    picture1Name int not null,
    picture2Name int not null
);


-- Create users --

delete from mysql.user where User = 'admin';
create user 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adminPassword';
grant all privileges on *.* to 'admin'@'localhost';
