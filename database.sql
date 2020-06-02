drop database if exists patientDatabase;
create database patientDatabase;
use patientDatabase;


 -- Create tables --

create table users (
    patientId int(10) primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    age int(10) not null,
    parentFirstName varchar(50) not null,
    parentLastName varchar(50) not null,
    parentMail varchar(70) not null,
    phoneNumber varchar(20) not null,
);

create table authentication (
    patientId int(10) primary key,
    mail char(100) not null,
    password char(100) not null,
    type int(3) not null,
    foreign key (patientId) references users(patientId)
);

create table answers (
    patientId int(10) primary key,
    answer1 varchar(30) not null,
    foreign key (patientId) references users(patientId)
);

create table scores (
    patientId int(10) primary key,
    score int(10) not null,
    foreign key (patientId) references users(patientId)
);

create table pictures (
    patientId int(10) primary key,
    picture1Id int(10) not null,
    picture2Id int(10) not null,
    picture1Name int(10) not null,
    picture2Name int(10) not null,
    foreign key (patientId) references users(patientId)
);


-- Create users --

delete from mysql.user where User = 'admin';
create user 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adminPassword';
grant all privileges on *.* to 'admin'@'localhost';
