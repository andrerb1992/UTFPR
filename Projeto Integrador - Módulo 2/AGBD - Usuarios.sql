--- usuário estagiário tem permissão para consultar a q1

create role estagiario;
GRANT SELECT ON q1 TO estagiario;

--- usuário analista tem permissão para consultar e incluir dados em autor do projeto

create role analista;
grant select on autor_projeto to analista;
grant insert (numero_crea_cau_au, nome) on autor_projeto to analista;

--- usuário engenheiro tem permissão para consultar tabela alvará e atualizar data de conclusão da tabela

Create role engenheiro;
Grant select on alvara to engenheiro;
Grant update (data_conclusao_obra) on alvara to engenheiro
