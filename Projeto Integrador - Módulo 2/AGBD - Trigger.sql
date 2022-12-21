--- criação de tabela para contagem de alvara por bairro
drop table bairro_alvara
create table bairro_alvara(
bairro varchar (30),
alvara integer
)

insert into bairro_alvara (bairro, alvara)
valueS ('TATUQUARA',0)

--- criação da trigger

CREATE OR REPLACE FUNCTION aumenta_bairro() 
RETURNS TRIGGER AS $$ 
BEGIN 
	UPDATE bairro_alvara
	set alvara=alvara+1 
	where new.bairro=bairro; 
	RETURN NEW; 
END; 
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_aumenta_bairro 
AFTER INSERT ON imovel  
FOR EACH ROW EXECUTE PROCEDURE aumenta_bairro()

--- validação da trigger

select * from bairro_alvara

INSERT INTO imovel (indicacao_fiscal, inscricao_imobiliaria, logradouro, numero, bairro,
grupo_zoneamento, abrangencia, quantidade_pavimento, quantidade_de_unidades_residenciais,
quantidade_unidades_nao_residenciais , numero_alvara )
VALUES (99999995, '99.9.9999.9995','ODIR GOMES DA ROCHA',365,'TATUQUARA',
		'ZR2-ZONA RESIDENCIAL 2','Unidade Regional Tatuquara',2,1,0,500003)

