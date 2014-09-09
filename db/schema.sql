CREATE TABLE galleries(
	id serial primary key,
	name varchar(225),
	event varchar(225),
	neighborhood varchar(100),
	address varchar(225),
	opening_date date,
	open_thru date
);

CREATE TABLE posts(
	id serial primary key,
	author varchar(50),
	title varchar(200),
	created_on timestamp,
	post varchar,
	img varchar,
	tag varchar(50),
	upvote integer not null default 0,
	downvote integer not null default 0,
	gallery_id integer
);

CREATE TABLE subscribers(
	id serial primary key,
	name varchar(50),
	email varchar(100),
	phone varchar(10),
	category_id integer,
	post_id integer
	
);

CREATE TABLE comments(
	id serial primary key,
	name varchar(50),
	created_on timestamp,
	comment varchar,
	post_id integer
);