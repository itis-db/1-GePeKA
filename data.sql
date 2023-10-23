insert into activitytype(
      activitytypeid
    ,name
    ,sysname
)
select d.*
from (
    values(1,'Программа','Program')
    ,(2,'Подпрограмма','SubProgram')
    ,(3,'Проект','Project')
    ,(4,'Контракт','Contract')
    ,(5,'КТ','Point')
) d(activitytypeid, name, sysname)
where not exists(
    select 1 from activitytype t
    where t.activitytypeid = d.activitytypeid
);

insert into activity (activityid, activitytypeid, code, name, parentid)
values (1, 1, 'program1', 'Программа', null),
	(2, 2, 'subprogram1', 'Подпрограмма', 1),
	(3, 3, 'project1', 'Проект', 2),
	(4, 4, 'contract1', 'Контракт', 3),
	(5, 5, 'pointproject1', 'КТ (Проект)', 3),
	(6, 5, 'pointcontract1', 'КТ (Контракт)', 4);

insert into program (programid, indexnum, yearstart, yearfinish)
values (1, 1, 2023, 2024);

insert into subprogram (subprogramid, indexnum)
values (2, 1);

insert into project (projectid, targetdescr)
values (3, 'Description');

insert into area (areaid, name)
values (1, 'SomeArea');

insert into contract (contractid, areaid)
values (4, 1);

insert into point (pointid, plandate, factdate)
values (5, date '2023-12-21', date '2023-12-25'),
	(6, date '2023-10-24', null);
