-- 데이터 베이스 생성, 사용, 삭제 

create database mydb2 ;

show databases ;

use mydb2;

create table test1 (
	a int not null primary key , 
    b char(5) null, 
    c varchar(10)
    );

insert into test1 values (1, 'a', 'b');

select * from test1;

-- 트랜잭션 시작   
start transaction ;
insert into test1 values (3, 'a' ,'b');
rollback ;   -- 세미콜론 빠져도 다음에 바로 오류 생김!
commit ;

-- -----------------------------------
-- 한라인주석 -- 하고 공백주어야 적용된다! 공백없으면 오류발생!
/*
 어러 라인 주석
*/
-- -----------------------------------

CREATE TABLE DEPARTMENT (
	DNO INT PRIMARY KEY,  -- 컬럼에 제약조건 이름을 생략하고 넣을 수 있다. / , constraint PK_dept_dno PRIMARY KEY (dno), / 이렇게!
    DNAME VARCHAR(14),
	LOC   VARCHAR(13) 
	) ;




CREATE TABLE EMPLOYEE (
     ENO INT ,
        CONSTRAINT PK_EMPLOYEE_ENO PRIMARY KEY (eno),
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  INT,
	 HIREDATE DATE,
	 SALARY FLOAT,
	 COMMISSION FLOAT,
	 DNO INT , 
         CONSTRAINT FK_EMPLOYEE_DNO FOREIGN KEY(dno) REFERENCES DEPARTMENT(DNO)
	 );
     
INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');     
     
-- select * from department;     


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
     
select * from employee; 

-- select 구문

/*
	select 컬럼명 별칭이름 
    from 테이블이름 또는 뷰이름
    where 조건
    group by 컬럼명
    having 조건  	  		<-- 그룹핑한 결과에 대한 조건
    order by 컬럼명 			<-- 정렬할 컬럼명
*/    

select eno as 사원번호, ename 사원명, salary 월급 
from employee
order by salary asc ;

-- 집계함수 사용
select sum(salary), avg(salary) , max(salary), min(salary), count(*) , dno
from employee
group by dno
having avg(Salary) >= 2000
order by dno desc ; 

-- JOIN 두 테이블 조인 (INNER JOIN)

select eno , ename , e.dno, dname, loc  
from employee e JOIN department d
on e.dno = d.dno ;

-- JOIN (self JOIN )
-- 사원이름에 대한 상사번호 출력
select e.ename, m.ename
from employee e JOIN employee m
on e.manager = m.eno ;


-- ---------------------------------------------------


create table userTb1 (
	userID char(8) NOT NULL ,
		constraint PK_USERTBL_USERID Primary Key (userID), -- 사용자 ID
	name varchar(10) NOT NULL , -- 이름
	birthYear int NOT NULL,		 -- 생일의 년도 , int : 4byte
	addr char(3) NOT NULL,		 -- 주소 (경기, 서울, 경남 3자리까지만 입력)
	mobile1 char(3),			 -- 핸드폰 (010,)
	mobile2 char(8),			 -- 핸드폰 뒷자리 8자리
	height smallint,			 -- 키	 , smallint : 2byte
	mDate date					 -- 날짜 (회원가입일)	
	);

drop table userTb1;
desc userTb1;

INSERT INTO userTb1 VALUES('LSG', '이승기', 1987, '서울', '011','1111111', 182, '2008-8-8');
INSERT INTO userTb1 VALUES('KBS', '김범수', 1979, '경남', '011','2222222', 173, '2012-4-4');
INSERT INTO userTb1 VALUES('KKH', '김경호', 1971, '전남', '019','3333333', 177, '2007-7-7');
INSERT INTO userTb1 VALUES('JYP', '조용필', 1950, '경기', '011','4444444', 166, '2009-4-4');
INSERT INTO userTb1 VALUES('SSK', '성시경', 1979, '서울', NULL ,NULL , 186, '2013-12-12');
INSERT INTO userTb1 VALUES('LJB', '임재범', 1963, '서울', '016','6666666', 182, '2009-9-9');
INSERT INTO userTb1 VALUES('YJS', '윤종신', 1969, '경남', NULL ,NULL , 170, '2005-5-5');
INSERT INTO userTb1 VALUES('EJW', '은지원', 1972, '경북', '011','8888888', 174, '2014-3-3');
INSERT INTO userTb1 VALUES('JKW', '조관우', 1965, '경기', '018','9999999', 172, '2010-10-10');
INSERT INTO userTb1 VALUES('BBK', '바비킴', 1973, '서울', '010','0000000', 176, '2013-5-5');


-- IDENTITY : MS SQL의 자동 증가 컬럼 , identity (1,1) 
-- auto_increment : MY SQL의 자동증가 컬럼

create table buyTbl (  -- <구매테이블>
	num int  auto_increment NOT NULL ,
		constraint PK_BUYTBL_NUM1 Primary Key (num),
	userID char(8) NOT NULL ,
		constraint FK_BUYTBL_USERID1 Foreign Key (userID) References userTbl(userID),
	prodName nchar(6) NOT NULL ,
	groupName nchar(4) ,
	price int NOT NULL,
	amount smallint NOT NULL
	);

select * from buyTbl;
drop table buyTbl;

INSERT INTO buyTbl(userID, prodName, groupName, price, amount) 
	VALUES('KBS', '운동화', NULL , 30, 2);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('SSK', '책' , '서적', 15, 5);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('EJW', '책' , '서적', 15, 2);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('BBK', '운동화', NULL , 30, 2);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('EJW', '책' , '서적', 15, 1);
INSERT INTO buyTbl (userID, prodName, groupName, price, amount)
	VALUES('BBK', '운동화', NULL , 30, 2);
    
select * from userTb1;	
select * from buyTbl;


-- JOIN (INNER JOIN)   , group by 
-- 이름 , 생일 , 구매물품, 가격, 구매개수를 출력

 select name 이름, birthYear 생년, prodName 구매물품, price 가격
 from userTb1 u left outer JOIN buyTbl b
 on u.userID = b.userID;

-- 구매물품을 그룹핑해서 구매물품별 총구매액을 출력 
 select prodName 구매물품, sum(price) 가격 , count(*)
 from userTb1 u JOIN buyTbl b
 on u.userID = b.userID
 group by prodName;



-- 제일구매액이 많은 사용자
 select name 이름 , sum(price*amount) 총구매액 
 from userTb1 u JOIN buyTbl b
 on u.userID = b.userID
 group by name 
 having sum(price *amount) >= all(select sum(price*amount) 총구매액 
 from userTb1 u JOIN buyTbl b
 on u.userID = b.userID
 group by name );
 

 

-- 물품을 구매하지 않는 사용자

  select name 이름, birthYear 생년, prodName 구매물품, price 가격
 from userTb1 u left outer JOIN buyTbl b
 on u.userID = b.userID
 where prodName is null;
    