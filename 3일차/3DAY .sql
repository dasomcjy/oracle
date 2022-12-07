--HR 계정으로 접속
show user;

--5. 일반 함수
--NVL , NVL2 , NULLIF , 
--coalesce , 

--NVL 함수 : NULL을 처리하는 함수 
    -- nvl (컬럼명, null을 처리할 값) : 컬럼에 null이 존재할때 값으로 대치
    -- 연봉은 = 월급 * 12 + 보너스 
    -- 보너스 컬럼에 null을 연산하면 null
    
--NVL 함수를 사용해서 총 연봉을 계산    
select ename, salary 월급, commission 보너스 , 
    salary * 12 + nvl (commission,0) as 총연봉
from employee;

--NVL2 함수 : NULL을 처리하는 함수
    -- nvl2 (컬럼명, null이 아닐경우처리, null일경우 처리)
--NVL2 함수를 사용해서 총 연봉 계산
select ename, salary 월급, commission 보너스,
    nvl2 (commission, salary * 12 + commission, salary * 12) 총연봉
from employee;

--nullif 함수 : 두 인자를 비교해서 동일한 경우 NULL을 반환하고 , 
    -- 동일하지 않는 경우 첫번째 표현식을 반환
    -- nullif (expr1, expr2) 

select nullif('A', 'A') , nullif ('A', 'B')
from dual ;

--coalesce 함수
    coalese ( ecpr1, expr2, ecpr3...expr -n) : 
        -- expr1 null 아니면 expr1을 반환
        -- expr1 null 이고 expr2가 null이 아니면 expr2를 반환
        -- expr1 null 이고 expr2가 null이고 expr3가 null이 아니면 expr3를 반환
        
select coalesce ('abc', 'bcd' , 'cde', 'def', 'efg')
from dual; 
    
select coalesce ( null, 'bcd' , 'cde', 'def', 'efg')
from dual; 
    
select coalesce ( null, null , null, 'def', 'efg')
from dual; 
    
--decode 함수 : switch case 문과 동일한 함수
/*
    decode ( 표현식(컬럼명), 조건1, 결과1, 
                조건2, 결과2, 
                조건3, 결과3
                ...
                기본결과n
            )
*/

-- DNO : 부서번호 
--    10 'ACCOUNTING'
--    20 'RESEARCH'
--    30 'SALES'
--    40 'OPERATIONS'
--    'DEFAULT'   
select ename, dno , 
    decode ( dno, 10, 'ACCOUNTING',
        20, 'RESEARCH',
        30, 'SALES',
        40, 'OPERATIONS',
        'DEFAULT') as 부서명                       
from employee ;

--case      : if ~ else if , else if 와 비슷한 구문 
/*
    case WHEN 조건1 THEN 결과1
         WHEN 조건2 THEN 결과2
         WHEN 조건3 THEN 결과3
         ELSE 결과n
    END     
*/

-- 부서번호에 대한 부서명 출력 : case
select ename, dno,
    case when dno = 10 then 'ACCOUNTING'
        when dno = 20 then 'RESEARCH'
        when dno = 30 then 'SALES'
        else 'DEFAULT'
    End as 부서명    
from employee;

--chapter04 : 그룹함수

/*
    그룹함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
        group by 절에 특정 컬럼을 정의할 경우, 해당 컬럼의 동일한 값을 그룹핑해서 연산처리
        
    집계함수 : 연산을 처리하는 함수 
        - SUM : 합계를 구하는 함수
        - AVG : 평균을 구하는 함수
        - MAX : 최대값을 출력
        - MIN : 최소값을 출력
        - COUNT : 레코드수 (한 라인의 값이 저장된) , ROW (행)

        select      컬럼명
        from        테이블명 , 뷰 (가상으로 생성된 테이블)
        where       조건              <==테이블에서 원하는 조건을 가지고 올때
        group by    그룹핑할 컬럼
        having      group by를 사용해서 나온 결과에서 조건을 처리
        order by    정렬
        
*/

-- 집계함수를 컬럼에 사용하면 단일행으로 출력됨.  
select salary as 월급 , 
    SUM (salary) as 합계 , AVG (salary) as 평균, 
    MAX (salary) as 최대월급, MIN(salary) as 최소월급
from employee;  --(오류o)

select  SUM (salary) as 합계 , round (AVG (salary),2) as 평균, 
    MAX (salary) as 최대월급, MIN(salary) as 최소월급
from employee; --(오류x)


-- 집계함수는 NULL을 0으로 자동으로 처리해서 연산
select commission 
from employee;

select SUM(commission), AVG(commission), MAX(commission), MIN(commission)
from employee;

--count 함수 : 레코드수, row(행) 수,
    -- NULL은 카운트되지 않는다.
    

select count (eno) as 레코드수
from employee; --14

select count (manager) as 레코드수
from employee;  --13 (null 1개가 포함되어 있기때문)


-- 보너스를 받는 사원수 : 4명!!
select count (commission)
from employee;

-- 특정 컬럼을 count 함수를 사용하면 전체 레코드 수를 부정확하게 출력할 수 있다.
    -- NOT NULL 정의된 컬럼을 카운트해야 한다. 
desc employee;    

select * from employee;


-- 테이블의 전체 레코드 수를 출력시 : not null 지정된 컬럼이나, * 를 사용해서 count 해야 한다. 
select count (eno) from employee;       -- not null
select count (*) from employee;         -- 모든 컬럼을 카운트 

-- 직업의 갯수를 출력

select count (distinct job) 
from employee;

-- 부서의 갯수 
select count (distinct dno) 부서갯수 , MAX(eno) -- 단일행으로 나오는 값만가능 그냥 eno(다른 컬럼이랑 같이쓰면 오류발생)
from employee;

-- 부서별로 급여의 합계, 평균, 최대값, 최소값 구하기 : group by <== 컬럼에 동일한 값을 그룹핑해서 처리 
select * from employee
order by dno asc; 


select sum(salary) 부서별월급합계, avg(salary) 부서별월급평균, 
    max(salary) 부서별최대월급, min(salary) 부서별최소월급, dno
from employee
group by dno        -- dno컬럼의 동일한 값을 그룹핑
order by dno        







    