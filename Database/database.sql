drop database if exists patientDatabase;
create database patientDatabase;
use patientDatabase;


-- Create tables --

create table questions (
    groupId int(10) not null,
    questionId int(10) not null,
    question varchar(500) not null,
    constraint PK_groupQuestion PRIMARY KEY (groupId, questionId)
);

create table links (
    group1 int(10) not null,
    group2 int(10),
    answer BIT(2),
    success BIT(1),
    foreign key (group1) references questions(groupId),
    foreign key (group2) references questions(groupId)
);

create table authentication (
    userId int(10) auto_increment primary key,
    mail char(100) unique not null,
    password char(100) not null,
    type int(3) not null
);

create table patients (
    patientId int(10) primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    age int(10) not null,
    parentFirstName varchar(50) not null,
    parentLastName varchar(50) not null,
    city varchar(70) not null,
    phoneNumber varchar(20) not null,
    foreign key (patientId) references authentication(userId),
    unique(firstName, lastName)
);

create table doctors (
    doctorId int(10) primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    city varchar(70) not null,
    clinic varchar(100) not null,
    unique(firstName, lastName),
    foreign key (doctorId) references authentication(userId)
);

create table success (
    userId int(10) primary key,
    groupId int(10) not null,
    success BIT(1) not null,
    foreign key (userId) references authentication(userId),
    foreign key (groupId) references questions(groupId)
);

create table answers (
    userId int(10) primary key,
    groupId int(10) not null,
    questionId int(10) not null,
    answer BIT(1) not null,
    foreign key (userId) references authentication(userId)
);

create table scores (
    userId int(10) primary key,
    score int(10) not null,
    foreign key (userId) references authentication(userId)
);

create table pictures (
    userId int(10) primary key,
    picture1Id int(10) not null,
    picture2Id int(10) not null,
    picture1Name int(10) not null,
    picture2Name int(10) not null,
    foreign key (userId) references authentication(userId)
);

-- Create users --

/*
delete from mysql.user where User = 'admin';
flush privileges;
create user 'admin'@'localhost' IDENTIFIED with mysql_native_password by 'password';
grant all privileges on *.* to 'admin'@'localhost';
*/
