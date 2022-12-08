
/*
    SQL (structured Query Language) : 구조화된 질의 언어  , (시퀄)
        select 컬럼 
        from 테이블명, 뷰명
        where 조건
        group by 그룹핑할컬럼명
        having 나온결과에 대한 조건
        order by 정렬할컬럼

    DDL (Data Definition Language) : 데이터 정의 언어,  객체를 생성, 수정, 삭제 
            객체(Object) - Table, View, Function, Index, Stroe Procedure, Triger....
        CREATE(생성) , ALTER (수정), DROP (삭제)
        RENAME(객체이름변경), TRUNCATE(레코드 삭제)
    DML (Data Manipulation Language) : 데이터 조작 언어, 레코드를 생성, 수정 삭제
        INSERT (생성), UPDATE (수정), DELETE (삭제) 
        --- 트랜잭션을 발생시킴. commit (DB에 영구저장), rollback (원래 상태로 되돌림) 
    DCL (Data Control Language) : 데이터 제어 언어, 계정에 권한을 부여, 삭제 할때 사용.
        GRANT (권한을 부여), REVOKE (권한을 취소)
        
    DQL (Data Query Language) : 데이터 질의 언어 (출력) : SELECT
    TCL (Transaction Control Language) : 트랜잭션 제어 언어
        BEGIN TRANSACTION    <== 트랜잭션 시작 ( INSERT, UPDATE, DELETE <== DML)
        
        COMMIT              <== 트랜잭션을 종료 ( DataBase에 영구저장 )
        ROLLBACK            <== 트랜잭션을 종료 ( 원래상태로 되돌림, 트랜잭션 시작전 상태로 되돌림)
        SAVEPOINT ( 트랜잭션내의 임시 저장 시점 설정)        
    
*/

--테이블 생성 ( Create Table )

Create Table dept (                        --생성할 테이블 명
    dno number(2) not null,                --컬럼명 자료형 NULL 허용 여부 
    dname varchar2 (4) not null, 
    loc varchar2(13) null
    );
    
--테이블 구조 확인
desc dept ;

--테이블에 값넣기 (INSERT INTO 테이블명 (명시할 컬럼명) values (넣을값);
    --BEGIN TRANSACTION <== 트랜잭션이 자동시작

Begin TRANSACTION
insert into dept (dno, dname, loc) 
values (10, 'ACCO', 'SEOUL') ;

commit ;        -- Data Base 에 영구적으로 저장
rollback ;      -- 트랜잭션 시작 시점으로 되돌려라 // 커밋이나 롤백을 해서 트랜잭션을 끝내야!

--데이터 검색하기
select * from dept;

/* 
    트랜잭션 (TRANCTION) : 작업(일)을 처리하는 최소단위
    -- DML (Insert, Update, Delete 문을 사용하면 자동으로 트랜잭션이 시작됨.
    -- 트랜잭션을 종료하지 않으면 외부에서 다른 사용자가 접근을 못함.
  
    -- 트랜잭션 종료 
         -- commit : DB에 영구저장
         -- rollback : 원래상태로 되돌림
         
    -- 트랜잭션의 4가지 특징
        --원자성 (Atomiciy) : 여러 구분을 하나의 작업 단위로 처리됨
        --일관성 (Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가져야 한다.
        --독립성 (Isolation) : 하나의 트랜잭션이 처리되기 전까지는 다른 트랜잭션과 격리
        --지속성 (Durability) : commit된 트랜잭션은 DB에 영구적으로 저장됨

*/

select *from dept; 

-- 컬럼과 값의 순서가 맞아야 한다.
insert into dept (dno, loc, dname)
values ( 20 ,'PUSAN', 'SALE');

-- 컬럼명을 생략시 값넣기 , 모든 컬럼에 값을 넣어줘야한다.
insert into dept 
values (30, 'abc', 'Taegu');

select *from dept; 
desc dept ;

insert into dept (dno, dname)
values (30, 'abc');

commit;

--회원 정보를 저장하는 테이블 생성 
create table member (
     id varchar2(50) not null primary key, 
     pass varchar2(50) not null ,
     addr varchar2(100) null ,
     phone varchar(30) null ,
     age number (3) not null ,
     weight number (5, 2) not null
     );
     
 /* 제약 조건
    -- Primary key : 테이블에서 하나만 존재할 수 있다.
        --primary key가 적용된 컬럼은 중복된 값을 넣을 수 없다.
        --데이터를 수정할때, 삭제시 조건을 사용하는 컬럼.
        --인덱스가 자동으로 생성된다. <== 검색을 빠르게 할때 사용됨.
        --NuLL을 넣을 수 없다.
        
    -- Unique : 중복된 값을 넣을 수 없다. 테이블에서 여러번 넣을 수 있다.
       -- NULL을 넣을 수 있다. 1번만 넣을 수 있다.
       -- 인덱스가 자동으로 생성된다 <== 검색을 빠르게 함. 
     
    -- check : 값을 넣을때 체크해서 값을 넣는다.
    -- NOT NULL : 컬럼에 NULL을 넣을 수 없다.
    
*/

desc member;

insert into member (id, pass, addr, phone, age, weight)
values ('aaaa', '1234', '서울 종로구 ', '010-1111-1111', 20, 50.55);

select * from member;

-- null 허용 컬럼에 null 넣기
desc member;

insert into member
values ( 'dddd' , '1234', null, null, 30 , 70.557);
commit ; 

insert into member (pass, age, weight, id)
values ( '1234' , 40, 88.888, 'eee' );

-- 수정 (UPDATE) <<== 반드시 where 절을 사용해서 수정해야함.
    -- where 절에 사용되는 컬럼은 중복되지 않는 칼럼을 사용해서 수정 : Primary key, Unique
    /*
     update 테이블명
     set 컬럼명 = 바꿀값, 컬럼명 = 바꿀값
     where 조건 
    */
    
select * from member ;    

update member 
set phone = '010-2222-2222' , age = 55, weight = 90.55
where id = 'bbb'

commit; 

rollback; 

-- update시 중복되는 않는 컬럼의 조건을 주어야한다.
update member
set phone = '010-3333-3333', age = 80
where pass = '1234'

rollback;

update member
set phone = '010-3333-3333', age = 80
where id = 'eee'

commit;

-- delete : 반드시 where 조건을 사용해야 한다. 조건없이 삭제하면 모든 데이터가 삭제됨.
      -- 중복되지 않는 컬럼을 조건에 적용 : primary key, unique 
select * from member;      

delete member 
where id = 'ccc' 

rollback;
commit;

-- 테이블 복사 ( EMP )
create table emp 
as
select * from employee;

-- 복사된 테이블 
select * from emp;

/*
1. 값을 3 레코드 입력, 모든 값 입력 , null이 허용된 컬럼에 null 넣기 
2. update를 사용해서 데이터 수정 , SCOTT의 보너스를 500으로 수정
   영업사원들의 보너스 300만원으로 수정, 
   ward의 부서를 10번으로 수정
   allen의 manager를 7839, 월급을 1800, 입사월 22/01/01로 수정
3. delete : eno 7782 와 eno 7698의 레코드를 삭제

*/

/*Unique 제약 조건 : 중복된 데이터를 넣을 수 없다.
    - NULL을 넣을 수 있다. 1번만 넣을 수 있다. 
    - 테이블에 특정 컬럼에 여러번 넣을 수 있다.
    - 인덱스를 자동으로 생성한다. <= 검색을 아주 빠르게 함.
    - JOIN 시 ON 절, Where 조건
*/

create table customer1 (
    id varchar(20) null primary key,  --  primary key : not null로 지정되어야 함!
    pass varchar(20) not null unique, -- 중복되지 않는 컬럼 (중복된 값을 넣으면 안됨)
    name varchar(20) null unique,     -- null을 허용, 테이블에 여러번 넣을 수 있다.
    phone varchar(20) null unique, 
    addr varchar(20) null 
    );

rollback
select * from customer1

desc customer1;

insert into customer1 (id, pass, name, phone, addr)
values ('bbb', '1235', '홍길동2' , '010-1111-1112' , '서울 종로') ;

--제약 조건 확인하기 
select * from user_constraints
where table_name = 'CUSTOMER1' ;

/* check 제약 조건 : 값을 컬럼에 넣을때 체크해서 값을 넣는다.
*/

-- 테이블 생성시 제약조건의 이름을 부연하면서 테이블 생성
-- 제약조건 이름 생성규칙 : 테이블이름_컬럼명_제약조건유형 
create table emp3 (
    eno number (4) constraint emp3_eno_PK primary key , 
    ename varchar2 (10) ,
    salary number (7,2) constraint emp3_salary_CK check (salary > 0) 
    );

-- emp3테이블에 할당된 제약 조건 확인하기
select * from user_constraints
where table_name = 'EMP3'

insert into emp3 (eno, ename, salary)
values ( 1111, 'smith', 10);

select * from emp3;

create table emp4 (
    eno number (4) constraint emp4_eno_PK primary key , 
    ename varchar2 (10) ,
    salary number (7,2) constraint emp4_salary_CK check (salary > 0) ,
    dno number(2) constraint emp4_dno_CK check(dno in (10,20,30,40))
    );

select * from emp4;

insert into emp4
values ( 3333 , 'scott', 300, 20);

commit;


select * from user_constraints
where table_name = 'EMP4'


/* FOREIGN KEY (참조키) : 다른 테이블(부모)의 Primary key, Unique 컬럼을 참조해서 값을 할당
*/

select * from employee;    -- dno : FK (department 테이블의 dno를 참조)

select * from department;  -- 부모, dno 


insert into employee 
values ( 9999, 'aaaa' , 'aaaa', 7788 , '22/12/08' , 6000, null, 10);

select * from employee;  

rollback;


-- 부모 테이블 생성 : Foreign key가 참조하는 컬럼은 Primary key, Unique 키 컬럼을 참조함

create table parentTbl (
    name varchar2(20) , 
    age number (3) constraint parentTbl_age_CK check ( age > 0 and age < 200),
    gender varchar2 (3) constraint ParentTbl_gender_CK check (gender IN ('M', 'W')),
    infono number constraint ParentTbl_infono_PK primary key
    );
    
 create table ChildTbl (
    id varchar2(40) constraint ChildTbl_id_PK Primary key,
    pw varchar2(40) ,
    infono number , 
    constraint ChildTbl_infono_FK foreign key (infono) references parentTbl(infono)
);

-- 부모 테이블에 값 넣기
insert into parentTbl values ('홍길동', 30, 'M' , 1);
insert into parentTbl values ('김똘똘 ' , 20 , 'M' ,2);
insert into parentTbl values ('원빈', 25, 'M' , 3);
insert into parentTbl values ('홍길순', 40, 'W' , 4);
rollback

select * from ParentTbl;

commit
--자식테이블에 값넣기

insert into ChildTbl values ('aaa', '1234', 1);
insert into ChildTbl values ('bbb', '1234', 2);
insert into ChildTbl values ('ccc', '1234', 2);
insert into ChildTbl values ('ddd', '1234', 4);

select * from ChildTbl ;


/*
    default : 컬럼의 값을 넣지 않을때 default로 설정된 값이 기본적으로 들어간다.
         --제약 조건은 아니어서 제약 조건이름을 할당할 수 없다.  
    */

create table emp5 (
    eno number (4) constraint emp5_eno_PK primary key,
    ename varchar2(10), 
    salary number(7, 2) default 1000  -- 값을 넣지 않으면 default로 설정된 값이 들어감.(default라 넣어도 당연히 설정된 값들어감!)
    );                                             

insert into emp5 (eno, ename)
values ( 4444 , 'aaaa');
commit;

-- 테이블 삭제
drop table member;


select * from emp5;