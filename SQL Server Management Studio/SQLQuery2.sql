	--<실습> user2계정을 생성후 myDB2만 접속후 테이블 생성, 값 insert, update, delete, drop table 
	--<SQL 인증>으로 계정만들기


	create table b (
	c int IDENTITY(1,1) not null Primary Key,  
	d int ) ;

insert into b
values (10) 

insert into b
values (20) 

insert into b
values (30) 

delete b

rollback;

select * from b;

drop table b;


begin tran			
delete b
where c = 10 ; 