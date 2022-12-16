
--도로명 주소 컬럼
create table zip2 (
    a1 varchar2(100),
    a2 varchar2(100),
    a3 varchar2(100),
    a4 varchar2(100),
    a5 varchar2(100),
    a6 varchar2(100),
    a7 varchar2(100),
    a8 number(4),
    a9 number(4),
    a10 varchar2(100),
    a11 varchar2(100),
    a12 varchar2(100),
    a13 number(5),
    a14 number(5),
    a15 varchar2(100),
    a16 varchar2(100),
    a17 varchar2(100),
    a18 varchar2(500),
    a19 varchar2(100),
    a20 varchar2(100),
    a21 varchar2(100),
    a22 varchar2(500),
    a23 varchar2(500),
    a24 varchar2(500)
    );
    
    select * from zip2;
    select count (*) from zip2 ;  --100만건 --548만건(경기까지)
    
    
    -- 필요한 컬럼만 가져와서 테이블 생성함. 
    select a6 from zip2
    where a6 is not null ;
    
    
    create table zip_use
    as
    select a17, a3, a4, a5, a6, a8 
    from zip2 ;
    
    select * from zip_use ;
    select count (*) from zip_use;
    
    drop table zip_use
    
    