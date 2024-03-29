#carregar pacotes utilizados
library(readxl)
library(tidyverse)

#abrir as planilhas
alvara2017<-read_excel(".../RelatorioMensal_ALV_JAN_DEZ2017.xlsx", sheet="RelatorioMensal_ALV_JAN_DEZ2017")
alvara2018<-read_excel(".../RelatorioMensal_ALV_JAN_DEZ2018.xlsx", sheet="RelatorioMensal_ALV_JAN_DEZ2018")
alvara2019<-read_excel(".../RelatorioMensal_ALV_JAN_DEZ2019.xlsx", sheet="RelatorioMensal_ALV_JAN_DEZ2019")
alvara2020<-read_excel(".../RelatorioMensal_ALV_JAN_DEZ2020.xlsx", sheet="RelatorioMensal_ALV_JAN_DEZ2020")
alvara2021<-read_excel(".../RelatorioMensal_ALV_JAN_DEZ2021.xlsx", sheet="RelatorioMensal_ALV_JAN_DEZ2021")

#uni�o dos arquivos em uma tabela �nica
alvara2017_2021_0<-rbind(alvara2017,alvara2018,alvara2019,alvara2020,alvara2021)

#transforma os atributos que contem registro de data e est�o no tipo caracter para tipo data
alvara2017_2021_1<-mutate(alvara2017_2021_0,
                `Data Cria��o Alvar�`=str_sub(`Data Cria��o Alvar�`, start = 2, end=11),
                `Data In�cio Obra`=str_sub(`Data In�cio Obra`, start = 2, end=11),
                `Data Conclus�o Obra`=str_sub(`Data Conclus�o Obra`, start = 2, end=11),
                `Data Vistoria`=str_sub(`Data Vistoria`, start = 2, end=11)
                )
alvara2017_2021<-mutate(alvara2017_2021_1,
               `Data Cria��o Alvar�`=strptime(`Data Cria��o Alvar�`,format="%d/%m/%Y"),
               `Data In�cio Obra`=strptime(`Data In�cio Obra`,format="%d/%m/%Y"),
               `Data Conclus�o Obra`=strptime(`Data Conclus�o Obra`,format="%d/%m/%Y"),
               `Data Vistoria`=strptime(`Data Vistoria`,format="%d/%m/%Y"),
               `N�mero CVCO`=as.double(`N�mero CVCO`),
               `Tipo Vistoria`=as.character(`Tipo Vistoria`)
                )

#cria tabela imovel
imovel<-select(alvara2017_2021,'Indica��o Fiscal','Inscri��o Imobili�ria','Logradouro',
               'N�mero','Bairro','Grupo Zoneamento','Abrang�ncia',
               'Quantidade Pavimentos','Quantidade de Unidades Resid�nciais',
               'Quantidade Unidades N�o Resid�nciais','N�mero Alvar�')

#cria tabela alvara 
alvara<-select(alvara2017_2021,'Data Cria��o Alvar�','Data In�cio Obra','Data Conclus�o Obra',
               'N�mero Alvar�','Uso(s) Alvar�','Sub-Uso(s) Alvar�','Finalidade','Material(is)',
               'Metragem �rea Remanescente','Metragem Constru�da Lote','N�mero de CAPACs Utilizadas',
               'ACA-�rea Adicional de Constru��o','�rea Liberada','Metragem �rea Reforma Alvar�',
               'Quantidade Blocos Alvar�','Quantidade Sub-Solo Alvar�','N�mero Registro Crea/Cau AU',
               'N�mero Registro Crea/Cau RT','Firma Construtora','N�mero CVCO','Tipo Vistoria',
               'Data Vistoria')


#cria tabela autor do projeto
autor_projeto0<-distinct(na.omit(select(alvara2017_2021,
                                        'N�mero Registro Crea/Cau AU',
                                        'Autor do Projeto',
                                        'Data Cria��o Alvar�')))
autor_projeto1<-mutate(autor_projeto0, 
                       Ano = as.numeric(format(`Data Cria��o Alvar�`, "%Y"))*10000,
                       Mes = as.numeric(format(`Data Cria��o Alvar�`, "%m"))*100,
                       Dia = as.numeric(format(`Data Cria��o Alvar�`, "%d"))
                       )
autor_projeto2<-mutate(autor_projeto1, Data_Numero=Ano+Mes+Dia)
autor_projeto3<-group_by(autor_projeto2,`N�mero Registro Crea/Cau AU`)
autor_projeto4<-summarise(autor_projeto3, Maximo=max(Data_Numero))
autor_projeto5<-merge(autor_projeto3,autor_projeto4)
autor_projeto6<-mutate(autor_projeto5, Diferenca= Data_Numero - Maximo)
autor_projeto7<-filter(autor_projeto6, Diferenca==0)
autor_projeto<-select(autor_projeto7,'N�mero Registro Crea/Cau AU',
                      'Autor do Projeto')

#cria tabela responsavel tecnico
resp_tecnico0<-distinct(na.omit(select(alvara2017_2021,
                                        'N�mero Registro Crea/Cau RT',
                                        'Respons�vel T�cnico',
                                        'Data Cria��o Alvar�')))
resp_tecnico1<-mutate(resp_tecnico0, 
                       Ano = as.numeric(format(`Data Cria��o Alvar�`, "%Y"))*10000,
                       Mes = as.numeric(format(`Data Cria��o Alvar�`, "%m"))*100,
                       Dia = as.numeric(format(`Data Cria��o Alvar�`, "%d"))
)
resp_tecnico2<-mutate(resp_tecnico1, Data_Numero=Ano+Mes+Dia)
resp_tecnico3<-group_by(resp_tecnico2,`N�mero Registro Crea/Cau RT`)
resp_tecnico4<-summarise(resp_tecnico3, Maximo=max(Data_Numero))
resp_tecnico5<-merge(resp_tecnico3,resp_tecnico4)
resp_tecnico6<-mutate(resp_tecnico5, Diferenca= Data_Numero - Maximo)
resp_tecnico7<-filter(resp_tecnico6, Diferenca==0)
resp_tecnico<-select(resp_tecnico7,'N�mero Registro Crea/Cau RT',
                      'Respons�vel T�cnico')



# Conectar  e povoar Banco de dados -----
# Carregar pacotes
library(RPostgres)

con <- dbConnect(Postgres(),
                 user = "postgres",
                 password = "chonga",
                 host = 'localhost',
                 port = 5432,
                 dbname = "ProjetoIntegrador")

dbListTables(con)

#inserir dados na tabela autor_projeto
dbReadTable(con, "autor_projeto")
dbExecute(con,
          "INSERT INTO autor_projeto(numero_crea_cau_au, nome) 
          VALUES ($1, $2)", params = unname(as.list(autor_projeto)))
dbReadTable(con, "autor_projeto")

#inserir dados na tabela responsavel_tecnico
dbReadTable(con, "responsavel_tecnico")
dbExecute(con,
          "INSERT INTO responsavel_tecnico(numero_crea_cau_rt, nome) 
          VALUES ($1, $2)", params = unname(as.list(resp_tecnico)))
dbReadTable(con, "responsavel_tecnico")

#inserir dados na tabela alvara
dbReadTable(con, "alvara")
dbExecute(con,
          "INSERT INTO alvara(data_criacao_alvara, data_inicio_obra, data_conclusao_obra,
          numero_alvara, usos_alvara, sub_usos_alvara, finalidade, material,
          metragem_area_remanescente, metragem_construida_lote, numero_de_capacs_utilizadas,
          aca_area_adicional_de_construcao, area_liberada, metragem_area_reforma_alvara,
          quantidade_blocos_alvara, quantidade_sub_solo_alvara, numero_crea_cau_au,
          numero_crea_cau_rt, firma_construtora, numero_cvco, tipo_vistoria ,
          data_vistoria) 
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
            $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)", 
            params = unname(as.list(alvara)))
dbReadTable(con, "alvara")

#inserir dados na tabela imovel
dbReadTable(con, "imovel")
dbExecute(con,
          "INSERT INTO imovel(indicacao_fiscal, inscricao_imobiliaria, 
          logradouro, numero, bairro, grupo_zoneamento, abrangencia,
          quantidade_pavimento, quantidade_de_unidades_residenciais, 
          quantidade_unidades_nao_residenciais, numero_alvara) 
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
            $11)", 
          params = unname(as.list(imovel)))
dbReadTable(con, "imovel")



# 1 consulta envolvendo proje��o e sele��o
#proje��o
resposta1<-as_tibble(dbGetQuery(con,
                                "SELECT indicacao_fiscal, logradouro, numero 
                                FROM imovel
                                WHERE bairro ILIKE 'BOQUEIR%';"))



# 1 consulta que envolva jun��o externa (LEFT OUTER JOIN ou RIGHT OUTER JOIN ou FULL OUTER JOIN)
resposta2<-as_tibble(dbGetQuery(con,
                              "SELECT a.numero_alvara, rt.nome 
                              FROM alvara a LEFT JOIN  responsavel_tecnico rt 
                              ON a.numero_crea_cau_rt=rt.numero_crea_cau_rt;"))


#1 consulta que envolva pelo menos uma opera��o de conjunto (UNION ou INTERSECT ou EXCEPT)
resposta3<-as_tibble(dbGetQuery(con,
                              "SELECT rt.nome FROM responsavel_tecnico rt
                              UNION
                              SELECT au.nome FROM autor_projeto au;"))


#1 consulta que envolva divis�o relacional
resposta4<-as_tibble(dbGetQuery(con,
              "SELECT au.nome
              FROM autor_projeto au
              WHERE NOT EXISTS ( (SELECT DISTINCT numero_alvara
              FROM alvara)
              EXCEPT
              (SELECT numero_alvara FROM alvara
              WHERE au.numero_crea_cau_au= alvara.numero_crea_cau_au));"))


#1 consulta com opera��o de agrega��o e agrupamento (Fun��o de agrega��o + GROUP BY)
resposta5<-as_tibble(dbGetQuery(con,
                  "SELECT finalidade, count(alvara), avg(metragem_area_reforma_alvara) 
                  FROM alvara
                  WHERE metragem_area_reforma_alvara>0 AND FINALIDADE IS NOT NULL
                  GROUP BY finalidade;"))

#apresentar os resultados em v�rios formatos diferentes: 
#(i)gr�ficos de barras, linhas e colunas, (ii) tabelas.

grafico1<-as_tibble(dbGetQuery(con,
               "SELECT bairro, sum(quantidade_de_unidades_residenciais)+sum(quantidade_de_unidades_residenciais) as Qde_Unidades
                FROM alvara al, imovel im
                WHERE al.numero_alvara=im.numero_alvara
                GROUP BY BAIRRO
                ORDER BY Qde_Unidades DESC
                LIMIT 10;"))

grafico1 %>%
  ggplot(aes(x = qde_unidades, y = bairro)) +
  geom_col() +
  theme(legend.position="none") +
  labs(title = "Quantidade de Unidades por bairro entre 2017 e 2021 - top 10",
       y = 'Bairro',
       x = 'Qde de Unidades')



grafico2<-as_tibble(dbGetQuery(con,
                   "SELECT bairro, avg(quantidade_pavimento) as pavimentos
                    FROM alvara al, imovel im
                    WHERE al.numero_alvara=im.numero_alvara and quantidade_pavimento>=4
                    GROUP BY BAIRRO
                    ORDER BY pavimentos DESC
                    limit 5;"))

grafico2 %>%
  ggplot(aes(x = bairro, y = pavimentos)) +
  geom_col() +
  theme(legend.position="none") +
  labs(title = "M�dia de Pavimentos das constru��es por bairro entre 2017 e 2021 - top 5",
       y = 'Pavimentos',
       x = 'Bairro')


grafico3<-as_tibble(dbGetQuery(con,
          "SELECT extract(year from data_criacao_alvara) as Ano, count(indicacao_fiscal) as Indicacao_Fiscal
          FROM alvara al, imovel im
          WHERE al.numero_alvara=im.numero_alvara
          GROUP BY Ano
          ORDER BY Ano;"))
grafico3 %>%
  ggplot(aes(x = as.integer(ano), y = as.integer(indicacao_fiscal))) +
  geom_line()+
  theme(legend.position="none") +
  labs(title = "Quantidade de Indicacao Fiscal por Ano",
       y = 'Indicacao Fiscal',
       x = 'Ano')


