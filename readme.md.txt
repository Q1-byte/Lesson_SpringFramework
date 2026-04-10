create database springdb;

create user 'springdbuser'@'%' identified by '1234';

grant all privileges on springdb.* to 'springdbuser'@'%';




use springdb;

create table tbl_reply(
	rno int auto_increment primary key,
    replyText varchar(500) not null,
    replyer varchar(50) not null,
    replydate timestamp default now(),
	updatedate timestamp default now(),
    delflag boolean default false,
    bno int not null
);

alter table tbl_reply add constraint fk_reply_board foreign key(bno)
references tbl_board(bno);

create index idx_reply_board on tbl_reply(bno desc, rno asc);