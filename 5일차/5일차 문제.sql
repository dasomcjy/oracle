
create table sale (
    sale_Date date default sysdate not null primary key,
    wine_code varchar2(6) not null,
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar(15) default 0 not null
    );

Alter Table sale
add constraint sale_wine_code_FK foreign key (Wine_code) references  wine (wine_code);    

Alter Table sale
add constraint sale_mem_id_FK foreign key (mem_id) references  member1 (mem_id);        
    


insert into sale values ( '22/12/01' , '1', 'hahaha' ,  '20' , '3000', '5000');
insert into sale values ( default , '2', 'ppp' ,  '30' , '4000', '6000');
insert into sale values ( '22/12/03' , '3', 'sss' ,  '40' , '5000', '7000');
insert into sale values ( '22/12/04' , '5', 'ddd' ,  '50' , '6000', '8000');
insert into sale values ( '22/12/05' , '4', 'hahaha' ,  '60' , '7000', '9000');


select * from sale;







create table member1 (
    mem_id varchar(6) not null primary key,
    mem_grade varchar2(20) ,
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null ,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default 0 not null
    );

Alter Table member1
add constraint member1_mem_grade_FK foreign key (mem_grade) references grade_pt_rade (mem_grade);        
    
    insert into member1 values( 'hahaha' , 30, '1234' , '87/11/09' , '010-1234-1234', '200');
    insert into member1 values( 'ppp' , 90, '1234' , '87/11/01' , '010-1234-1234', default );
    insert into member1 values( 'sss' , 80, '1234' , '87/11/02' , '010-1234-1234', default );
    insert into member1 values( 'ddd' , 20, '1234' , '87/11/03' , '010-1234-1234', '300');
    insert into member1 values( 'fff' , 10, '1234' , '87/11/04' , '010-1234-1234', '100');
    
    
select * from member1;








create table grade_pt_rade (
    mem_grade varchar2(20) not null primary key,
    grade_pt_rate number(3,2)
    );
    
    insert into grade_pt_rade values ('30', 3 );
    insert into grade_pt_rade values ('90', 1 );
    insert into grade_pt_rade values ('80', 2 );
    insert into grade_pt_rade values ('20', 4 );
    insert into grade_pt_rade values ('10', 5 );
    
select * from grade_pt_rade;   








create table today (
    today_code varchar2(6) not null primary key,
    today_sens_value number(3) ,
    today_intell_value number(3),
    today_phy_value number(3)
    );
    
    
    insert into today values ('100' , 1 , 1, 1 );
    insert into today values ('200' , 2 , 2, 2 );
    insert into today values ('300' , 3 , 3, 3 );
    insert into today values ('400' , 4 , 4, 4 );
    insert into today values ('500' , 5 , 5, 5 );


select * from today ;  







create table nation (
    nation_code varchar2(26) not null primary key,
    nation_name varchar2(50) not null
    );

insert into nation values ('ABC' , 'Korea');
insert into nation values ('BCD' , 'USA');
insert into nation values ('CDE' , 'FRANCE');
insert into nation values ('DEF' , 'CHINA');
insert into nation values ('EFG' , 'JAPAN');

select * from nation;







create table wine (
    wine_code varchar2(26) not null primary key,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    wine_type_code varchar2(6),
    wine_sugar_code number(2),
    wine_price number(15) default 0 not null ,
    wine_vintage date,
    theme_code varchar2(6),
    today_code varchar2(6)
    );

insert into wine values ('1' , 'name1', null , 'ABC' , 'A' , 1 ,3000,'10/10/10', '1234' , '100');
insert into wine values ('2' , 'name2', null , 'BCD' , 'B' , 1 ,default ,'10/10/11', '1234' , '200');
insert into wine values ('3' , 'name3', null , 'CDE' , 'C' , 1 ,4000,'10/10/12', '5678' , '300');
insert into wine values ('4' , 'name4', null , 'DEF' , 'D' , 1 ,5000,'10/10/13', '1234' , '400');
insert into wine values ('5' , 'name5', null , 'EFG' , 'E' , 1 ,3000,'10/10/14', '1234' , '500');


Alter Table wine
add constraint wine_nation_code_FK foreign key (nation_code) references nation (nation_code);

Alter Table wine
add constraint wine_wine_type_code_FK foreign key (wine_type_code) references wine_type (wine_type_code);        

Alter Table wine
add constraint wine_theme_code_FK foreign key (theme_code) references theme (theme_code);        

Alter Table wine
add constraint wine_today_code_FK foreign key (today_code) references today (today_code);        

select * from wine;

drop table wine cascade constraint purge;



create table theme (
    theme_code varchar2(6) not null primary key,
    theme_name varchar2(50) not null
    );

insert into theme values( '1234' , 'theme1');
insert into theme values( '5678' , 'theme2');
insert into theme values( '9123' , 'theme3');
insert into theme values( '4567' , 'theme4');
insert into theme values( '8912' , 'theme5');

select * from theme;









create table stock_management (
    stock_code varchar2(6) not null primary key,
    wine_code varchar2(6),
    manager_id varchar2(30),
    ware_date date default sysdate not null ,
    stock_amount number(5) default 0 not null
    );

Alter Table stock_management
add constraint stock_management_wine_code_FK foreign key (wine_code) references wine (wine_code);        

Alter Table stock_management
add constraint stock_management_manager_id_FK foreign key (manager_id) references manager (manager_id);        

 
insert into stock_management values ( 'A' , '1' , 'gogogo', default , default);
insert into stock_management values ( 'B' , '2' , 'gogogo', '87/11/09' , 5);
insert into stock_management values ( 'C' , '3' , 'gogogo', '87/11/10' , 6);
insert into stock_management values ( 'D' , '4' , 'gogogo', '22/09/11' , 7);
insert into stock_management values ( 'E' , '5' , 'gogogo', '22/10/18' , 8);


select * from stock_management ;









create table manager (
    manager_id varchar2(30) not null primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );

    insert into manager values ('hehehe' , '1234' , '010-1234-1234');
    insert into manager values ('gogogo' , '1235' , '010-1234-1231');    
    insert into manager values ('hohoho' , '1236' , '010-1234-1232');    
    insert into manager values ('lalala' , '1237' , '010-1234-1233');    
    insert into manager values ('mamama' , '1238' , '010-1234-1235');


select * from manager ;





create table wine_type(
    wine_type_code varchar(6) not null primary key,
    wine_type_name varchar(50)
    );

    insert into wine_type values ('A' ,'A1');
    insert into wine_type values ('B' ,'B1');
    insert into wine_type values ('C' ,'C1');
    insert into wine_type values ('D' ,'D1');
    insert into wine_type values ('E' ,'E1');
    
select * from wine_type ;


commit;