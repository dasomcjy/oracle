
--user1 계정으로 접속 : MYDB만 접근 : db_owner <해당 DB의 소유주 : DB에서만 모든 권한>

create database myDB2 ;  --오류 발생

create table a (
	a int IDENTITY(1,1) not null Primary Key,  --a컬럼은 값을 넣으면 안됨 , 자동으로 값이 들어감.
	b int ) ;

insert into a 
values (30) 

select * from a;

--MSSQL은 자동으로 커밋되므로 Update, delete할때 : 명시적으로 트랜잭션을 시작후 사용.


--update 
update a
set b = 50
where a = 2;		-- 

--delete
begin tran			-- 트랜잭션을 명시적으로 시작 begin transaction (이래야 자동커밋이 안됨!)
delete a
where a = 2 ; 


select * from a;

rollback;
commit;

--drop table	
drop table a;






