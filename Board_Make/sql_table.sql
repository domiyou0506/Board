-- 깃허브 제출 sql 파일
use aidev;

create table tb_board(
	b_idx int auto_increment primary key,
    b_userid varchar(20) not null,
    b_name varchar(20) not null,
    b_title varchar(100) not null,
    b_content text not null,
    b_hit int default 0,
    b_regdate datetime default now(),
    b_like int default 0
);

create table tb_reply(
	re_idx int auto_increment primary key,
    re_userid varchar(20) not null,
    re_name varchar(20) not null,
    re_content varchar(2000) not null,
    re_regdate datetime default now(),
    re_boardidx int, 
    foreign key (re_boardidx) references tb_board(b_idx) on update cascade
);	

create table tb_like(
	li_idx int auto_increment primary key,
	li_userid varchar(20) not null,
    li_boardidx int not null,
	foreign key (li_boardidx) references tb_board(b_idx) on delete cascade
) ;

create table tb_b_hit(
	h_idx int auto_increment primary key,
    h_b_idx int not null,
    h_b_userid varchar(20)
);



select * from tb_board;
select * from tb_reply;
select * from tb_like;
select * from tb_b_hit;