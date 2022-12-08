

create table tb_zipcode (
     zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key , 
     sido varchar2(30) null ,
     gugum varchar2(30) null ,
     dong varchar(30) null ,
     bungi varchar(30) null 
     );
     
     desc tb_zipcode;
     
     select * from tb_zipcode;
     
     insert into tb_zipcode values ('130', '경기도', '군' , '송내동' , '14') ;
     insert into tb_zipcode values ('140', '경기도', null , '소사' , '15');
     insert into tb_zipcode values ('150', '부천시', null , '성주로' , '16') ;
     insert into tb_zipcode values ('160', '경기도', null , '복사골' , '17') ;
     insert into tb_zipcode values ('170', '경기도', null , '송내동' , '18') ;
 
 create table member (
     id varchar2(20) not null constraint PK_member_id primary key , 
     pwd varchar2(20)  ,
     name varchar2(50)  ,
     zipcode varchar2(7)  ,
     constraint FK_member_id_tb_zipcode foreign key (zipcode) references tb_zipcode (zipcode) ,
     address varchar2(20),
     tel varchar2(13),
     indate date default sysdate
     );

     desc member;
     
     select * from member;
 
   insert into member (id, pwd, name , zipcode, address , tel , indate ) 
   values ( 'fofofo' ,'1234' , 'jason' , '130' , '경기' , '010-1234-1234' , '21/05/02') ;
   
   insert into member (id, pwd, name , zipcode, address , tel  ) 
   values ( 'tatata' ,'1234' , 'hey' , '130' , '경기' , '010-1234-1234' ) ;
 
   insert into member values ( 'lalala' ,'1234' , 'jason' , '130' , '경기' , '010-1234-1234', default ) ;
   insert into member values ( 'hahaha' ,'1234' , 'meme' , '140' , '경기' , '010-1111-1234' , default) ;
   insert into member values ( 'gogogo' ,'1234' , 'lora' , '150' , '경기' , '010-2222-1234' , default) ;
   insert into member values ( 'hohoho' ,'1234' , 'omg' , '160' , '경기' , '010-3333-1234' , default) ;
   insert into member values ( 'hehehe' ,'1234' , 'holy' , '130' , '경기' , '010-4444-1234' , default) ;
   
   
  
 create table products (
     product_code varchar2(20) not null constraint PK_products_product_code primary key , 
     product_name varchar2(100)  ,
     product_kind char(1)  ,
     product_price1 varchar2(10)  ,
     product_price2 varchar2(10),
     product_content varchar2(1000),
     product_image varchar2(50),
     sizeSt varchar2(5),
     sizeEt varchar2(5),
     product_quantity varchar2(5),
     useyn char(1),
     indate date
     );
     
     
     desc products;
     
     select * from products;

      insert into products values ( '10' ,'상품1' , 'A' , '1500' , '2000' , '상품컨텐츠1', '상품사진1' , 'S' , 'E' , '36', 'A' , '22/12/08') ;
      insert into products values ( '20' ,'상품2' , 'B' , '2000' , '2000' , '상품컨텐츠2', '상품사진2' , 'S' , 'E' , '36', 'A' , '22/12/06') ;
      insert into products values ( '30' ,'상품3' , 'C' , '3000' , '4000' , '상품컨텐츠3', '상품사진3' , 'S' , 'E' , '36', 'A' , '22/11/09') ;
      insert into products values ( '40' ,'상품4' , 'D' , '2000' , '1000' , '상품컨텐츠4', '상품사진4' , 'S' , 'E' , '36', 'A' , '22/12/01') ;
      insert into products values ( '50' ,'상품5' , 'E' , '1500' , '2000' , '상품컨텐츠5', '상품사진5' , 'S' , 'E' , '36', 'A' , '22/12/08') ;
      
      
      
        
 create table oders (
     o_seq number(10) not null constraint PK_orders_o_seq primary key , 
     product_code varchar2(20),
     constraint FK_orders_product_code_products foreign key (product_code) references products (product_code) ,
     id varchar2(16)  ,
     constraint FK_orders_id_member foreign key (id) references member(id) ,
     product_size varchar2(5)  ,
     quantity varchar2(5),
     result char(1),
     indate date
     );
     
     desc oders;
     
     select * from oders;

  insert into oders values ( 10 , '10' , 'hahaha' , 's' , '100' , 'o', '22/05/10' ) ;
  insert into oders values ( 20 , '30' , 'lalala' , 's' , '100' , 'o', '22/06/20' ) ;
  insert into oders values ( 30 , '40' , 'gogogo' , 's' , '100' , 'o', '22/06/21' ) ;
  insert into oders values ( 40 , '40' , 'gogogo' , 's' , '100' , 'o', '22/06/21' ) ;
  insert into oders values ( 50 , '40' , 'gogogo' , 's' , '100' , 'o', '22/06/21' ) ;
  
  create table ABC (
     idd varchar(16) ,
     constraint add_idd_member_fk foreign key (idd) references member(id) 
  );
  
  select * from ABC;
  
  insert into ABC values ( 'lalala');
  insert into ABC values ( 'hahaha');
  insert into ABC values ( 'gogogo');
  
  commit;