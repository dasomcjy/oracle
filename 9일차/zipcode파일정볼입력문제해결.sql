/*
    tb_zipcode 테이블에 값을 넣을때 문제가 발생, 
        Alter 테이블로 문제를 해결하면서 값을 넣습니다.
    <문제 원인> 
    1. UTF-8 로 엔코딩 변경 처리 엔코딩 문제 처리됨
    2. 원래 설정되어 있는 column BUNGI 의 이름을 데이터에 설정되어 있는 BUNJI 로 바꿈 
    3. 데이터에 있는 zip_Seq 가 없으므로 새로 만들어줌.
    4. 미리 설정되어 있는 'DONG'의 자리값이 30 으로 되어있어 더 길경우 오류가 남 
    5. epk 프라이머리 키 무결성 제약 오류
    
    <문제1> 실제 INSERT 데이터에서 컬럼이 추가되어 있다. ZIP_SEQ
    <문제1 해결> - 필요한 컬럼 추가 (ZIP_SEQ)
    alter table tb_zipcode
    add zip_seq varchar2(50);
    
    <문제2> 컬럼이름이 다르다. BUNGI ==> BUNJI
    <문제2 해결> 
    alter table tb_zipcode 
    rename column bungi to bunji;
    
    <문제3> DONG 컬럼의 자료형이 너무 작다.
    <문제3 해결> : Dong 컬럼의 자료형 수정
    alter table tb_zipcode
    modify dong varchar2(100) ;
    
    <문제4> 무결성 제약 조건 위배 : zipcode 컬럼에 Primary Key 위배 
    select * from user_constraints
    where table_name in ('TB_ZIPCODE') ;
    
    <문제4 해결> : zipcode 컬럼의 Primary Key를 disable , drop 
            member 테이블의 zipcode 컬럼이 참조하므로 cascade 옵션을 사용해야 한다.
      -- disable 시에도 중복을 체크한다 (Oracle 21c)
      
      alter table tb_zipcode
      disable constraint XPK우편번호 cascade ;
      
      -- 제약 조건 제거  :  primary key 제거
      alter table tb_zipcode
      drop constraint XPK우편번호 cascade ;
      
      -- index 제거 
      drop index XPK우편번호 ;
      
      
      select * from user_indexes;  <== tb_zipcode에 할당된 index확인
      
      
      select * from user_constraints
      where table_name in ('TB_ZIPCODE')
    
        
    
    
    
    desc tb_zipcode;
    
    select * from tb_zipcode;

    
    <문제 해결>
    2.alter table tb_zipcode
     RENAME COLUMN BUNGI to BUNJI;
    3.alter table tb_zipcode
      add ZIP_SEQ varchar2(5) ; 
    4.alter table tb_zipcode
      modify DONG varchar2(50); (자리값을 늘려줌)
    5. ALTER TABLE TB_ZIPCODE
       DISABLE CONSTRAINT XPK우편번호;

desc tb_zipcode;

select * from tb_zipcode;  

rollback;

-- 테이블의 모든 레코드 삭제 (deldete, truncate으로 삭제)
    -- delete로 삭제 : 삭제 시간이 오래 걸린다. -- 하나 하나 레코드를 삭제 (포멧)
    -- truncate으로 삭제는 통째로 삭제 ( 빠른 포멧)
    
    delete tb_zipcode ;  --where 조건 없이 삭제는 모든 레코드 삭제 : 주의 / 롤백 가능!

    truncate table tb_zipcode;  --빠르게 삭제됨, 롤백할 수 없다.

rollback;

*/
/*

CREATE TABLE "tb_zipcode" (
	"zipcode"	varchar2(7)		NOT NULL,
	"bungi"	varchar2(30)		NULL,
	"sido"	varchar2(30)		NULL,
	"gugun"	varchar2(30)		NULL,
	"dong"	varchar2(30)		NULL
);

drop table tb_zipcode

alter table tb_zipcode
RENAME COLUMN BUNGI to BUNJI;

alter table tb_zipcode
add ZIP_SEQ varchar2(5) ;

alter table tb_zipcode
modify DONG varchar2(50);

select * from user_constraints

ALTER TABLE TB_ZIPCODE
DISABLE CONSTRAINT XPK우편번호;

Alter table tb_zipcode
Drop Constraint XPK우편번호 cascade

rollback;



*/

select count (*) from tb_zipcode; -- 95408 row (레코드, 행)
select * from tb_zipcode;

-- MS-SQL, MYSQL : 위에서 100개만 출력 , top n 
select rownum, zipcode, sido from tb_zipcode
where rownum <= 100




INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-512', '서울', '강남구', '역삼2동 진달래아파트', '(10∼17동)', '446'); 
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-918', '서울', '강남구', '역삼2동', '706∼707', '447'); 
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-919', '서울', '강남구', '역삼2동', '708∼716', '448'); 
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-920', '서울', '강남구', '역삼2동', '717∼724', '449'); 
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-921', '서울', '강남구', '역삼2동', '725∼730', '450'); 
INSERT INTO tb_zipcode ( ZIPCODE, SIDO, GUGUN, DONG, BUNJI,
ZIP_SEQ ) VALUES ( 
'135-514', '서울', '강남구', '역삼2동', '731∼734', '451'); 