
--user1 �������� ���� : MYDB�� ���� : db_owner <�ش� DB�� ������ : DB������ ��� ����>

create database myDB2 ;  --���� �߻�

create table a (
	a int IDENTITY(1,1) not null Primary Key,  --a�÷��� ���� ������ �ȵ� , �ڵ����� ���� ��.
	b int ) ;

insert into a 
values (30) 

select * from a;

--MSSQL�� �ڵ����� Ŀ�ԵǹǷ� Update, delete�Ҷ� : ��������� Ʈ������� ������ ���.


--update 
update a
set b = 50
where a = 2;		-- 

--delete
begin tran			-- Ʈ������� ��������� ���� begin transaction (�̷��� �ڵ�Ŀ���� �ȵ�!)
delete a
where a = 2 ; 


select * from a;

rollback;
commit;

--drop table	
drop table a;






