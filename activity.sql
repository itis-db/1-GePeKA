create function activity_levels(pn_activityid int)
returns table(activityid int, name varchar)
as $$
	with recursive r as 
	(
		select a.activityid, 
			a.activitytypeid, 
			a.name, 
			a.parentid, 
			p.name as areaname
		from activity as a
		left join contract as c on
			c.contractid = a.activityid
		left join area as p on
			p.areaid = c.areaid
		where activityid = pn_activityid

	  union all

		select a.activityid, 
			a.activitytypeid, 
			a.name,
			a.parentid, 
			p.name as areaname
		from activity as a
		left join contract as c on
			c.contractid = a.activityid
		left join area as p on
			p.areaid = c.areaid
		join r on 
			a.parentid = r.activityid
	)

	select temp.activityid, temp.name 
	from 
	(
		select * from r
		union 
		select null , null, (select r.areaname from r where areaname is not null), null, null
	) as temp  
	order by case 
		when activitytypeid between 1 and 2 then 1
		when activityid is null then 2
		when activitytypeid = 3 then 3
		when activitytypeid = 5 and parentid = 3 then 4
		when activitytypeid = 4 then 5
		end
$$
language sql;

select * from activity_levels(1);
