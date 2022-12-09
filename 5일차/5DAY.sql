-- 테이블 수정 (Alter Table)

-- 실습 테이블 복사 <== 원본테이블에 할당된 제약 조건은 복사되어 오지 않는다.
    -- 컬럼명, 자료형, 데이터(레코드)
create table dept20
as
select * from department;

desc department;   -- 원본
desc dept20;       -- 복사본

-- 제약 조건 확인
select * from user_constraints
where table_name = 'DEPARTMENT';

select * from user_constraints
where table_name = 'DEPT20'

-- 1. 기존 테이블에 컬럼 추가 : NULL 을 허용 컬럼을 추가해야함.
select * from dept20; 

-- 기존테이블에 birth 컬럼을 추가
Alter table dept20
add (birth date );   --not null 지정할 수 없음.

Alter table dept20
add (email varchar2 (100) , address varchar2(200), jumin char(13));

/*
    문자열을 저장함.
    char    : 자리수가 지정된 컬럼은 char , 주민번호, 은행비밀번호(4자리), 
           -- 성능이 빠르다, 하드공간을 낭비할 수 있다. 

    varchar2 : 자릿수를 알수 없는 겨우, wnth, email, 
           -- varchar의 성능을 개선해서 만든 ==> varchar2 
           -- char 보다 성능이 떨어진다. 하드 공간 낭비를 줄일 수 있다. 

*/

-- 컬럼에 지정된 자료형 수정
desc dept20;

alter table dept20 
modify email varchar2 (200) ;

alter table dept20
modify loc varchar2 (50);

-- 특정 컬럼 삭제
Alter table dept20
drop column JUMIN ;

Alter table dept20
drop column ADDRESS ;

select * from dept20;

-- 컬럼을 삭제시 레코드가 많을 경우 시스템의 많은 부하가 발생됨
        -- 업무가 없는 야간에 작업. 
        -- 임시적으로 특정컬럼의 사용을 중지후 야간에 작업
        -- SET UNUSED : CPU 부하없이 특정 컬럼을 사용중지
        
Alter Table dept20
set unused (email) ;   -- 임시적으로 email 컬럼을 사용중지

Alter Table dept20     -- unused 된 컬럼을 야간에 삭제
drop unused column;

-- 테이블의 컬럼명 변경 
Alter table dept20
rename column DNO to D_NO ;

desc dept20;

Alter table dept20
rename column DNAME to D_NAME;

-- 테이블 이름 변경 
rename dept20 to dept22;

-- 현재 로그온한 사용자 계정의 모든 테이블 출력
select * from tab;


-- 현재 로그온한 사용자 계정의 모든 테이블 출력 : 데이터 사전을 사용해서 출력
-- 아주 자세한 정보가 출력
select * from user_tables;

/*  데이터 사전 : 관리를 목적으로 객체의 정보를 저장하는 테이블
    객체(Object) : Table, View, Index, Function, Stored Procedure, User , Sequence
    USER_     : 자신이 속한 계정에서 생성한 객체만 출력
    ALL_      : 자신이 속한 계정에서 생성한 객체와 권한을 부여받은 객체 정보를 출력   
    DBA_      : 데이터베이스 관리자만 접근 가능한 객체 정보, sys, system   
  
    select * from user_tables;      // 테이블의 정보
    select * from user_constraints; // 제약조건 정보 출력 <== 컬럼, 
        // NOT NULL, Primary Key, Uniaue, Foreign Key, Check, 
        // default <== 제약 조건이 아니다.
    select * from user_indexes;     //인덱스 정보를 출력 : 테이블의 컬럼에 부여됨.
            //인덱스 (색인, 목차) :  검색을 빠르게 할때 사용됨.
    select * from user_sequences;   //시퀀스 정보 확인:
            //sequence : 컬럼에 값이 자동으로 증가 되게하는 컬럼에 적용되는 객체
            
    select * 
*/

select * from user_tables
where table_name = 'DEPARTMENT'


select * from dba_tables;


-- <<<테이블에 컬럼에 할당된 제약 조건 수정 : << Alter Table >>>> 
select * from user_constraints;

-- 실습할 테이블 복사 : 제약 조건은 복사되지 않는다.
    -- 컬럼명, 자료형, 레코드
create table emp_copy01
as
select * from employee;

create table dept_copy10
as
select * from department;

-- employee 테이블의 제약 조건 확인 
select * from user_constraints
where table_name = 'EMPLOYEE' ;

-- emp_copy01 테이블의 제약 조건 확인

select * from user_constraints
where table_name = 'EMP_COPY01' ;

-- 두 테이블의 제약 조건 확인

select * from user_constraints
where table_name in ( 'EMPLOYEE', 'EMP_COPY01', 'DEPARTMENT','DEPT_COPY10') ;

--Primary Key 할당. (복사한 테이블) , eno 컬럼에 PK(Primary key)
        -- 해당 컬럼에는 NULL 이 존재하면 안됨
        -- 중복된 값이 존재하면 안됨.
select * from emp_copy01; 
select * from dept_copy10;

Alter table emp_copy01
add constraint EMP_COPY01_ENO_PK primary key (eno);

-- Foreign Key ; 부모테이블의 Primary Key, Unique 를 참조함.
  -- dept_copy01 테이블의 dno 컬럼에 primary key 
alter table dept_copy10
add constraint DEPT_COPY_DNO_PK primary key (dno);

-- emp_copy01 테이블의 dno 컬럼에 FK 할당 ===> dept_copy10 (dno)
select * from emp_copy01;
select * from dept_copy10;

--Fk 제약 조건 추가
Alter Table emp_copy01
add constraint EMP_COPY01_DNO_FK foreign key (dno) references dept_copy10(dno);


--
desc emp_copy01;
desc dept_copy10;

select * from emp_copy01; 

--ename 컬럼에 UNIQUE 제약 조건 추가하기
    -- 중복된 값을 넣을 수 없도록 , null을 1번만 넣을 수 있다.
Alter table emp_copy01
add constraint EMP_COPY01_ENAME_UK unique (ename);

-- salary 컬럼에 check 제약 조건 추가 : 월급은 salary >0
Alter table emp_copy01
add constraint EMP_COPY01_SALARY_CK check (salary>0);


-- 특정 컬럼에 NOT NULL 제약 조건 추가 : modify 를 사용함.
    --기존의 컬럼에 NULL이 존재하지 않아야 함.

desc emp_copy01;    
select job from emp_copy01
where job is null;

-- NOT NULL 을 추가할때 modify를 사용함.  
Alter table emp_copy01
modify job constraint EMP_COPY01_JOB_NN not null ;

/*
    제약 조건 제거 : Alter Table 테이블명
                   drop < 제약조건이름> 
        --FK 가 참조하는 테이블의 제약조건을 제거시 FK를 먼저 제거후 해당 테이블의 제약 조건제거
        
*/

-- 기존 테이블의 제약 조건 확인 
select * from user_constraints
where table_name in ('EMP_COPY01', 'DEPT_COPY10');

-- ENO 컬럼의 Primary Key 제약 조건 제거하기 ,
    -- 제약조건이름, primary key   <== 테이블에 1번만 적용되기 때문에
    
  -- ENO 컬럼에 할당된 Primary key 이름으로 제거  
alter table emp_copy01
drop primary key;

-- DNO 컬럼의 할당된 Primary Key 제거하기  <<== FK가 참조하기 때문에 제거가 안됨.
    -- FK를 먼저 제거하고, 제거해야함.
alter table dept_copy10
drop constraint DEPT_COPY_DNO_PK ;

-- 제약조건을 제거하면서 참조하는 FK까지 강제로 함께 제거 : cascade 옵션을 사용
alter table dept_copy10
drop constraint DEPT_COPY_DNO_PK  cascade ;
 
-- FK를 먼저 제거하기
alter table emp_copy01
drop constraint EMP_COPY01_DNO_FK;

--<< 중요 >> : 제약 조건을 제거시 다른 테이블의 FK가 참조 되는 컬럼은 FK를 먼저 제거후 제거해야함.
        --cascade 옵션을 사용하면 참조하는 제약조건과 함께 제거가능
        
-- Unique 제약 조건 제거하기
alter table emp_copy01
drop constraint EMP_COPY01_ENAME_UK ;


-- Check 제약 조건 제거하기
alter table emp_copy01
drop constraint EMP_COPY01_SALARY_CK;

-- Not NULL 제약 조건 제거
alter table emp_copy01
drop constraint EMP_COPY01_JOB_NN;

-- FK가 참조하는 테이블은 삭제가 불가능 
create table emp_copy02 
as
select * from employee
where dno = 20;

create table dept_copy02
as
select * from department;

-- 기존의 복사한 테이블에서 제약조건 추가
-- ENO컬럼에 Primary Key 추가, DNO 컬럼에 FK : dept_copy02 (DNO) 
alter table emp_copy02
add constraint EMP_COPY02_ENO_PK primary key (eno) ;

select * from emp_copy02;
select * from dept_copy02;

select *from emp_copy02

-- Foreign key : DNO : dept_copy02 (dno)
-- FK가 참조할 테이블에 Primary Key 할당.
alter table dept_copy02
add constraint DEPT_COPY02_DNO_pk primary key (dno) ;

-- Foreign key 할당.
alter table emp_copy02
add constraint EMP_COPY02_DNO_FK foreign key (dno) references dept_copy02 (dno);

--두 테이블 (emp_copy02, dept_copy02)제약 조건 확인
select * from user_constraints
where table_name in ('EMP_COPY02', 'DEPT_COPY02');


-- Foreign key 가 참조한느 테이블은 테이블 삭제시 삭제가 안됨. 
-- 자식테이블 (참조테이블 : FK) 테이블을 먼저 제거후 부모테이블을 삭제.
drop table emp_copy02;     --FK 테이블을 먼저 제거후 부모 테이블을 제거할 수 있다.

drop table dept_copy02; 

-- FK가 참조하는 테이블을 강제로 제거 ( cascade constraint purge )

drop table dept_copy02 cascade constraint purge;

drop table emp_copy02; 

-- 제약조건 disable / enable  :  
    -- Bulk Insert (대량의 데이터를 테이블에 넣음) 할때 테이블의 제약조건이 있으면  
    -- 값이 저장되는 시간이 오래 걸린다.

-- 실습 테이블 복사후

create table emp_copy03
as
select eno, ename, job, salary, dno
from employee
where dno = 30;

create table dept_copy03
as
select * from department;

select * from emp_copy03;
select * from dept_copy03;

------------------------------------
-- ENO : Primary Key <== EMP_COPY03
-- DNO : Primary Key <== DEPT_COPY03
-- DNO : Foreign key <== EMP_COPY03

-----------------------------------

alter table emp_copy03
add constraint EMP_COPY03_ENO_PK primary key (ENO) ;
alter table dept_copy03
add constraint DEPT_COPY03_DNO_PK primary key (DNO) ;  --FK가 참조할 컬럼.

alter table emp_copy03
add constraint EMP_COPY03_DNO_FK foreign key (DNO) references dept_copy03(DNO);

-- 제약조건 잠시 임시 중지 하기 : 제약 조건 이름을 사용해서 중지시킴.
select * from user_constraints
where table_name in ('EMP_COPY03' , 'DEPT_COPY03')

alter table emp_copy03
disable constraint EMP_COPY03_ENO_PK ; 

alter table emp_copy03
disable constraint EMP_COPY03_DNO_FK ; 

alter table dept_copy03
disable constraint DEPT_COPY03_DNO_PK ; 

--- 제약 조건 활성화 하기 : enable

alter table emp_copy03
enable constraint EMP_COPY03_ENO_PK ;

alter table dept_copy03
enable constraint DEPT_COPY03_DNO_PK ; 

alter table emp_copy03
enable constraint EMP_COPY03_DNO_FK ; 


---------------------------------------

/*
    Alter Table : 생성된 테이블을 수정
     -- 컬럼을 추가, 제거, 컬럼의 자료형 수정
     -- 제약 조건 추가, 제거 , 수정
*/  

----시퀀스 (SEQUENCE) : 자동번호 발생기 (컬럼의 값을 자동으로 증가시킴)
    -- 고유한 번호가 할당됨. 
    -- 시퀀스를 생성, 테이블의 특정 컬럼에 적용. 
    -- 출력된 시퀀스는 뒤로 되돌아가지 않는다. 
    
create sequence sample_seq
    increment by 10                     -- 증가값 : 10
    start with 10 ;                     -- 초기값 : 10
    
drop sequence sample_seq    
        
create sequence sample_seq1
    increment by 1                      -- 증가값 : 1
    start with 1 ;                      -- 초기값 : 1    



drop sequence sample_seql;

-- 시퀀스 정보 확인
select * from user_sequences;

-- 시퀀스의 다음값 확인 (sample_seq.nextval)
select sample_seq.nextval from dual ;

-- 현재 시퀀스가 가지고 있는 값
select sample_seq.currval from dual ;  -- 처음 시퀀스를 실행하면 오류발생 

-- 생성한 시퀀스를 테이블의 특정 컬럼에 적용

-- 값은 복사하지 않고 테이블만 가져올때 
create table dept30 
as
select * from department 
where 0 = 1 ;               -- where 절이 false 이면 테이블의 레코드를 복사하지 않음.

select * from dept30;

insert into dept30 
values ( sample_seq.nextval , 'ACC1' , 'SEOUL');

select * from dept30;

create table dept40 
as 
select * from department
where 0 = 1;

insert into dept40
values ( sample_seq1.nextval , 'Manager2', 'PUSAN2')
commit;

-- 현재 시퀀스에 할당된 값을 확인
select sample_seq1.currval from dual;

select * from dept40;



-- 3 부터 시작해서 3씩 증가하는 시퀀스를 생성하고 dept50 테이블의 DNO 컬럼에 할당후 출력


create sequence sample_seq2
    increment by 3                    
    start with 3 ;  

create table dept50 
as 
select * from department
where 0 = 1;

insert into dept50
values ( sample_seq2.nextval , 'DNAME', 'LOC');

select * from dept50;

select sample_seq2.currval from dual;

commit;










