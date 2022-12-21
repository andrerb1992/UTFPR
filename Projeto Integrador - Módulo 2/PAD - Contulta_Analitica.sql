--- q1.1

select bairro, avg(area_liberada) as md_area_liber from imovel im, alvara al
where im.numero_alvara =al.numero_alvara 
group by bairro
order by avg(area_liberada) desc

---q1.2

select bairro, avg(area_liberada) as md_area_liber from imovel im, alvara al
where im.numero_alvara =al.numero_alvara and
	extract( year from data_inicio_obra) between 2020 and 2021
group by bairro
order by avg(area_liberada) desc

---q2.1

select nome, bairro, avg(area_liberada) as md_area_liber 
from imovel im, alvara al, autor_projeto ap
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au 
group by nome, bairro
order by avg(area_liberada) desc

---q2.2

select nome, bairro, avg(area_liberada) as md_area_liber 
from imovel im, alvara al, autor_projeto ap
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au and
		bairro in ('BOQUEIRÃO','CABRAL')
group by nome, bairro
order by avg(area_liberada) desc

---q3.1

select ap.nome as autor, rt.nome as responsavel, bairro, avg(area_liberada) as md_area_liber 
from imovel im, alvara al, autor_projeto ap, responsavel_tecnico rt
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au and
		rt.numero_crea_cau_rt=al.numero_crea_cau_rt and
		extract( year from data_inicio_obra)=2021
group by ap.nome, rt.nome, bairro
order by avg(area_liberada) desc

---q3.2

select ap.nome as autor, rt.nome as responsavel, bairro, avg(area_liberada) as md_area_liber 
from imovel im, alvara al, autor_projeto ap, responsavel_tecnico rt
where im.numero_alvara =al.numero_alvara and
		ap.numero_crea_cau_au =al.numero_crea_cau_au and
		rt.numero_crea_cau_rt=al.numero_crea_cau_rt and
		bairro = 'CENTRO' and
		extract( year from data_inicio_obra)=2021
group by ap.nome, rt.nome, bairro
order by avg(area_liberada) desc