	--<�ǽ�> user2������ ������ myDB2�� ������ ���̺� ����, �� insert, update, delete, drop table 
	--<SQL ����>���� ���������


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