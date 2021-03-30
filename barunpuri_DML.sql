DROP DATABASE IF EXISTS barunpuri;

CREATE DATABASE barunpuri ENCODING = 'UTF8';

drop table if exists bike_usage;
CREATE TABLE  bike_usage (
    usage_id            BIGSERIAL PRIMARY KEY,
	bike_id             VARCHAR(32) NOT NULL,
    rental_date         TIMESTAMP NOT NULL,
    rental_office_id    VARCHAR(32) NOT NULL,
    rental_office_name  VARCHAR(256) NOT NULL,
    return_date         TIMESTAMP NOT NULL,
    return_office_id    VARCHAR(32) NOT NULL,
    return_office_name  VARCHAR(256) NOT NULL,
    used_time           INTEGER NOT NULL,
    used_distance       INTEGER NOT NULL
);

delete
from bike_origin
where 자전거번호 is null;

update bike_origin
set 반납대여소명 = split_part(반납대여소명, '. ', 2)
where 반납대여소명 like '%.%';

update bike_origin
set 대여소명 = split_part(대여소명, '. ', 2)
where 대여소명 like '%.%';

update bike_origin
set 대여소번호 = cast(대여소번호 as integer)
where 대여소번호 like '0%';

update bike_origin
set 반납대여소번호 = cast(반납대여소번호 as integer)
where 반납대여소번호 like '0%';

update bike_origin
set 대여소번호 = 0
where 대여소번호 = 대여소명;

update bike_origin
set 반납대여소번호 = 0
where 반납대여소번호 = 반납대여소명;

update bike_origin
set 대여소번호 = 0, 대여소명 = '중랑정비팀'
where 대여소번호 like '%test%';

update bike_origin
set 반납대여소번호 = 0, 반납대여소명 = '중랑정비팀'
where 반납대여소번호 like '%test%';

update bike_origin
set 반납대여소번호 = cast(반납대여소번호 as integer), 대여소번호 = cast(대여소번호 as integer);

update bike_origin
set 대여소명 = trim(대여소명), 반납대여소명 = trim(반납대여소명)

select *
from bike_origin
where 대여소번호 = '2219'
limit 500;

alter table bike_origin rename column 자전거번호 to bike_id;

alter table bike_origin alter column bike_id type varchar(16) using bike_id::varchar(16);

alter table bike_origin rename column 대여일시 to rent_date;

alter table bike_origin alter column rent_date set not null;

alter table bike_origin rename column 대여소번호 to rental_office_id;

alter table bike_origin alter column rental_office_id type integer using rental_office_id::integer;

alter table bike_origin rename column 대여소명 to rental_office_name;

alter table bike_origin alter column rental_office_name type varchar(64) using rental_office_name::varchar(64);

alter table bike_origin rename column 거치대번호 to rests_number;

alter table bike_origin alter column rests_number type integer using rests_number::integer;

alter table bike_origin rename column 반납일시 to return_date;

alter table bike_origin rename column 반납대여소번호 to return_office_id;

alter table bike_origin alter column return_office_id type integer using return_office_id::integer;

alter table bike_origin rename column 반납대여소명 to return_office_name;

alter table bike_origin alter column return_office_name type varchar(64) using return_office_name::varchar(64);

alter table bike_origin rename column "반납 거치대번호" to return_rests_number;

alter table bike_origin alter column return_rests_number type integer using return_rests_number::integer;

alter table bike_origin rename column "이용시간(분)" to "usage_time(minute)";

alter table bike_origin rename column "이용거리(M)" to "usage_distance(meter)";

select *
from bike_origin
limit 1;