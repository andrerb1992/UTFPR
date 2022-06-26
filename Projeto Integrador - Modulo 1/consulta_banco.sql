--1 consulta envolvendo projeção e seleção
SELECT indicacao_fiscal, logradouro, numero 
FROM imovel
WHERE bairro ILIKE 'BOQUEIR%'

-- 1 consulta que envolva junção externa (LEFT OUTER JOIN ou RIGHT OUTER JOIN ou FULL OUTER JOIN)
SELECT a.numero_alvara, rt.nome 
FROM alvara a LEFT JOIN  responsavel_tecnico rt 
	ON a.numero_crea_cau_rt=rt.numero_crea_cau_rt
	
--1 consulta que envolva pelo menos uma operação de conjunto (UNION ou INTERSECT ou EXCEPT)
SELECT rt.nome FROM responsavel_tecnico rt
UNION
SELECT au.nome FROM autor_projeto au

--1 consulta que envolva divisão relacional
SELECT au.nome
FROM autor_projeto au
WHERE NOT EXISTS
( (SELECT DISTINCT numero_alvara
FROM alvara)
EXCEPT
(SELECT numero_alvara
FROM alvara
WHERE au.numero_crea_cau_au= alvara.numero_crea_cau_au)
)


--1 consulta com operação de agregação e agrupamento (Função de agregação + GROUP BY)
SELECT finalidade, count(alvara), avg(metragem_area_reforma_alvara) 
FROM alvara
WHERE metragem_area_reforma_alvara>0 AND FINALIDADE IS NOT NULL
GROUP BY finalidade



