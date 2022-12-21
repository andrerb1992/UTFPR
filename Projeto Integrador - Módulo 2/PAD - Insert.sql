CREATE TABLE autor_projeto(
	numero_crea_cau_au VARCHAR(50)  NOT NULL,
	nome VARCHAR(100),
	PRIMARY KEY (numero_crea_cau_au)
);

CREATE TABLE responsavel_tecnico(
	numero_crea_cau_rt VARCHAR(50) NOT NULL,
	nome VARCHAR(100),
	PRIMARY KEY (numero_crea_cau_rt)
);
-- cria tabela de alvara
CREATE TABLE alvara(
	data_criacao_alvara DATE ,
	data_inicio_obra DATE , 
	data_conclusao_obra DATE, 
	numero_alvara DOUBLE PRECISION NOT NULL, 
	usos_alvara VARCHAR(300), 
	sub_usos_alvara VARCHAR(100),
	finalidade VARCHAR(100), 
	material VARCHAR(100), 
	metragem_area_remanescente DOUBLE PRECISION , 
	metragem_construida_lote DOUBLE PRECISION, 
	numero_de_capacs_utilizadas DOUBLE PRECISION , 
	aca_area_adicional_de_construcao DOUBLE PRECISION , 
	area_liberada DOUBLE PRECISION , 
	metragem_area_reforma_alvara DOUBLE PRECISION , 
	quantidade_blocos_alvara DOUBLE PRECISION, 
	quantidade_sub_solo_alvara VARCHAR(50), 
	numero_crea_cau_rt VARCHAR(50), 
	numero_crea_cau_au VARCHAR(50), 
	firma_construtora VARCHAR(100), 
	numero_cvco DOUBLE PRECISION, 
	tipo_vistoria VARCHAR(100), 
	data_vistoria DATE,	
	CONSTRAINT numero_alvara_pk PRIMARY KEY (numero_alvara),
	CONSTRAINT numero_crea_cau_rt_fk FOREIGN KEY (numero_crea_cau_rt) 
		REFERENCES responsavel_tecnico (numero_crea_cau_rt),
	CONSTRAINT numero_crea_cau_au_fk FOREIGN KEY (numero_crea_cau_au) 
		REFERENCES autor_projeto (numero_crea_cau_au)
);

CREATE TABLE imovel(
	indicacao_fiscal DOUBLE PRECISION NOT NULL,
	inscricao_imobiliaria VARCHAR(50), 
	logradouro VARCHAR(200) , 
	numero DOUBLE PRECISION, 
	bairro VARCHAR(100) , 
	grupo_zoneamento VARCHAR(300), 
	abrangencia VARCHAR(100) , 
	quantidade_pavimento DOUBLE PRECISION, 
	quantidade_de_unidades_residenciais DOUBLE PRECISION, 
	quantidade_unidades_nao_residenciais DOUBLE PRECISION, 
	numero_alvara DOUBLE PRECISION,	
	CONSTRAINT numero_alvara_fk FOREIGN KEY (numero_alvara) 
		REFERENCES alvara (numero_alvara)
);



INSERT INTO autor_projeto ( numero_crea_cau_au , nome )
VALUES ('PR0000195355D',	'ROBERT PLANT'	),
('PR0000195356D',	'JIM MORRISON'	),
('PR0000195357D',	'BRUCE DICKINSON'	),
('PR0000195358D',	'OZZY OSBOURNE'	)


---

INSERT INTO responsavel_tecnico ( numero_crea_cau_rt  , nome )
VALUES ('PR0000195359D',	'STEVEN TYLER'	),
('PR0000195360D',	'MICK JAGGER'	),
('PR0000195361D',	'JOE RAMONE'	),
('PR0000195362D',	'AXL ROSE'	)


--- 

INSERT INTO alvara (data_criacao_alvara , data_inicio_obra ,data_conclusao_obra ,
				   numero_alvara ,usos_alvara ,sub_usos_alvara,finalidade,
				   material,metragem_area_remanescente,metragem_construida_lote,
				   numero_de_capacs_utilizadas, aca_area_adicional_de_construcao,
				   area_liberada, metragem_area_reforma_alvara,quantidade_blocos_alvara,
				   quantidade_sub_solo_alvara,numero_crea_cau_rt,numero_crea_cau_au,
				   firma_construtora,numero_cvco,tipo_vistoria,data_vistoria)
VALUES('2019-01-01', '2019-02-01', '2022-01-20', 500000, 'Habitação Unifamiliar', 'Conjunto Habitacional', 'CONSTRUÇÃO', 'Alvenaria', 500, 300, 0,0, 150,0,0,0,'PR0000195359D','PR0000195355D', 'LED ZEPPELIN CONSTRUCOES', 0,0,'2022-08-20'),
('2020-01-02', '2020-03-02', '2022-01-20', 500001, 'Habitação Unifamiliar', 'ESTACIONAMENTO COMERCIAL', 'REFORMA E AMPLIAÇÃO', 'Alvenaria', 600, 400, 0,0, 250,0,0,0,'PR0000195360D','PR0000195356D', 'THE DOORS CONSTRUCOES', 0,0,'2022-08-20'),
('2021-01-03', '2021-04-03', '2022-05-21', 500002, 'Habitação Unifamiliar', 'Portal de Acesso', 'REFORMA', 'Mista', 700, 500, 0,0, 350,0,0,0,'PR0000195361D','PR0000195357D', 'IRON MAIDEN CONSTRUCOES', 0,0,'2022-08-21'),
('2021-01-04', '2021-04-04', '2022-01-21', 500003, 'Habitação Unifamiliar', 'Cobertura', 'CONSTRUÇÃO', 'Madeira', 800, 600, 0,0, 450,0,0,0,'PR0000195362D','PR0000195358D', 'BLACK SABBATH CONSTRUCOES', 0,0,'2022-08-21')

----

INSERT INTO imovel (indicacao_fiscal, inscricao_imobiliaria, logradouro, numero, bairro,
grupo_zoneamento, abrangencia, quantidade_pavimento, quantidade_de_unidades_residenciais,
quantidade_unidades_nao_residenciais , numero_alvara )
VALUES(99999999, '99.9.9999.9999','BARTOLOMEU LOURENÇO DE GUSMÃO',4809,'BOQUEIRÃO','ZS2-ZONA DE SERVIÇOS 2','Unidade Regional Boqueirão',2,1,0,500000),
(99999998, '99.9.9999.9998','ALFERES ANGELO SAMPAIO',1310,'BATEL','ZR4 - ZONA RESIDENCIAL 4','Unidade Regional Matriz',2,1,0,500001),
(99999997, '99.9.9999.9997','BELÉM',165,'CABRAL','EE-1 - EIXO ESTRUTURAL NORTE','Unidade Regional Matriz',2,1,0,500002),
(99999996, '99.9.9999.9996','AMINTAS DE BARROS',540,'CENTRO','ZR4 - ZONA RESIDENCIAL 4','Unidade Regional Matriz',2,1,0,500003)
