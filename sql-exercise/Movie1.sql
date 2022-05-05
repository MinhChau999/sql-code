create database Movie
go

use Movie
go

--1
create table movie
(
	mov_id integer,
	mov_title char(50),
	mov_year integer,
	mov_time integer,
	mov_lang char(50),
	mov_dt_rel date,
	mov_rel_country char(5),

	primary key (mov_id)
)
go
--2
create table actor
(
	act_id integer,
	act_frame char(20),
	acy_lname char(20),
	act_gender char(20),
	
	primary key (act_id)
)
go
--3
create table director
(
	dir_id integer,
	dir_frame char(20),
	dir_lname char(20),
	
	primary key (dir_id)
)
go

--4
create table genres
(
	gen_id integer,
	gen_title char(20),
	primary key (gen_id)
)
go
--5
create table reviewer
(
	rev_id integer,
	rev_name char(30),
	primary key (rev_id)
)
go
--6
create table movie_cast
(
	act_id integer,
	mov_id integer,
	role char(30),
	foreign key (act_id) references actor(act_id),
	foreign key (mov_id) references movie(mov_id)
)
go
--7
create table movie_direction
(
	dir_id integer,
	mov_id integer,
	foreign key (dir_id) references director(dir_id),
	foreign key (mov_id) references movie(mov_id)
)
go
create table movie_genres
(
	gen_id integer,
	mov_id integer,
	foreign key (gen_id) references genres(gen_id),
	foreign key (mov_id) references movie(mov_id)
)
go
create table rating
(
	rev_id integer,
	mov_id integer,
	rev_stars integer,
	num_o_ratings integer,
	foreign key (rev_id) references reviewer(rev_id),
	foreign key (mov_id) references movie(mov_id)
)
go