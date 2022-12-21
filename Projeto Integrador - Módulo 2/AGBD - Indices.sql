explain  analyze
select * from q1
where extract(year from data_inicio_obra) = 2017

create index idxnumero_alvara on alvara (numero_alvara)
analyze alvara

drop index idxuso

create extension pg_trgm
create index idxuso on alvara using gin(usos_alvara gin_trgm_ops)

explain  analyze
select * from q1
where bairro = 'BOQUEIRÃO'

drop index  idxbairro

create extension btree_gin
create index idxbairro on imovel using gin(bairro)

