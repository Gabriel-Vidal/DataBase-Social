create database amigos;
use amigos;

create table usuario (
id_usuario int primary key auto_increment not null,
nome varchar(50) not null,
idade int not null
);

drop table usuario;

create table post (
id_post int primary key auto_increment not null,
conteudo text,
autor_id int,
foreign key (autor_id) references usuario(id_usuario)
);

create table comentario (
id_comentario int primary key auto_increment not null,
conteudo text,
autor_id int,
post_id int,
foreign key (autor_id) references usuario(id_usuario),
foreign key (post_id) references post(id_post)
);

create table amizade (
usuario_id1 int,
usuario_id2 int,
primary key (usuario_id1, usuario_id2),
foreign key (usuario_id1) references usuario(id_usuario),
foreign key (usuario_id2) references usuario(id_usuario)
);

insert into usuario (id_usuario, nome, idade) values
(1, 'Joao', 20),
(2, 'Pedro', 22),
(3, 'Amanda', 32),
(4, 'Julia', 20);

insert into post (id_post, conteudo, autor_id) values
(1, 'Bom dia, mundo', 2),
(2, 'Foco, força e fé', 3),
(3, 'Que dia incrivel', 1),
(4, 'Mais um semestre concluido!!', 4);

insert into comentario (id_comentario, conteudo, autor_id, post_id) values
(1, 'Bom dia, amigo!', 4, 1),
(2, 'Bora pro fut', 1, 2),
(3, 'Mais um de muitos', 2, 3),
(4, 'Bora pro proximo', 3, 4);

insert into amizade (usuario_id1, usuario_id2) values
(1,2),
(1,3),
(2,3),
(4,1),
(4,2),
(4,3);

select * from post where autor_id = (select id_usuario from usuario where nome = 'Joao');

select * from comentario where post_id = (select id_post from post where conteudo = 'Bom dia, mundo');

select u.nome as usuario, 
       count(distinct p.id_post) as TotalPostagens,
       count(distinct c.id_comentario) as TotalComentarios
from usuario u
left join post p on u.id_usuario = p.autor_id
left join comentario c on u.id_usuario = c.autor_id
group  by u.nome
limit 0, 1000;


select * from amizade
where data_amizade >= CURDATE() - interval 30 day;
