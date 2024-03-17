--
-- 	Database Table Creation
--
--		This file will create the tables for use with the book
--  Database Management Systems by Raghu Ramakrishnan and Johannes Gehrke.
--  It is run automatically by the installation script.
--
--	Version 0.1.0.0 2002/04/05 by: David Warden.
--	Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
--
--  First drop any existing tables. Any errors are ignored.
--
 --drop table Titles_Won_2 cascade constraints;
 --drop table Titles_Won_3 cascade constraints;
 --drop table Team cascade constraints;
 --drop table League cascade constraints;
 --drop table Person_Works_For_2 cascade constraints;
 --drop table Person_Works_For_3 cascade constraints;
 --drop table Maintenance cascade constraints;
 --drop table Coach cascade constraints;
 --drop table Management cascade constraints;
 --drop table Player_2 cascade constraints;
 --drop table Player_3 cascade constraints;
 --drop table Plays_2 cascade constraints;
 --drop table Plays_3 cascade constraints;
 --drop table Match_Takes_Place cascade constraints;
 --drop table Stadium cascade constraints;
 --drop table Goal_3 cascade constraints;
 --drop table Goal_4 cascade constraints;
--drop table Goal_5 cascade constraints;
 --drop table Assists cascade constraints;
--
-- Now, add each table.
--

create table Team(
	team_id number(3,0) not null,
	team_name varchar(50) not null,
	primary key (team_id),
	UNIQUE (team_name));

create table League(
    league_name varchar(50) not null,
    league_id number(2,0) not null,
    league_standing varchar(3000) null,
    primary key (league_id),
    UNIQUE (league_name));


create table Titles_Won_2(
    title_id number(2,0) not null,
    title_year number(4,0) not null,
    title_name varchar2(50) not null,
    team_id number(3,0) not null,
    primary key (title_id, title_year),
    foreign key (team_id) references Team(team_id) 
    ON DELETE CASCADE);

create table Titles_Won_3(
    team_id number(3,0) not null,
    league_id number(2,0) not null,
    primary key (team_id, league_id),
    foreign key (team_id) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (league_id) references League(league_id) 
    ON DELETE CASCADE);

create table Person_Works_For_3(
    nam varchar2(50) not null,
    start_date DATE not null,
    end_date DATE null,
    primary key (nam));

create table Person_Works_For_2(
    person_id number(3,0) not null,
    team_id number(3,0) not null,
    nam varchar2(50) not null,
    UNIQUE (nam),
    PRIMARY KEY (person_id, team_id),
    UNIQUE(person_id),
    foreign key (team_id) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (nam) references Person_Works_For_3(nam)
    ON DELETE CASCADE);

create table Maintenance(
    person_id number(3,0) not null,
    maintenance_type varchar2(30) not null,
    primary key (person_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE);

create table Coach(
    person_id number(3,0) not null,
    coach_nationality varchar2(20) not null,
    coach_type 	varchar2(30) null,
    primary key (person_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE);

create table Management(
    person_id number(3,0) not null,
    management_type varchar2(30) not null,
    primary key (person_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE);

create table Player_3 (
    position varchar2(3) not null,
    num number(2,0) not null,
    primary key (position));

create table Player_2(
    person_id number(3,0) not null,
    player_nationality varchar2(20) not null,
    position varchar2(3) not null,
    primary key (person_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE, 
    foreign key (position) references Player_3(position)
    ON DELETE CASCADE);

create table Stadium (
    stadium_id number(3,0) not null,
    address varchar2(200) not null,
    capacity number(5,0) not null,
    primary key (stadium_id));

create table Match_Takes_Place (
    match_id number(3,0) not null,
    result char(5) not null,
    attendance number(5,0) not null,
    stadium_id number(3,0) not null,
    primary key (match_id),
    foreign key (stadium_id) references Stadium(stadium_id)
    ON DELETE CASCADE);

create table Plays_2 (
    team_id_home number(3,0) not null,
    team_id_visitor number(3,0) not null,
    league_id number(2,0) not null,
    primary key (team_id_home, team_id_visitor),
    foreign key (team_id_home) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (team_id_visitor) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (league_id) references League(league_id)
    ON DELETE CASCADE);

create table Plays_3 (
    team_id_home number(3,0) not null,
    team_id_visitor number(3,0) not null,
    match_id number(3,0) not null,
    primary key (match_id),
    foreign key (team_id_home) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (team_id_visitor) references Team(team_id)
    ON DELETE CASCADE,
    foreign key (match_id) references Match_Takes_Place(match_id)
    ON DELETE CASCADE);


create table Goal_3(
    goal_id number(4,0) not null,
    person_id number(3,0) not null,
    team_id number(3,0) not null,
    primary key (goal_id, person_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE, 
    foreign key (team_id) references Team(team_id)
    ON DELETE CASCADE);

create table Goal_4 (
    goal_id number(4,0) not null,
    technique varchar(20) null,
    match_id number(3,0) not null,
    person_id number(3,0) not null,
    primary key (goal_id),
    foreign key (person_id) references Person_Works_For_2(person_id)
    ON DELETE CASCADE,  
    foreign key (match_id) references Match_Takes_Place(match_id)
    ON DELETE CASCADE);

/*create table Goal_5 (
    stadium_id number(3,0) not null,
    match_id number(3,0) not null,
    primary key (match_id),
    foreign key (stadium_id) references Stadium(stadium_id)
    ON DELETE CASCADE,
    foreign key (match_id) references Match_Takes_Place(match_id)
    ON DELETE CASCADE);
*/
create table Assists(
    person_id_assisted number(3,0) not null,
    person_id_assists number(3,0) not null,
    primary key (person_id_assisted, person_id_assists), 
    foreign key (person_id_assisted) references Person_Works_For_2(person_id)
    ON DELETE CASCADE,
    foreign key (person_id_assists) references Person_Works_For_2(person_id)
    ON DELETE CASCADE);


--
-- done adding all of the tables, now add in some tuples
--  first, add in the students

-- Leagues
insert into League
values ('La Liga Santander', 01, null);

insert into League
values ('Premier League', 02, null);

insert into League
values ('Serie A', 03, null);

insert into League
values ('Bundesliga', 04, null);

insert into League
values ('Ligue 1', 05, null);

-- Teams

insert into Team
values (001, 'FC Barcelona');

insert into Team
values (002, 'Real Madrid CF');

insert into Team
values (003, 'Club Atletico de Madrid');

insert into Team
values (004, 'Sevilla FC');

insert into Team
values (005, 'Valencia CF');

insert into Team
values (006, 'Manchester City FC');

insert into Team
values (007, 'Liverpool FC');

insert into Team
values (008, 'Manchester United FC');

insert into Team
values (009, 'Chelsea FC');

insert into Team
values (010, 'Arsenal FC');

insert into Team
values (011, 'FC Bayern Munchen');

insert into Team
values (012, 'Borussia Dortmund');

insert into Team
values (013, 'Bayer 04 Leverkusen');

insert into Team
values (014, 'Eintracht Frankfurt FC');

insert into Team
values (015, 'RB Leipzig');

insert into Team
values (016, 'Juventus FC');

insert into Team
values (017, 'AC Milan');

insert into Team
values (018, 'FC Internazionale Milano');

insert into Team
values (019, 'AS Roma');

insert into Team
values (020, 'SSC Napoli');

insert into Team
values (021, 'Paris Saint-Germain FC');

insert into Team
values (022, 'Olympique de Lyon');

insert into Team
values (023, 'AS Monaco FC');

insert into Team
values (024, 'Olympique de Marseille');

insert into Team
values (025, 'Lille OSC');

--Persons

insert into Person_Works_For_3
values ('Lionel Andres Messi', TO_DATE('08/10/2021', 'DD/MM/YYYY'), TO_DATE('30/06/2023', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (001, 021, 'Lionel Andres Messi');

insert into Person_Works_For_3
values ('Cristiano Ronaldo', TO_DATE('28/09/2021', 'DD/MM/YYYY'), TO_DATE('30/06/2023', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (002, 008, 'Cristiano Ronaldo');

insert into Person_Works_For_3
values ('Neymar Junior', TO_DATE('30/07/2017', 'DD/MM/YYYY'), TO_DATE('30/06/2025', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (003, 021, 'Neymar Junior');

insert into Person_Works_For_3
values ('Kylian Mbappe', TO_DATE('07/08/2017', 'DD/MM/YYYY'), TO_DATE('30/06/2024', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (004, 021, 'Kylian Mbappe');

insert into Person_Works_For_3
values ('Robert Lewandowski', TO_DATE('25/08/2022', 'DD/MM/YYYY'), TO_DATE('30/06/2025', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (005, 001, 'Robert Lewandowski');

insert into Person_Works_For_3
values ('Pedri', TO_DATE('01/08/2020', 'DD/MM/YYYY'), TO_DATE('30/06/2027', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (006, 001, 'Pedri');

insert into Person_Works_For_3
values ('Ousmane Dembele', TO_DATE('30/08/2017', 'DD/MM/YYYY'), TO_DATE('30/06/2024', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (007, 001, 'Ousmane Dembele');

insert into Person_Works_For_3
values ('Marc Andre Ter Stegen', TO_DATE('02/08/2014', 'DD/MM/YYYY'), TO_DATE('30/06/2026', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (008, 001, 'Marc Andre Ter Stegen');

insert into Person_Works_For_3
values ('Karim Benzema', TO_DATE('13/08/2009', 'DD/MM/YYYY'), TO_DATE('30/06/2026', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (009, 002, 'Karim Benzema');

insert into Person_Works_For_3
values ('Vinicius Junior', TO_DATE('15/08/2018', 'DD/MM/YYYY'), TO_DATE('30/06/2026', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (010, 02, 'Vinicius Junior');

insert into Person_Works_For_3
values ('Thibaut Courtois', TO_DATE('01/09/2018', 'DD/MM/YYYY'), TO_DATE('30/06/2026', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (011, 002, 'Thibaut Courtois');

insert into Person_Works_For_3
values ('Lucas Amar', TO_DATE('20/10/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2022', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (700, 002, 'Lucas Amar');

insert into Person_Works_For_3
values ('Steven Slater', TO_DATE('20/10/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2022', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (701, 021, 'Steven Slater');

insert into Person_Works_For_3
values ('David Perez Carrasco', TO_DATE('20/10/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2032', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (600, 001, 'David Perez Carrasco');

insert into Person_Works_For_3
values ('Arnau Marti', TO_DATE('20/10/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2042', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (702, 001, 'Arnau Marti');

insert into Person_Works_For_3
values ('Jon Villabona', TO_DATE('20/10/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2025', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (703, 016, 'Jon Villabona');

insert into Person_Works_For_3
values ('Dwayne Johnson', TO_DATE('20/10/2020', 'DD/MM/YYYY'), TO_DATE('30/11/2024', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (704, 006, 'Dwayne Johnson');

insert into Person_Works_For_3
values ('Elon Musk', TO_DATE('15/07/2019', 'DD/MM/YYYY'), TO_DATE('30/11/2024', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (601, 021, 'Elon Musk');

insert into Person_Works_For_3
values ('Florentino Perez', TO_DATE('20/07/2009', 'DD/MM/YYYY'), TO_DATE('30/11/2032', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (602, 002, 'Florentino Perez');

insert into Person_Works_For_3
values ('Enrique Cerezo', TO_DATE('20/10/2012', 'DD/MM/YYYY'), TO_DATE('30/11/2028', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (603, 003, 'Enrique Cerezo');

insert into Person_Works_For_3
values ('Pedro Sanchez', TO_DATE('20/10/2021', 'DD/MM/YYYY'), TO_DATE('30/11/2025', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (604, 025, 'Pedro Sanchez');

insert into Person_Works_For_3
values ('Xavi Hernandez', TO_DATE('27/10/2021', 'DD/MM/YYYY'), TO_DATE('30/11/2026', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (500, 001, 'Xavi Hernandez');

insert into Person_Works_For_3
values ('Carlo Ancelotti', TO_DATE('20/08/2020', 'DD/MM/YYYY'), TO_DATE('30/11/2027', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (501, 002, 'Carlo Ancelotti');

insert into Person_Works_For_3
values ('Josep Guardiola', TO_DATE('10/07/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2027', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (502, 006, 'Josep Guardiola');

insert into Person_Works_For_3
values ('Diego Pablo Simeone', TO_DATE('02/08/2008', 'DD/MM/YYYY'), TO_DATE('30/11/2027', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (503, 003, 'Diego Pablo Simeone');

insert into Person_Works_For_3
values ('Xabi Alonso', TO_DATE('01/08/2022', 'DD/MM/YYYY'), TO_DATE('30/11/2027', 'DD/MM/YYYY'));

insert into Person_Works_For_2
values (504, 013, 'Xabi Alonso');


-- Player Positions

insert into Player_3
values ('GK', 1);

insert into Player_3
values ('RB', 2);

insert into Player_3
values ('CB', 3);

insert into Player_3
values ('LB', 4);

insert into Player_3
values ('CDM', 5);

insert into Player_3
values ('CM', 6);

insert into Player_3
values ('LW', 11);

insert into Player_3
values ('CAM', 8);

insert into Player_3
values ('ST', 9);

insert into Player_3
values ('RW', 10);

-- Players

insert into Player_2
values (001, 'Argentina', 'RW');

insert into Player_2
values (002, 'Portugal', 'ST');

insert into Player_2
values (003, 'Brazil', 'LW');

insert into Player_2
values (004, 'France', 'ST');

insert into Player_2
values (005, 'Poland', 'ST');

insert into Player_2
values (006, 'Spain', 'CAM');

insert into Player_2
values (007, 'France', 'LW');

insert into Player_2
values (008, 'Germany', 'GK');

insert into Player_2
values (009, 'France', 'ST');

insert into Player_2
values (010, 'Brazil', 'LW');

insert into Player_2
values (011, 'Belgium', 'GK');



-- Maintenance

insert into Maintenance
values (700, 'Cleaning');

insert into Maintenance
values (701, 'IT Maintenance');

insert into Maintenance
values (702, 'Maintaining Training material');

insert into Maintenance
values (703, 'IT Maintenance');

insert into Maintenance
values (704, 'Gym Maintaining');

-- Management

insert into Management
values (600, 'President-Manager');

insert into Management
values (601, 'CEO');

insert into Management
values (602, 'President');

insert into Management
values (603, 'President');

insert into Management
values (604, 'Manager');



-- Management

insert into Coach
values (500, 'Spain', 'Possession');

insert into Coach
values (501, 'Italy', 'Counter-Attack');

insert into Coach
values (502, 'Spain', 'Possession');

insert into Coach
values (503, 'Spain', 'Defensive');

insert into Coach
values (504, 'Spain', 'Long Distance Passes');

-- Stadiums

insert into Stadium
values (001, 'C. dArístides Maillol, 12, 08028 Barcelona, Spain', 99354);

insert into Stadium
values (002, 'Av. de Concha Espina, 1, 28036 Madrid, Spain', 81044);

insert into Stadium
values (003, 'Sir Matt Busby Way, Old Trafford, Stretford, Manchester M16 0RA, England', 74310);

insert into Stadium
values (004, '24 Rue du Commandant Guilbaud, 75016 Paris, France', 47929);

insert into Stadium
values (005, 'Piazzale Angelo Moratti, 20151 Milan, Italy', 80018);

-- Titles

insert into Titles_won_2
values (01, 2022, 'Trofeo de La Liga', 002);

insert into Titles_won_3
values (002,01);

insert into Titles_won_2
values (01, 2021, 'Trofeo de La Liga', 003);

insert into Titles_won_3
values (003,01);

insert into Titles_won_2
values (01, 2019, 'Trofeo de La Liga', 001);

insert into Titles_won_3
values (001,01);

insert into Titles_won_2
values (02, 2022, 'Premier League Trophy', 006);

insert into Titles_won_3
values (006,02);

insert into Titles_won_2
values (05, 2022, 'Ligue 1 Trophee', 021);

insert into Titles_won_3
values (021,05);

insert into Titles_won_2
values (04, 2022, 'Bundesliga Trophäe', 011)

insert into Titles_won_3
values (011,04);

insert into Titles_won_2
values (03, 2022, 'Trofeo di Serie A', 17);

insert into Titles_won_3
values (017,03);

-- Matches

insert into Match_Takes_Place
values (001, '00-04', 93472, 002);

insert into Plays_2
values (002, 001, 01);

insert into Plays_3
values (002, 001, 001);

insert into Match_Takes_Place
values (002, '01-04', 87472, 003);

insert into Plays_2
values (003, 001, 01);

insert into Plays_3
values (003, 001, 002);

insert into Match_Takes_Place
values (003, '03-01', 73431, 003);

insert into Plays_2
values (010, 008, 02);

insert into Plays_3
values (010, 008, 003);

insert into Match_Takes_Place
values (004, '00-00', 76431, 005);

insert into Plays_2
values (017, 018, 03);

insert into Plays_3
values (017, 018, 004);

insert into Match_Takes_Place
values (005, '03-00', 43431, 004);

insert into Plays_2
values (021, 022, 05);

insert into Plays_3
values (021, 022, 005);

insert into Match_Takes_Place
values (006, '03-00', 73431, 002);

insert into Plays_2
values (002, 003, 01);

insert into Plays_3
values (002, 003, 006);


-- Goals

insert into Goal_3
values (001, 001, 021);

insert into Goal_4
values (001, 'Solo Goal', 005, 001);


insert into Goal_3
values (002, 001, 021);

insert into Goal_4
values (002, 'Volley', 005, 001);

insert into Assists
values (001, 003);


insert into Goal_3
values (003, 004, 021);

insert into Goal_4
values (003, 'Header', 005, 004);

insert into Assists
values (004, 001);


insert into Goal_3
values (004, 005, 001);

insert into Goal_4
values (004, 'Header', 001, 005);

insert into Assists
values (005, 006);


insert into Goal_3
values (005, 005, 001);

insert into Goal_4
values (005, 'Long Shot', 001, 005);

insert into Assists
values (005, 007);


insert into Goal_3
values (006, 001, 021);

insert into Goal_4
values (006, 'Solo Goal', 005, 001);


insert into Goal_3
values (007, 007, 001);

insert into Goal_4
values (007, 'Volley', 001, 007);

insert into Assists
values (007, 006);


insert into Goal_3
values (008, 009, 002);

insert into Goal_4
values (008, 'Solo Goal', 006, 009);


insert into Goal_3
values (009, 009, 002);

insert into Goal_4
values (009, 'Solo Goal', 006, 009);


insert into Goal_3
values (010, 009, 002);

insert into Goal_4
values (010, 'Header', 006, 009);


/* Redundant
insert into Goal_5
values (004, 005);

insert into Goal_5
values (004, 005)

insert into Goal_5
values (004, 005);

insert into Goal_5
values (002, 001);

insert into Goal_5
values (002, 001);

insert into Goal_5
values (004, 005)

insert into Goal_5
values (002, 001);*/