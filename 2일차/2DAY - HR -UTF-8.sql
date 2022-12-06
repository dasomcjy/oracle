
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

-- LPAD : 10자리로 처리, 왼쪽을 *로처리
select salary, LPAD (salary, 10, '*') -- salary 컬럼의 값을 10자리로 표현 비어있는 공백*
from employee;

--RPAD : 10자리로 처리, 오른쪽을 *로처리
select salary, RPAD (salary, 10, '*') -- salary 컬럼의 값을 10자리로 표현 비어있는 공백*
from employee;

--TRIM : 앞뒤의 공백을 제거 
select '       Oracle mania        ' as  원본 ,
    trim ('       Oracle mania       ') as 공백제거
from dual ;    






-- <<문제풀이 완료>>

---2. 숫자 함수
/*

ROUND : 특정 자릿수에서 반올림.
    ROUND (대상) : 소수점 뒷자리에서 반올림
    ROUND (대상, 소수점자릿수) :
        -- 양수일때 : 소수점을 기준으로 오른쪽으로 이동해서 그 뒷자리에서 반올림 <== 주의
        -- 음수일때 : 소수점을 기준으로 왼쪽으로 이동하고 그 자리에서 반올림
                -- 정수를 반올림. 그 뒤는 모두 버림 
TRUNC : 특정 자릿수에서 잘라냄.
MOD : 입력받은 수를 나누고 나머지 값만 반환

*/

select 98.7654 as 원본,
    round (98.7654),            --99
    round (98.7654, 2),         --98.77    소수점기준으로 오른쪽으로 2자리이동후 뒤에서 반올림    
    round (98.7654, -1),        --100      소수점기준으로 왼쪽으로 이동후 그 자리에서 반올림
    round (98.7654, -2),        --100   
    round (98.7654, -3),        -- 0
    round (98.7654, 3)          -- 98.765
from dual;

select 12345.789 as 원본,
    round (12345.6789) ,
    round (12345.6789, -3),
    round (12345.6789, 3)
from dual;

----TRUNC : 잘라서 버림.
select 98.7654 as 원본, 
    trunc (98.7654),        -- 소수점 뒤로 없앰.
    trunc (98.7654, 2),     -- 98.76     
    trunc (98.7654, -1)     -- 90
from dual;    

-- MOD ( 대상, 나누는수) : 대상을 나누는 수로 나누어서 나머지  
select mod (31, 2) , mod (31, 5) , mod (31, 8)
from dual; 

select * from employee;

-- eno (사원번호) 가 짝수인 사원만 출력
select eno, ename
from employee
where mod(eno,2) = 0;   --조건에 

-- eno (사원번호) 가 홀수인 사원만 출력
select eno, ename
from employee
where mod(eno,2) = 1;   --조건에 


/* 
    날짜 함수
    sysdate : 현재 시스템의 날짜와 시간을 출력
    months_between : 두 날짜 사이의 개월수를 출력
    add_months : 특정 날짜에 개월수를 더할때 
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짤를 반환
    Last_day : 달의 마지막 날짜를 반환
    round : 날짜를 반올림 , 15일 이상은 반올림, 15일 미만은 버림.
    trunc : 날짜를 버림
    
*/
--sysdate : 현재 날짜를 출력
select sysdate
from dual; 

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate + 1 as 내일날짜
from dual;

select hiredate as 입사날짜, hiredate -1 , hiredate + 10
from employee;

-- 입사일에서 현재까지의 근무일수 구하기 
select round (sysdate - hiredate) as "총근무일수"
from employee; 

select round ((sysdate - hiredate), 2) as "총근무일수"
from employee; 

select trunc (sysdate - hiredate) as "총근무일수" 
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버리기 , 월은 출력하되 날짜는 모두 버림 , 01 로 잡힘

select hiredate as 원본, trunc (hiredate, 'MONTH')
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 반올림 하기, 15일 이상은 반올림, 15일 미만은 버림.

select hiredate as 원본, round (hiredate, 'MONTH')
from employee;


-- month_between(date1, date2) : 두 날짜사이의 개월수를 출력

-- 입사일에서 현재까지 몇개월간 근무했는지 출력
select ename, hiredate, months_between( sysdate, hiredate) as 근무개월수
from employee;

select ename, hiredate, trunc(months_between( sysdate, hiredate)) as 근무개월수
from employee;

-- add_month (date1, 개월수) : date1 에 개월수를 더해서 출력

-- 입사후 6개월이 지난 시점을 출력
select hiredate, add_months (hiredate, 6)
from employee;

-- 입사후 100일이 지난 시점의 날짜.
select hiredate, hiredate + 100 as "입사후100일시점"
from employee; 

-- next_day (date, 요일) : date의 도래하는 요일을 출력
-- 오늘 날짜에서 도래하는 토요일의 날짜는 몇일인지 출력
select sysdate, next_day (sysdate, '토요일') 
from dual; 

-- last_day (date) : date에 월의 마지막 날짜를 출력

select hiredate, last_day (hiredate) as 월의마지막날짜
from employee;

/* 형 변환 함수      <== 중요함
  TO_CHAR : 날짜형 숫자형을 문자형으로 변환하는 함수
  TO_DATE : 문자형을 날짜형으로 변환하는 함수
  TO_NUMBER : 문자혀을 숫자로 변환하는 함수
*/


-- TO_CHAR(date, 'YYYYMMDD') : 날짜 형식을 'YYYYMMDD' 형식으로 출력시 char 타입으로 변환해서 출력
    -- YYYY : 년도 
    -- MM : 월
    -- DD : 일
    
    -- DAY : 요일 길게 (월요일)
    -- DY : 요일(월, 화)
    
    -- HH : 시간 
    -- MI : 분
    -- ss : 초

select ename, hiredate, to_char(hiredate, 'YYYYMMDD') , to_char(hiredate, 'YY-MM/DD'),
    to_char (hiredate, 'YYYY--MM--DD DAY'),
    to_char (hiredate, 'YYYY-MM-DD DY HH:MI:SS')
from employee;

-- 현재 시스템의 오늘 날짜를 출력하되 시간 : 분 : 초 요일까지 출력

select sysdate, to_char(sysdate , 'YYYY-MM-DD HH:MI:SS DY')
from dual; 

/* 
   to_char : 숫자를 char 형식으로 변환
    0 : 자릿수를 나타내고 자릿수가 맞지 않으면 0으로 채움.
    9 : 자릿수를 나타내고 자릿수가 맞지 않으면 빈칸으로 채움.
    L : 각 지역의 통화 기호를 출력
    . : 소수점으로 표현
    , : 천단위 구분자  
*/

--salary : NUMBER(숫자) ==> char (문자)
desc employee;

select ename, salary, to_char(salary, 'L999,999'), to_char(salary, 'L000,000')
from employee;

-- to_date ('char', 'format') : char (문자) ==> 날짜형식으로 변환
-- to_date (number, 'format') : 숫자를 ==> 날짜형식으로 변환

select sysdate , 
    sysdate - 20000101       -- sysdate : date, 20000101 : Number
from dual;

-- 2000년 1월 1일 에서 오늘 날짜까지의 일수 
select sysdate , 
    sysdate - to_date(20000101, 'YYYYMMDD')       -- sysdate : date, 20000101 : Number
from dual;

-- 두 포멧 방식이 맞지 않아서 오류 발생
select sysdate, 
    sysdate - '2000-01-01'     -- 날짜 - 문자  <== 두 타입을 맞춤어야한다.
 from dual;  
 
 select sysdate, 
    sysdate - to_date ('2000-01-01', 'YYYY-MM-DD')
 from dual;  
 
 -- 2000년 1월 1일부터 2022년 2월 10일까지의 지난 날짜 계산하기
 -- '02/10/22' : 22년 02월 10일을 date 형식으로 바꿈.  '2000/01/01' 

select to_date ('12/06/22', 'MM/DD/YY') - to_date('2000/01/01', 'YYYY/MM/DD')
from dual ; 

select trunc(sysdate - to_date ( 20000101, 'YYYYMMDD'))
from dual ;


-- employee 테이블에서 81년 2월 22일 입사한 사원을 검색하는데
    -- '02-22-1981' 문자열 포멧을 date형식으로 변환해서 검색
        
select ename, hiredate
from employee
where hiredate = to_date('02-22-1981', 'MM-DD-YYYY')

-- 2000년 12월 25일부터 오늘까지 총 몇달이 지났는지 출력, 소수점이하는 모두 잘라내기, sysdate

select trunc (months_between (sysdate, to_date('2000/12/25', 'YYYY/MM/DD'))) as 달의차
from dual;


