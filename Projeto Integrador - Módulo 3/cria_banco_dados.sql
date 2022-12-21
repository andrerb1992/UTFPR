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

