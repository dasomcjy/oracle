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

--1. 값을 3 레코드 입력, 모든 값 입력 , null이 허용된 컬럼에 null 넣기 
desc emp;

select * from emp;

insert into emp  
values (7935, 'LOLANG', 'CLERK' , 7902 , '87/11/09' , 2000 , 200 , 20) ;

insert into emp  
values (7936, 'VISITOR', 'SALESMAN' , null , null , 1500 , null , 10) ;

insert into emp  
values (7936, 'velele', 'MANAGER' , 7839 , null , null , null , 30) ;


/*2. update를 사용해서 데이터 수정 , SCOTT의 보너스를 500으로 수정
   영업사원들의 보너스 300만원으로 수정, 
   ward의 부서를 10번으로 수정
   allen의 manager를 7839, 월급을 1800, 입사월 22/01/01로 수정
   */
select * from emp;

update emp
set COMMISSION = 500
where ENAME = 'SCOTT'   

update emp
set commission = 300
where job = 'SALESMAN'

update emp
set dno = 10
where ename = 'WARD'
 
update emp 
set manager = 7839, salary = 1800 , hiredate = '22/01/01'
where ename = 'ALLEN'

commit
--3. delete : eno 7782 와 eno 7698의 레코드를 삭제

delete emp
where eno = 7782

delete emp
where eno = 7698

rollback
