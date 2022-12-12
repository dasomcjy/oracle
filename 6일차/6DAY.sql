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

/*
        INNER JOIN : 90% , 두 테이블에서 공통의 내용을 출력 ( e.dno = d.dno )
         -- EQUI JOIN, Natural JOIN: Oracle
         -- INNER JOIN : ANSI 호환 ( 모든 DBMS 에서 공통으로 사용되는 구문)
*/

/* SELF JOIN : 자신의 테이블(원본)을 다시한번 가상의 테이블(원본을 복사한 테이블) JOIN 함.
        -- 자신의 테이블을 다시한번 조인 
        -- 반드시 테이블을 별칭이름을 만들고 별칭이름을 사용해서 JOIN
        -- 회사의 조직도를 SQL 구문으로 출력할때, 직급 상사가 누군지 출력할때 주로사용.
*/

-- 관리자(직속상관)가 7788인 사원들 정보  eno, ename, manager 
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where manager = 7788
order by ename asc;

-- 직속상관의 정보를 출력 
select eno 사원번호, ename 사원명 , manager 직속상관
from employee 
where eno = 7788;


--

select * from employee;

-- SELF JOIN 을 사용해서 자신의 테이블을 JOIN해서 사원에 대한 직속상관 정보를 한번에 출력

-- EQUIE JOIN을 사용해서 SELF JOIN 출력

select e.ename 사원이름, e.manager 직속상관번호, m.eno 직속상관번호 , m.ename 직속상관이름 
from employee e , employee m   -- 두 테이블 모두 employee 테이블 , 반드시 별칭이름을 사용해야함!!(약칭)
where e.manager = m.eno 
order by e.ename asc;


select eno , ename , manager , eno, ename, manager
from employee; 


select * from employee
order by ename asc;


-- ANSI 호환 구문을 사용해서 SELF JOIN 
-- employee 테이블을 SELF JOIN해서 사워에 대한 직속 상관을 출력 
select e.ename || ' 의 직속 상관은 '   ||  m.ename || '입니다' 
from employee e INNER JOIN employee m  --INNER는 생략가능
on e.manager = m.eno 
order by e.ename asc;

select eno, ename, manager , eno, ename, manager
from employee;

select * from employee;    

/* Outer JOIN : 
     -- 특정 컬럼의 내용은 두 테이블에 공통적이지 않는 내용도 출력해야 할때 
     -- NULL 출력 
     -- + 를 사용해서 Outer Join : Oracle 
     -- Ansi 호환 구문을 사용할 때는 : Outer Join 구문을 사용함.
            -- LEFT OUTER JOIN , LEFT JOIN
            -- RIGHT OUTER JOIN, RIGHT JOIN
            -- FULL OUTER JOIN, FULL JOIN
*/

-- EQUI JOIN 을 사용하여 INNER JOIN 

select e.ename || ' 의 직속 상관은  ' || m.ename || '입니다.'
from employee e, employee m
where e.manager = m.eno  -- e.manager와 m.eno의 값이 일치하는 내용만 출력됨. (13개 레코드출력)


-- EQUI JOIN 을 사용하여 Outer JOIN       
select e.ename || ' 의 직속 상관은  ' || m.ename || '입니다.'
from employee e, employee m
where e.manager = m.eno (+)    -- m.eno  컬럼의 내용은 e.manager의 값이 없더라도 무조건 출력
   
select eno, ename , manager , eno, ename, manager 
from employee ;

-- ANSI 호환에서 Outer JOIN 
    -- LEFT OUTER JOIN , LEFT JOIN     : 왼쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- RIGTH OUTER JOIN , RIGHT JOIN   : 오른쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- FULL OUTER JOIN , FULL JOIN     : 왼쪽, 오른쪽 모두 매칭되지 않는 내용도 무조건 출력
    
  select e.ename || ' 의 직속 상관은  ' || m.ename || '입니다'
  from employee e Left OUTER JOIN employee m  -- Outer은 생략해도 됨!
  on e.manager = m.eno 
  order by e.ename asc ; 
  
  select e.ename || ' 의 직속 상관은  ' || m.ename || '입니다'
  from employee e RIGHT Outer JOIN employee m
  on e.manager = m.eno 
  order by e.ename asc ; 

  select e.ename || ' 의 직속 상관은  ' || m.ename || '입니다'
  from employee e FULL Outer JOIN employee m
  on e.manager = m.eno 
  order by e.ename asc ; 
  
  /* 카디시안 곱 : 왼쪽 테이블의 하나의 레코드에서 오른쪽 테이블의 모든 레코드를 곱하다.
    employee : 14
    department : 4
    카디시안 곱 : 14 * 4 = 56 레코드 출력
  */

select count (*) from employee;
select count (*) from department;

-- employee(14) , department (4) 카디시안 곱 : 56
select * 
from employee , department 


-- employee(14) , department (4) 카디시안 곱 : 56

-- INNER JOIN : e.dno = d.dno 가 매칭되는 내용만 출력
    -- EQUI JOIN : Oracle 구문으로 출력
select *
from employee e, department d 
where e.dno = d.dno (+)


