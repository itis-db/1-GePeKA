create function activity_levels(pn_activityid int)
returns table(activityid int, name varchar)
as $$
	with recursive r as (
		select activityid, activitytypeid, name, parentid from activity
		where activityid = pn_activityid

	  union all

		select a.activityid, a.activitytypeid, a.name, a.parentid from activity as a
		join r on 
			a.parentid = r.activityid
	)
	
	select activityid, name from r;
$$
language sql;

select * from activity_levels(1);
