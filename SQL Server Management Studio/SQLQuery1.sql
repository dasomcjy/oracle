-- 한줄 주석
/*
 여러줄 주석
*/


-- DataBase 생성 
create database myDB ;

-- DataBase 삭제    :  해당 DB에 접속된 상태에서는 DB삭제 불가능 
drop database myDB;


-- 해당 DataBase 로 접속
use myDB; 

-- tempdb로 이동
use tempdb;


-- 테이블 생성 및 삭제
create table test1 (
	a int not null primary key ,  -- 정수를 넣는 자료형
	b varchar (10) null ,
	c char (10) null 
	);

select * from test1;

drop table test1 ;

-- 값 insert : MSSQL, MYSQL(MariaDB)는 자동 커밋 트랜잭션
-- commit을 명시하지 않아도 자동으로 커밋된다. (DML : Insert, Update, Delete)
insert into test1 ( a, b, c)
values ( 1, 'aaa', 'bbb');

-- 명시적으로 트랜잭션을 시작하면 트랜잭션을 완료해야한다.
begin transaction 
insert into test1 ( a, b, c)
values ( 2, 'ccc', 'ddd');

select * from test1;

rollback;

-------------------------------------------------------------

-- Sample 테이블 생성

DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;


-- 부서 테이블 생성
	-- NUMBER : 오라클의 자료형 정수, 실수 
	-- int    : 정수 (MS_SQL, MYSQL)
	-- float  : 실수 (MS_SQL, MYSQL)

	-- VARCHAR2 : Oracle
	-- VARCHAR  : MSSQL, MYSQL

CREATE TABLE DEPARTMENT (
	DNO INT CONSTRAINT PK_DEPTMENT_DNO PRIMARY KEY,
    DNAME VARCHAR(14),
	LOC   VARCHAR(13) 
	) ;




CREATE TABLE EMPLOYEE (
     ENO INT CONSTRAINT PK_EMPLOYEE_ENO PRIMARY KEY,
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  INT,
	 HIREDATE DATE,
	 SALARY FLOAT,
	 COMMISSION FLOAT,
	 DNO INT CONSTRAINT FK_EMPLOYEE_DNO FOREIGN KEY REFERENCES DEPARTMENT(DNO)
	 );


CREATE TABLE SALGRADE
        (GRADE INT,
	     LOSAL INT,
	     HISAL INT );

-- 값 insert 

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

-- select * from department ;


-- MSSQL에서는 to_Date() 할수가 없다. convert 함수로 날짜 자료형을 변환
 -- select * from employee;

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,'19801217',800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,'19810220',1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,'19810222',1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,'19810402',2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,'19810928',1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,'19810501',2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,'19810609',2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,'19870713',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,'19811117',5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,'19810908',1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,'19870713',1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,'19811203',950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,'19811203',3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,'19820123',1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

select * from SALGRADE 

--commit; 따로 할 필요없이 커밋 완료 됨~ 오히려 커밋하면 오류생김!

select * from department;
select * from employee;
select * from salgrade;


-- 테이블의 정보 출력 :  desc 테이블명 <== Oracle, Mysql, MariaDB
sp_help [DEPARTMENT]; 
sp_help [EMPLOYEE];
sp_help [SALGRADE];

-- select

/*
select 컬럼명
from 테이블명 or 뷰명
where 조건
group by 컬럼
having 조건(group by 결과에 대한 조건)
order by 컬럼명		<== 정렬
*/

select eno as 사원번호, ename 사원명 , salary 월급
from employee
where salary > 2000 and eno in ( 7788, 7839 )

-- 집계함수도 동일 (sum, avg, max, min, count)

--부서별 월급의 합계, 평균, 최대값, 최소값, 그룹핑수
select sum(salary) 합계, avg(salary) 평균, max(salary) 최대값, 
		min(salary) 최소값, count(*) 그룹핑된수 , dno 부서번호
from employee
group by dno
having avg(salary) > 2000

-- insert , update, delete , truncate table : Oracle, MySQL, MSSQL 모두 동일하다.

-- 테이블 복사 : <==오라클과 구문이 다르다.
	-- 제약 조건은 복사되지 않는다.

-- department 테이블의 모든 컬럼과 모든 레코드를 복사

select * into dept_copy		-- dept_copy : 복사할 테이블
from department ;			-- department : 복사할 원본테이블

select * from dept_copy ;

-- employee 테이블의 특정 컬럼과 특정 레코드만 복사
select eno, ename , salary , dno into emp_copy
from employee
where dno = 10 ;

select * from emp_copy;


------------------------------------------------------
-- ANSI JOIN	(INNER JOIN)

-- 사원번호, 사원명, 월급, 부서번호, 부서명 , 부서위치  : employee, department 이너조인
 
 select eno 사원번호 , ename 사원명, salary 월급,  e.dno 부서번호, dname 부서명, loc 부서위치
 from employee e INNER JOIN department d  
 on e.dno = d.dno ;        

 --ANSI SELF JOIN
 --사원이름에 대한 상사이름을 SELF 조인으로 출력 (13)
 select e.ename , m.ename 
 from employee e JOIN employee m
 on e.manager = m.eno


select e.ename 사원이름 , m.ename 직속상관이름 
from employee e INNER JOIN employee m  
on e.manager = m.eno 


 --ANSI SELF JOIN 후 상사가 없는 사원까지 출력 (14개 출력)

select e.ename 사원이름 , m.ename 직속상관이름 
from employee e Left OUTER JOIN employee m  
on e.manager = m.eno 
