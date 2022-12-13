/*
테이블 조인 문제 - 06    : 완료 시간 : 6: 20 
1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오.
2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
3. INNER JOIN을 사용하여 10번 부서에 속하는 
모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
4. NATURAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
5. EQUI 조인과 WildCard ( _ , %)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	각 열(컬럼)에 별칭값을 한글로 넣으시오. 
8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
9. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 

<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
3. 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
4. 평균 급여가 적은 사원의 담당 업무를 찾아 직급과 평균 급여를 표시하시오.
5. 각 부서의 초소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
7. 부하직원이 없는 사원의 이름을 표시 하시오. 
8. 부하직원이 있는 사원의 이름을 표시 하시오. 
9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
16. 평균 급여가 가장 적은 업무를 찾으시오. 
17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
*/

--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오.
select ename 사원명, e.dno 부서번호 , dname 부서명
from employee e, department d         
where e.dno = d.dno 
and  ename = 'SCOTT' ;     

select * from employee
select * from department
--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.

select ename 사원이름, dname 부서이름, loc 지역명
from employee e inner join department d      
on e.dno = d.dno ;


--3. INNER JOIN 사용하여 10번 부서에 속하는 
--모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 

select ename 사원이름, dname 부서이름, loc 지역명 , e.dno 부서번호 
from employee e inner join department d      
on e.dno = d.dno 
where e.dno = 10;

--만약 USING을 사용하면 공통 컬럼 넣어주면 됨

select ename 사원이름, dname 부서이름, loc 지역명 , dno 부서번호 ,job
from employee e inner join department d      
using (dno) 
where dno = 10;


--4. NATURAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 

select  ename 사원이름 , dname 부서이름, loc 지역명 , commission 커밋션
from employee e NATURAL JOIN department d
where commission != 0 ;

select  ename 사원이름 , dname 부서이름, loc 지역명 , commission 커밋션
from employee e NATURAL JOIN department d
where commission is not null;  -- 0인 것까지 출력됨

--5. EQUI 조인과 WildCard ( _ , %)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select ename 사원이름, dname 부서명
from employee e , department d
where e.dno = d.dno
and ename like '%A%';



--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 

select  ename 사원이름 , job 업무 , dno 부서번호 ,dname 부서명, loc 지역명
from employee e NATURAL JOIN department d
where loc = 'NEW YORK';


--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	--각 열(컬럼)에 별칭값을 한글로 넣으시오. 
 
select e.ename 사원이름, e.eno 사원번호 , e.manager 직속관리자번호, m.eno 직속관리자의사원번호 , m.ename 직속상관이름 
from employee e , employee m   
where e.manager = m.eno  


--

select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
from employee e join employee m
on e.manager = m.eno;


select eno, ename, manager, eno, ename , manager
from employee;

select * from employee ;


    
--8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
select e.eno 사원번호, e.ename 사원이름,  m.eno 직속관리자의사원번호 , m.ename 직속상관이름 
from employee e, employee m
where e.manager = m.eno (+)  
order by e.eno desc;

select e.eno 사원번호, e.ename 사원이름,  m.eno 직속관리자의사원번호 , m.ename 직속상관이름 , e.dno, m.dno
from employee e, employee m
where e.manager = m.eno (+)  
order by e.eno desc;


---
-- ANSI 호환
select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
from employee e left outer join employee m
on e.manager = m.eno
order by e.eno desc;

select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
from employee e right outer join employee m
on e.manager = m.eno
order by e.eno desc;

select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
from employee e join employee m
on e.manager = m.eno
order by e.eno desc;

-- EQUI JOIN 으로 처리 

select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
from employee e , employee m
where e.manager = m.eno (+)
order by e.eno desc;


--9. SELF JOIN을 사용하여 지정한 사원의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
   --단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. SCOTT

select e.ename 이름, e.dno 부서번호 , m.ename 동료
from employee e , employee m
where (e.dno = m.dno) and (e.ename = 'SCOTT');

--
select e.ename 이름, e.dno 부서번호, m.ename 동료
from employee e join employee m
on e.dno = m.dno
where e.ename = 'SCOTT';
   

select *from employee


select  e.ename 사원이름, e.dno 사원부서번호, m.ename 직속상관이름 , m.dno 직속상관부서번호
from employee e, employee m
where (e.manager = m.eno) and (e.dno = m.dno)
   
--10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 

select e.ename 사원이름 , e.hiredate 입사일
from employee e, employee m
where (e.ename = m.ename) and (e.hiredate > (select hiredate from employee where ename = 'WARD'))


select e.ename 사원이름 , m.ename , e.hiredate 입사일 , m.hiredate
from employee e, employee m
where hiredate >= hiredate in(select hiredate from employee where ename = 'WARD')   
        
select e.ename 사원이름 , m.ename , e.hiredate 입사일 , m.hiredate
from employee e, employee m
where e.hiredate >= '81/02/22'       

--11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    --단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
    select e.ename 사원이름 , e.hiredate 입사일, m.ename 관리자이름, m.hiredate 입사일
    from employee e, employee m
    where (e.ename = m.ename) and (e.hiredate < all (select hiredate from employee
    where job = 'MANAGER'))
    
    select ename 사원이름, hiredate 입사일 , job
    from employee
    where hiredate < all (select  hiredate from employee
    where job = 'MANAGER');
    
--    


select e.ename 이름, e.hiredate 입사일, m.ename 관리자이름, m.hiredate 관리자입사일
from employee e join employee m
on e.manager = m.eno
where e.hiredate < m.hiredate;    
    
select eno, ename, hiredate , manager , eno, ename, hiredate, manager from employee;     
    
    
    
--    <<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>
--1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
select ename 사원이름 , job 담당업무
from employee
where job = (select job from employee where eno = '7788')

--2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename 사원이름 , job 담당업무 , salary
from employee
where salary > (select salary from employee where eno = '7499')

--3. 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename 사원이름 , job 담당업무 , salary 급여
from employee
where salary = (select min(salary) from employee)

--
select ename 사원이름 , job 담당업무 , salary 급여
from employee
where salary in(select min(salary) from employee)

--4. 평균 급여가 적은 사원의 담당 업무를 찾아 직급과 평균 급여를 표시하시오.

select ename 사원이름 , job 담당업무 , salary 
from employee
where  salary < (select round( avg(salary)) from employee)


--

select min(salary) 급여, job 직급
from employee
group by job
having avg(salary)  <= all (select avg(salary)
                            from employee
                            group by job);
                            
                            
select round(avg(salary)) 급여, job 직급
from employee
group by job
having round(avg(salary))  <= all (select round(avg(salary))
                            from employee
                            group by job);

--5. 각 부서의 초소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.]
select  ename 사원이름 , salary 급여, dno 부서번호
from employee
where salary in (select  min(salary)
                from employee
                group by dno )
                


--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오. ALL
select eno 사원번호, ename 이름, job 담당업무, salary 급여
from employee
where salary < all(select salary from employee where job = 'ANALYST')
               and job <> 'ANALYST'

select * from employee
--7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select ename 이름
from employee
where eno = all (select Manager from employee)


--
select ename
from employee
where eno in (select m.eno
              from employee e right outer join employee m
              on e.manager = m.eno
              where e.eno is null);     
              
--8. 부하직원이 있는 사원의 이름을 표시 하시오. 

select ename
from employee
where eno in (select distinct manager
              from employee);


--9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename 이름 , hiredate 입사일
from employee
where dno = (Select dno from employee where ename = 'BLAKE')
               and ename <> 'BLAKE'

--10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno 사원번호, ename 사원이름 ,salary
from employee
where salary > (select round(avg(Salary)) from employee) 
order by salary asc;

--11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 

select eno 사원번호 , ename 사원이름 , dno
from employee
where dno in (select dno from employee where ename like '%K%')



--12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 

 select ename 사원이름 , loc 부서위치, job 담당업무, e.dno 부서번호
 from employee e , department d 
 where e.dno = d.dno
 and loc = 'DALLAS';
 
 --
select ename 사원이름, dno 부서번호, job 담당업무
from employee
where dno in (select dno
              from department
              where loc = 'DALLAS');
 
select * from department

--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename 사원이름 , salary 급여 , eno , manager
from employee
where manager = (select eno from employee where ename = 'KING')

--14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 

 select ename 사원이름 , loc 부서위치, job 담당업무, e.dno 부서번호 , dname 부서이름
 from employee e , department d 
 where e.dno = d.dno
 and dname = 'RESEARCH';
 
 --
 
 select dno 부서번호, ename 사원이름, job 담당업무
from employee
where dno = (select dno
            from department
            where dname = 'RESEARCH');

--15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno 사원번호, ename 이름, salary 급여
from employee
where dno in (select dno from employee where (ename like '%M%') )
 
salary > round(avg(salary))) 


--
select eno 사원번호, ename 사원이름, salary 급여
from employee
where salary > (select avg(salary)
                from employee)
and dno in (select dno
           from employee
           where ename like '%M%');

--16. 평균 급여가 가장 적은 업무를 찾으시오. 

select job 업무 , salary
from employee
where Salary <= all(select round(avg(Salary)) from employee group by job)


--

select job 업무
from employee
group by job
having avg(salary) <= all (select avg(salary)
                          from employee
                          group by job);

--17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.     

select ename 사원이름 , job, dno
from employee
where dno in (select dno from employee where job = 'MANAGER')


--
select ename 사원이름, dno 부서번호
from employee
where dno in (select dno
            from employee
            where job = 'MANAGER');




