create table activitytype (
	activitytypeid integer primary key,
	name varchar not null,
	sysname varchar not null
);

create table activity (
	activityid integer primary key,
	activitytypeid integer references activitytype (activitytypeid) not null,
	code varchar not null,
	name varchar not null,
	parentid integer references activity (activityid)
);

create table program (
	programid integer primary key references activity (activityid),
	indexnum integer,
	yearstart integer,
	yearfinish integer
);

create table subprogram (
	subprogramid integer primary key references activity (activityid),
	indexnum integer
);

create table project (
	projectid integer primary key references activity (activityid),
	targetdescr varchar
);

create table area (
	areaid integer primary key,
	name varchar not null
);

create table contract (
	contractid integer primary key references activity (activityid),
	areaid integer references area (areaid)
);

create table point (
	pointid integer primary key references activity (activityid),
	plandate date not null,
	factdate date
);
