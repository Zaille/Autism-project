drop database if exists patientDatabase;
create database patientDatabase;
use patientDatabase;


 -- Create tables --

create table users (
    patientId int primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    age int not null,
    parentFirstName varchar(50) not null,
    parentLastName varchar(50) not null,
    parentMail varchar(70) not null,
    phoneNumber varchar(20) not null,
    unique(firstName, lastName, parentMail)
);

create table questions (
    groupId int not null,
    questionId int not null,
    type int not null,
    question varchar(500) not null,
    constraint PK_groupQuestion PRIMARY KEY (groupId, questionId)
);

create table answers (
    patientId int primary key,
    groupId int not null,
    questionId int not null,
    yesNoAnswer BIT(1) not null,
    answerChoice int,
    example varchar(500),
    description varchar(500),
    foreign key (patientId) references users(patientId),
    foreign key (groupId, questionId) references questions(groupId, questionId)
);


create table authentication (
    patientId int primary key,
    mail char(100) unique not null,
    password char(100) not null,
    type int not null,
    foreign key (patientId) references users(patientId)
);

create table success (
    patientId int primary key,
    groupId int not null,
    success BIT(1) not null,
    foreign key (patientId) references users(patientId),
    foreign key (groupId) references questions(groupId)
);


create table scores (
    patientId int primary key,
    score int not null,
    foreign key (patientId) references users(patientId)
);

create table pictures (
    patientId int primary key,
    picture1Id int not null,
    picture2Id int not null,
    picture1Name int not null,
    picture2Name int not null,
    foreign key (patientId) references users(patientId)
);

-- Create users --

/*
delete from mysql.user where User = 'admin';
flush privileges;
create user 'admin'@'localhost' IDENTIFIED with mysql_native_password by 'password';
grant all privileges on *.* to 'admin'@'localhost';
*/
