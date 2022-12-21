--- visao q1
create view q1 as(
select bairro, area_liberada as md_area_liber, data_inicio_obra
	from imovel im, alvara al
where im.numero_alvara =al.numero_alvara )


--- visao q2
create view q2 as(
select nome, bairro, area_liberada as md_area_liber 
from imovel im, alvara al, autor_projeto ap
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au 
)

---visao q3

create view q3 as(
select data_inicio_obra,ap.nome as autor, rt.nome as responsavel, bairro, area_liberada as md_area_liber 
from imovel im, alvara al, autor_projeto ap, responsavel_tecnico rt
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au and
		rt.numero_crea_cau_rt=al.numero_crea_cau_rt and
		extract( year from data_inicio_obra)=2020
)
