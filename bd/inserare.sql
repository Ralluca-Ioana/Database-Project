insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(101, 'Muzeul de Artă', 100, 35, 73);
insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(102, 'Muzeul de Istorie', 120, 25, 60);
insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(103, 'Muzeul Tiparului şi al Cărţii Româneşti Vechi', 160, 40, 44);

insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(104, 'Muzeul Scriitorilor Dâmboviţeni', 90, 27, 24);
insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(105, 'Casa - atelier Gheorghe Petraşcu', 70, 10, 20);
insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(106, 'Muzeul Evolutiei Omului', 80, 10, 15);

insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(107, 'Ansamblul Brâncovenesc Potlogi', 60, 20, 40);
insert into bilet (id_muzeu, nume, durataVizionare, pret, stoc) values
(108, 'Muzeul de Etnografie şi Folclor Pucioasa', 120, 23, 45);

insert into comanda(id_comanda, numarBilete, totalComanda, bilet_id_muzeu, cos_id_cos)
values(1, 2, 60, 101, 1);
insert into comanda(id_comanda, numarBilete, totalComanda, bilet_id_muzeu, cos_id_cos)
values(2, 4, 70, 101, 1);
insert into comanda(id_comanda, numarBilete, totalComanda, bilet_id_muzeu, cos_id_cos)
values(3, 3, 77, 106, 2);


insert into client (id_user, nume, email, parola) values 
(1, 'raluca', 'ralucab@yahoo.com', 'parola1');
insert into client (id_user, nume, email, parola) values 
(2, 'adrian', 'adrianp@gmail.com', 'parola2');


insert into cos (id_cos, client_id_user) values (1, 1);
insert into cos (id_cos, client_id_user) values (2, 1);
insert into cos (id_cos, client_id_user) values (3, 2);
insert into cos (id_cos, client_id_user) values (4, 2);


