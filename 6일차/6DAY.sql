/*
    조인, 뷰, 인덱스
*/

/*
    조인( Join ) : 두개 이상의 테이블의 컬럼을 출력시 Join을 사용해서 컬럼의 정보를 가져온다.
      -- employee, department 테이블은 원래 하나의 테이블이었다.
      -- 모델링(중복제거, 성능향상) 을 사용해서 두테이블로 분리되었습니다.
      -- 두 개 이상의 테이블에 컬럼을 가져오기 위해서는 JOIN문을 사용해서 출력
      -- 두 테이블을 JOIN 하기 위해서는 두 테이블에서 공동의 키 컬럼이 존재해야 한다.
      -- Ansi 호환 JOIN : 모든 SQL에서 공통으로 사용하는 JOIN 구문
            Oracle, My_SQL(MariaDB), MS-SQL, IBM DB2, .... <== DBMS
            
*/

select * from employee;
select * from department;

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, <== 오라클에서만 사용. 
    -- ANSI 호환의 SQL 구문에서 INNER JOIN과 같은 구문
        -- 두 테이블에서 공통으로 적용된 값만 출력해줌. <교집합>
        
    -- from 절에 join할 테이블을 명시 , ','를 사용해서 나열 
    -- where 절에 두테이블의 공통의 key 컬럼을 찾아서 ' = '
    -- and 절에서 조건을 처리
    -- 두 테이블의 공통의 키 컬럼을 select 문에 서 출력할때 반드시 테이블명을 명시
        -- 명시하지 않으면 오류 발생 
    
select eno as 사원번호, ename as 사원명, employee.dno as 부서번호 , dname 부서명, loc 부서위치 --department.dno로 해도 값 나옴!
from employee, department           -- 조인할 테이블 나열 : ,
where employee.dno = department.dno -- 두 테이블의 공통의 키 컬럼을 찾아서 : '='로 처리
and  employee.dno >= 20 ;           -- 조건을 처리


--위 구문의 전체 구문을 출력
select employee.eno, employee.ename , employee.dno,
        department.dname, department.loc
from employee, department
where employee.dno = department.dno
and employee.dno >= 20

-- 테이블 이름을 알리어스(별칭) 해서 사용 <== 주로 사용.

select eno, ename, salary , hiredate, e.dno, dname, loc
from employee e , department d      -- 테이블 이름을 별칭 이름으로 사용
where e.dno = d.dno 

-- ANSI 호환의 INNER JOIN <== 모든 SQL 에서 공통으로 사용되는 SQL 구문
    -- Oracle EQUI 조인과 동일한 구문
 -- 두 테이블의 공통인 값만 출력. < 교집합 > 
 -- 주의 : select 절에 공통 키 컬럼을 출력시 테이블을 명시해야한다.
 -- from 절에 :      INNER JOIN 키를 사용해서 JOIN 
 -- on 절에 공통의 키 컬럼을 ' = '로 처리 
 -- where에서 조건을 처리함.
 
 select eno 사원번호 , ename 사원명, e.dno 부서번호, dname 부서명, loc 부서위치
 from employee e INNER JOIN department d   --  INNER JOIN 
 on e.dno = d.dno           -- 두 테이블의 공통의 키 컬럼을 ' = ' 로 처리
 where e.dno >= 20 ;        -- where로 조건을 처리함.
 
 -- 전체 내용 출력
 select e.eno 사원번호 , e.ename 사원명, e.dno 부서번호, d.dname 부서명, d.loc 부서위치
 from employee e INNER JOIN department d   --  INNER JOIN 
 on e.dno = d.dno           -- 두 테이블의 공통의 키 컬럼을 ' = ' 로 처리
 where e.dno >= 20 ;    
 
 -- employee, department 테이블의 사원명과 월급과 입사일, 부서명과, 부서위치 , 부서명을
     -- 출력하되 월급이 2000 이상인 사원만 출력 
 
     -- EQUI JOIN (등가조인)  <== Oracle 에서만 사용됨.
 select ename 사원명, salary 월급, hiredate 입사일, e.dno 부서번호, dname 부서명, loc 부서위치  
 from employee e , department d
 where e.dno = d.dno        -- JOIN시 두 테이블의 공통 키컬럼을 찾아서 where
 and salary >= 2000 ;
     -- ANSI 호환 INNER JOIN문으로 출력 : 모든 SQL에서 공통으로 사용됨.
     
select ename 사원명, salary 월급, hiredate 입사일, e.dno 부서번호, dname 부서명, loc 부서위치      
from employee e INNER JOIN department d
on e.dno = d.dno
where salary >=2000;


-- 두 테이블을 JOIN 해서 부서별 월급의 최대값을 출력 (Employee, Dempartment)
    --부서이름과 부서번호를 출력.
 /*   
select dname 부서이름, e.dno 부서번호 
from employee e INNER JOIN department d
on e.dno = d.dno
group by dno 

select sum(salary) 부서별월급합계, round  (avg(salary)) 부서별월급평균, 
    max(salary) 부서별최대월급, min(salary) 부서별최소월급, dno
from employee
group by dno        
order by dno     


select dname 부서이름, e.dno 부서번호 
from employee e INNER JOIN department d
on e.dno = d.dno
where salary in ( 
        select max(Salary) from employee
        group by dno
);

*/

-- EQUI JOIN 을 사용해서 출력
select dname 부서명, d.dno 부서번호, max (salary) , count(*)
from employee e , department d 
where e.dno = d.dno
group by dname , d.dno

-- ANSI 호환으로 출력
select dname 부서명, d.dno 부서번호, max (salary) , count(*)
from employee e INNER JOIN department d  --INNER JOIN
on e.dno = d.dno                         --ON절에 두 테이블의 공통의 Key 컬럼을 적용   
group by dname , d.dno                   

-- NATURAL JOIN : Oracle 9i 지원 <== Oracle 에서만 지원되는 구문
    -- 두 테이블을 JOIN 시 두 테이블에서 공동의 키 컬럼을 찾아야 한다.
    -- 두 테이블의 공통의 키 컬럼을 Oracle 내부에서 찾아서 처리함.
    -- EQUI JOIN 에서 where절의 두 테이블의 공통의 키 컬럼을 명시하지 않아도 됨. (Where 절없앰)
    -- where 절 생략시 오라클에서 두 테이블의 공통 키 컬럼을 자동으로 찾아줌.
    -- 두 테이블의 공통 키컬럼은 동일한 타입이어야 한다.
    -- select 절에서 공통 키컬럼을 출력시 테이블명을 명시하면 오류 발생됨
    -- from 절에 natural join을 사용함.
    -- where 절에서 조건을 처리
    
 -- NATURAL JOIN을 사용해서 출력하기
 -- 주의 : select 문에서 두 테이블의 공통의 키 컬럼을 출력시 테이블 이름을 명시하면 오류 발생
  
select eno, ename, salary, dno , dname, loc
from employee e NATURAL JOIN department d
where dname = 'SALES' ; 

 -- where 절이 생략되어 자동으로 Oracle 내부에서 key 컬럼을 자동으로 찾음.
 
/*
    select 절에서 두 테이블의 공통의 키 컬럼 출력시
        -- EQUI JOIN (INNER JOIN) -- 반드시 키 컬럼 앞에 테이블명을 명시해야함.
        -- Natural JOIN == 키 컬럼 앞 테이블 이름을 명시하면 오류 발생
*/

-- <문제> 사원이름, 월급, 부서이름, 부서번호 를 출력하되 월급이 2000 이상인 사용자만 출력
-- EQUI JOIN (등가 조인) : Oracle 만 사용
select ename 사원이름 , salary 월급, dname 부서이름, e.dno 부서번호
 from employee e , department d 
 where e.dno = d.dno
 and salary >=2000;

-- Natural JOIN         : Oracle 만 사용 <== 두 테이블의 공통 키 컬럼을 자동으로 ORacle에서 찾음

select ename 사원이름 , salary 월급, dname 부서이름, dno 부서번호
 from employee e NATURAL JOIN department d 
 where salary >=2000;

-- ANSI 호환 ( INNER JOIN) : 모든 SQL 에서 사용 , INNER 는 생략 가능

select ename 사원이름 , salary 월급, dname 부서이름, e.dno 부서번호
 from employee e JOIN department d   -- INNER JOIN (두 테이블의 공통인 값만 출력)
 on e.dno = d.dno
 where salary >=2000;
 
-- NON EQUI JOIN (비등가 조인) : Oracle 에서만 적용 
 -- from 절에 테이블을 , 로 나열   
 -- where 절에 ' = ' 을 사용하지 않는 JOIN 구문  <== 공통키컬럼 없이 JOIN
 
 -- 월급에 대해서 등급을 출력하는 테이블
 select * from salgrade
 where grade between losal and hisal
 
 -- 사원 정보를 출력하는 테이블
 select * from employee;
 
 -- 사원의 부서정보를 저장하는 테이블
 select * from department;
 
 -- NON EQUI JOIN : EQUI JOIN 구문에서 where 절의 공통 키컬럼 없이 JOIN : '='
 -- employee, salgrade 테이블을 JOIN해서 각 사원의 월급의 등급을 출력
 
 select ename, salary, grade 
 from employee e , salgrade s           -- from 절에서 테이블을 ,로 나열됨 (EQUI JOIN)
 where salary between losal and hisal;
 
-- 3개 테이블 JOIN 
-- employee, department , salgrade 테이블을 JOIN해서 
   -- 사원이름, 부서이름, 월급, 월급의 등급 

select ename 사원이름, dname 부서이름, salary 월급, grade 월급의등급 
from employee e, department d, salgrade s
where e.dno = d.dno                     --employee 테이블, department 테이블
and salary between losal and hisal ;


-- 사원번호, 입사일, 부서번호, 월급, 월급의등급, 부서명 
-- employee, department, salgrade 를 JOIN해서 출력

select eno 사원번호, ename 사원이름, e.dno 부서번호 , salary 월급, grade 월급의등급 , dname 부서이름
from employee e, department d, salgrade s
where e.dno = d.dno                     
and salary between losal and hisal ;







    
    




