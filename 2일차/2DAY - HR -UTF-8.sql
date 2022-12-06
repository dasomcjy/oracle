
-- HR 계정으로 접속한 쿼리 
show user;

-- 현재 접속한 계정에서 모든 테이블을 출력
select * from tab;

-- 각 테이블의 구조 확인 : 컬럼(자료형)
desc employee;
desc department;
desc salgrade;

-- 테이블의 각 컬럼에 저장된 값을 출력
select * 
from employee;

-- 컬럼을 여러번 출력, 연산, 별칭 : 컬럼을 종결, 
select ename as 사원명 , salary 월급 , salary * 12 as "연 봉" 
from employee;

-- 전체 연봉을 출력 : null 값을 처리, nvl (commission, 0)
select ename 사원명, salary * 12 + nvl(commission, 0) as 전체연봉
from employee;

-- IN 연산자 : where 조건에서 사용
select * from employee;

    -- IN 연산자를 사용하지 않고 , commission (보너스) : 300 , 500 , 1400 
    select * from employee
    where commission = 300 or commission = 500 or commission = 1400;
    
    -- IN 연산자를 사용해서 출력
    select * from employee
    where commission IN(300, 500 , 1400);
    
 -- Between A and B      : A와 B 사이의 값을 출력
 -- 입사월이 81/01/01 ~ 81/12/31 까지 입사한 사원들을 출력
 select ename , hiredate
 from employee
 where hiredate >= '81/01/01' and hiredate <= '81/12/31'
 
 select ename , hiredate
 from employee
 where hiredate between '81/01/01' and '81/12/31'
 
 -- Like : 컬럼의 값을 -문자, 문자열을 검색해서 출력할때 사용.
    -- _ : 한글자가 어떤값이 와도 상관없음.
    -- % : 모든 글자를 대치
    
-- 이름이 A로 시작되는 모든 사원을 출력    
select ename 
from employee
where ename like 'A%';

-- 글자 이름에 LL이 들어간 사원 찾기
select ename
from employee
where ename like '%LL%'

--두번째 자릿수에 A 문자가 있는 사원 검색 
select ename , job
from employee
where ename like '_A%'

-- job 컬럼의 MAN이 들어간 내용을 검색하기 
select job
from employee
where job like '%MAN%';

-- 정렬해서 출력하기 : order by 정렬할컬럼 정렬방식  <== select 절에서 제일 마지막에 온다.
    -- asc : 오름차순 : 작은값 --> 큰 값으로 출력, A --> z , << 기본값: 생략가능>>
    -- desc : 내림차순 : 큰값 --> 작은 값으로 출력, z--> A

-- 사원이름을 기준으로 ASC  : 오름차순 정렬
select * from employee
order by ename asc ;

-- asc는 생략 가능 ascㅇ오름차순이 기본!
select * from employee
order by ename ;

-- 내림차순!
select * from employee
order by ename desc ;

--hiredate ( 입사날짜를 기준으로 정렬)
select *
from employee
order by hiredate asc;

--eno (사원번호)를 기준으로 내림차순정렬 (desc) : 큰값 -->작은 값으로 출력
select *
from employee
order by eno desc ;

-- 조건을 적용해서 나온 결과를 정렬해서 출력 하기
-- 81년 입사한 사원만 출력하되 월급이 많은순으로 출력하기
select eno, ename, hiredate, salary 
from employee
where hiredate like '81%'
order by salary desc;


-- 보너스가 없는 사원들만 출력하되 이름을 내림 차순으로 정렬해서 출력
select * from employee
where commission is null  -- 보너스가 없는사원
order by Ename desc;

-- 부서번호(DNO)가 20인 사원이고 월급이 1500 이상인 사원을 출력하되 월급이 많은 순으로 출력
select * 
from employee
where dno = 20 and salary >=1500
order by salary desc;

-- 여러 컬럼을 정렬해야할 경우 : < 게시판 , 질문 답변형 게시판 > 
        --처음의 컬럼을 모두 정렬후 , 같은 값이 존재할 경우 그 컬럼을 뒤에서 정렬

select dno, manager, ename 
from employee
order by dno , manager desc , ename desc ;

-- manager asc 정렬후, enmae 컬럼을 asc 정렬 
select manager, ename
from employee
order by manager desc, ename desc

select * from employee;

--부서별로 월급이 많은 사용자부터 출력
select ename, salary, dno
from employee
order by dno , salary desc ;

select * from employee;

-- 보너스 별로 월급이 많은 순으로 출력 
select ename , commission , salary 
from employee
order by commission desc, salary desc

select * from employee;

--직책별로 입사일이 빠른순으로 출력
select ename ,Job, hiredate
from employee
order by job , hiredate ;

--중복제거후 출력 : distinct  : 중복을 제거할 컬럼앞에 넣는키
        -- select 
-- 회사에 존재하는 직책 : 중복을 제거후 출력        
select distinct job 
from employee
order by job

--회사에 존재하는 부서 : 중복을 제거후 출력
select distinct dno 
from employee 
order by dno 

select * from employee ; 

-- 직속 상관(manager) 을 중복을 제거후 출력 
select distinct manager
from employee
order by manager


-- 오라클에서 기본 제공해주는 함수
-- 1. 문자 처리 함수
-- 2. 숫자 함수 
-- 3. 날짜 함수
-- 4. 변환 함수
-- 5. 일반 함수 

-- 1. 문자 함수
/*
LOWER : 소문자로 변환
UPPER : 대문자로 변환
INITCAP : 첫 글자만 대문자로 나머지는 소문자로 변환 
*/

select 'Oracle mania' as 원본
    , UPPER ('Oracle mania') as 대문자
    , LOWER ('Oracle mania') as 소문자
    , INITCAP ('Oracle mania')as 첫자만대문자
from dual;          --가상의 테이블

select * from employee

-- 값을 가져올때는 대소문자를 구별함.
select * from employee 
where ename = UPPER('smith');


/*
 글자의 길이를 출력해주는 함수
 LENGTH : 글자수를 반환 (한글 1byte)
 LENGTHB : 글자수를 반환 (한글 3byte) < == UTF-8
*/

select length ('Oracle mania') -- 12byte : 12자
    ,length ('오라클 매니아')    -- 7byte  : 7자
 from dual; 
 
 select lengthb ('Oracle mania') -- 12byte : 12자
    ,lengthb ('오라클 매니아')    -- 19byte  : 19자
 from dual; 
 
 select ename, length (ename) as 글자수 , 
                job ,length (job) 글자수
 from employee ;

  
 /*
 CONCAT : 문자열을 연결하는 함수
 SUBSTR : 문자를 잘라주는 함수 (한글 1byte)
 SUBSTRB: 문자를 잘라주는 함수 (한글 3byte)
 INSTR : 특정 문자의 위치값을 반환 (한글 1byte)
 INSTRB : 특정 문자의 위치값을 반환 (한글 3byte)
 LPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽)
 RPAD : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
 TRIM : 공백을 제거
 */
 
 select 'Oracle' , 'mania' , 
    concat('Oracle' , ' mania')
from dual ; 

select substr('Oracle mania' , 4, 3)  -- 4번째 자리에서 3자를 잘라서 출력
   , substrb ('Oracle mania' , 4, 3) 
from dual;    


select substr('오라클 매니아' , 4, 3)  -- 4번째 자리에서 3자를 잘라서 출력 : 한글을 1byte
   , substrb ('오라클 매니아' , 4, 3)  -- 한글을 3byte
from dual;    

select ename , substr (ename, 3, 3) as 잘라온값
from employee

-- instr 해당 문자가 존재하는 위치를 출력
select 'Oracle mania', 
    instr('Oracle mania' , 'a')
 from dual;   

select 'Oracle mania', 
    instr('Oracle mania' , 'a', 4) -- 4번째 자릿수에서 a를 검색 (4번째 부터 검색시작!)
 from dual;   

select ename , 
    instr (ename, 'K' )
from employee;

select ename , 
    instr (ename, UPPER('k') )
from employee;

-- LPAD
select salary, LPAD (salary, 10, '*')
from employee;
