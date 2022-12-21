#!/usr/bin/env python
# coding: utf-8

# In[1]:


import psycopg
import pandas as pd
from matplotlib import pyplot as plt
import math
import numpy as np
from datetime import datetime


# In[2]:


alvara2017 = pd.read_excel(".../base_de_dados/RelatorioMensal_ALV_JAN_DEZ2017.xlsx")
print(alvara2017)
alvara2018 = pd.read_excel(".../base_de_dados/RelatorioMensal_ALV_JAN_DEZ2018.xlsx")
print(alvara2018)
alvara2019 = pd.read_excel(".../base_de_dados/RelatorioMensal_ALV_JAN_DEZ2019.xlsx")
print(alvara2019)
alvara2020 = pd.read_excel(".../base_de_dados/RelatorioMensal_ALV_JAN_DEZ2020.xlsx")
print(alvara2020)


# In[3]:


#alvara2017 = pd.concat([alvara2017a,alvara2018,alvara2019,alvara2020])


# In[4]:


#print(alvara2017_2020.head())
print(alvara2017.dtypes)


# In[5]:


print(alvara2017['Data Criação Alvará'])
#alvara2017['Data Criação Alvará'] = pd.to_datetime(alvara2017['Data Criação Alvará'])
print(alvara2017['Data Criação Alvará'])

print(alvara2017['Data Início Obra'])
#alvara2017['Data Início Obra'] = pd.to_datetime(alvara2017['Data Início Obra'])
print(alvara2017['Data Início Obra'])

print(alvara2017['Data Conclusão Obra'])
#alvara2017['Data Conclusão Obra'] = pd.to_datetime(alvara2017['Data Conclusão Obra'])
print(alvara2017['Data Conclusão Obra'])

print(alvara2017['Número CVCO'])
alvara2017['Número CVCO'] = alvara2017['Número CVCO'].astype('double')
print(alvara2017['Número CVCO'])

print(alvara2017['Tipo Vistoria'])
alvara2017['Tipo Vistoria'] = alvara2017['Tipo Vistoria'].astype('str')
print(alvara2017['Tipo Vistoria'])

alvara2017['Número Alvará'] = alvara2017['Número Alvará'].astype('str')

alvara2017['Metragem Área Remanescente'] = alvara2017['Metragem Área Remanescente'].astype('str')
alvara2017['Número de CAPACs Utilizadas'] = alvara2017['Número de CAPACs Utilizadas'].astype('str')
alvara2017['ACA-Área Adicional de Construção'] = alvara2017['ACA-Área Adicional de Construção'].astype('str')
alvara2017['Área Liberada'] = alvara2017['Área Liberada'].astype('str')
alvara2017['Metragem Área Reforma Alvará'] = alvara2017['Metragem Área Reforma Alvará'].astype('str')
alvara2017['Quantidade Pavimentos'] = alvara2017['Quantidade Pavimentos'].astype('str')
alvara2017['Quantidade Unidades Não Residênciais'] = alvara2017['Quantidade Unidades Não Residênciais'].astype('str')
alvara2017['Metragem Construída Lote'] = alvara2017['Metragem Construída Lote'].astype('str')
alvara2017['Quantidade de Unidades Residênciais'] = alvara2017['Quantidade de Unidades Residênciais'].astype('str')
alvara2017['Quantidade Blocos Alvará'] = alvara2017['Quantidade Blocos Alvará'].astype('str')
alvara2017['Quantidade Sub-Solo Alvará'] = alvara2017['Quantidade Sub-Solo Alvará'].astype('str')

alvara2017['Indicação Fiscal'] = alvara2017['Indicação Fiscal'].astype('str')
alvara2017['Número'] = alvara2017['Número'].astype('str')
#alvara2017['Data Vistoria'] = alvara2017['Data Vistoria'].astype('str')


#alvara2017['Data Vistoria'] = pd.to_datetime(alvara2017['Data Vistoria'])


# In[6]:


print(alvara2017.dtypes)


# In[7]:


#alvara2017 = alvara2017.dropna(subset = ['Número Alvará'])
#alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau AU']) 
#alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau RT']) 


# In[8]:


imovel = pd.DataFrame(alvara2017, columns=['Indicação Fiscal','Inscrição Imobiliária','Logradouro',
               'Número','Bairro','Grupo Zoneamento','Abrangência',
               'Quantidade Pavimentos','Quantidade de Unidades Residênciais',
               'Quantidade Unidades Não Residênciais','Número Alvará'])

print(imovel)


# In[9]:


alvara = pd.DataFrame(alvara2017, columns=['Data Criação Alvará','Data Início Obra','Data Conclusão Obra',
               'Número Alvará','Uso(s) Alvará','Sub-Uso(s) Alvará','Finalidade','Material(is)',
               'Metragem Área Remanescente','Metragem Construída Lote','Número de CAPACs Utilizadas',
               'ACA-Área Adicional de Construção','Área Liberada','Metragem Área Reforma Alvará',
               'Quantidade Blocos Alvará','Quantidade Sub-Solo Alvará','Número Registro Crea/Cau AU',
               'Número Registro Crea/Cau RT','Firma Construtora','Número CVCO','Tipo Vistoria',
               'Data Vistoria'])

print(alvara)


# In[10]:


autor_projeto = pd.DataFrame(alvara2017, columns=['Número Registro Crea/Cau AU','Autor do Projeto'])
print(autor_projeto)


# In[11]:


responsavel_tecnico = pd.DataFrame(alvara2017, columns=['Número Registro Crea/Cau RT','Responsável Técnico'])
print(responsavel_tecnico)


# In[ ]:





# In[12]:


autor_projeto = autor_projeto.drop_duplicates(subset = 'Número Registro Crea/Cau AU')
autor_projeto = autor_projeto.dropna(subset = ['Número Registro Crea/Cau AU']) 
alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau AU']) 

for i in autor_projeto.index:
    print(autor_projeto['Número Registro Crea/Cau AU'][i])
   


# In[ ]:





# In[13]:


try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="****")
    cur = conn.cursor()    
   
    
    for i in autor_projeto.index:
        cur.execute("""INSERT INTO autor_projeto (numero_crea_cau_au,nome) VALUES (%s, %s)""",(autor_projeto['Número Registro Crea/Cau AU'][i],autor_projeto['Autor do Projeto'][i]))
    
        conn.commit()
          
    #cur.execute('SELECT * FROM autor_projeto')
    #for values in cur.fetchall():
        #print(values)
    
    
    #conn.commit()  
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[ ]:





# In[14]:


responsavel_tecnico = responsavel_tecnico.drop_duplicates(subset = 'Número Registro Crea/Cau RT')
responsavel_tecnico = responsavel_tecnico.dropna(subset = ['Número Registro Crea/Cau RT']) 
alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau RT'])
for i in responsavel_tecnico.index:
    print(responsavel_tecnico['Número Registro Crea/Cau RT'][i])


# In[15]:


try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="****")
    cur = conn.cursor()    
  

    
    for i in responsavel_tecnico.index:
        cur.execute("INSERT INTO responsavel_tecnico VALUES (%s, %s)",(responsavel_tecnico['Número Registro Crea/Cau RT'][i],responsavel_tecnico['Responsável Técnico'][i]))
    
        conn.commit()
          
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[ ]:





# In[16]:


alvara = alvara.drop_duplicates(subset = 'Número Alvará')
alvara = alvara.dropna(subset = ['Número Alvará']) 
alvara2017 = alvara2017.drop_duplicates(subset = 'Número Alvará')
alvara2017 = alvara2017.dropna(subset = ['Número Alvará']) 
for i in alvara.index:
    print(alvara['Número Alvará'][i])


# In[ ]:





# In[ ]:





# In[ ]:





# In[17]:


alvara['Data Conclusão Obra']= pd.to_datetime(alvara['Data Conclusão Obra'])


# In[18]:


alvara['Data Conclusão Obra'] = alvara['Data Conclusão Obra'].fillna(np.nan).replace([np.nan], [None])
print(alvara['Data Conclusão Obra'])


# In[ ]:





# In[19]:


for i in alvara.index: 
    print(alvara['Data Conclusão Obra'][i])
    


# In[20]:


for i in alvara.index: 
    print(alvara['Data Início Obra'][i])


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[21]:


alvara = alvara.dropna(subset = ['Número Registro Crea/Cau AU']) 
alvara = alvara.dropna(subset = ['Número Registro Crea/Cau RT']) 
#alvara = alvara.dropna(subset = ['Data Conclusão Obra']) 
alvara['Data Criação Alvará']= pd.to_datetime(alvara['Data Criação Alvará'])
alvara['Data Início Obra']= pd.to_datetime(alvara['Data Início Obra'])

alvara['Data Vistoria']= pd.to_datetime(alvara['Data Vistoria'])
print(alvara['Data Criação Alvará'].dtypes)
alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau AU']) 
alvara = alvara.dropna(subset = ['Número Registro Crea/Cau AU']) 


# In[22]:


try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="***")
    cur = conn.cursor()    
    for i in alvara.index:        
        cur.execute("""INSERT INTO alvara (data_criacao_alvara ,data_inicio_obra, data_conclusao_obra, 
        numero_alvara, usos_alvara, sub_usos_alvara,finalidade, material, metragem_area_remanescente,
        metragem_construida_lote, numero_de_capacs_utilizadas, aca_area_adicional_de_construcao, 
        area_liberada, metragem_area_reforma_alvara, quantidade_blocos_alvara, quantidade_sub_solo_alvara, 
        numero_crea_cau_rt, numero_crea_cau_au, firma_construtora,numero_cvco,tipo_vistoria, data_vistoria)
        VALUES (%s, %s, %s, %s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""" ,
                    (alvara['Data Criação Alvará'][i],alvara['Data Início Obra'][i], alvara['Data Conclusão Obra'][i],
                     alvara['Número Alvará'][i], alvara['Uso(s) Alvará'][i],alvara['Sub-Uso(s) Alvará'][i],
                     alvara['Finalidade'][i],alvara['Material(is)'][i],alvara['Metragem Área Remanescente'][i], 
                     alvara['Metragem Construída Lote'][i],alvara['Número de CAPACs Utilizadas'][i], 
                     alvara['ACA-Área Adicional de Construção'][i],alvara['Área Liberada'][i], 
                     alvara['Metragem Área Reforma Alvará'][i],alvara['Quantidade Blocos Alvará'][i], 
                     alvara['Quantidade Sub-Solo Alvará'][i], alvara['Número Registro Crea/Cau RT'][i],
                     alvara['Número Registro Crea/Cau AU'][i], alvara['Firma Construtora'][i],alvara['Número CVCO'][i], 
                     alvara['Tipo Vistoria'][i],None))
    
        conn.commit()
          
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[30]:


# a partir daqui
a = []
for i in imovel.index:
    print(imovel['Número Alvará'][i])


# In[24]:


for i in alvara.index:
    if alvara['Número Alvará'][i] == imovel['Número Alvará'][i]:
        print(imovel['Número Alvará'][i])


# In[25]:


imovel = imovel.dropna(subset = ['Número Alvará'])
alvara = alvara.dropna(subset = ['Número Alvará'])
imovel = imovel.dropna(subset = ['Quantidade Unidades Não Residênciais'])
alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau AU']) 
alvara = alvara.dropna(subset = ['Número Registro Crea/Cau AU']) 
alvara2017 = alvara2017.dropna(subset = ['Número Registro Crea/Cau RT']) 
alvara = alvara.dropna(subset = ['Número Registro Crea/Cau RT']) 


# In[26]:


imovel['Número Alvará'] = alvara['Número Alvará']
for i in imovel.index:
    print(imovel['Indicação Fiscal'][i],imovel['Inscrição Imobiliária'][i], imovel['Logradouro'][i],
                imovel['Número'][i],  imovel['Bairro'][i],imovel['Grupo Zoneamento'][i], 
                imovel['Abrangência'][i],imovel['Quantidade Pavimentos'][i],imovel['Quantidade de Unidades Residênciais'][i], 
                imovel['Quantidade Unidades Não Residênciais'][i],imovel['Número Alvará'][i])


# In[28]:


imovel = imovel.dropna(subset = ['Número Alvará'])


# In[ ]:





# In[29]:


try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="***")
    cur = conn.cursor()    

    
    for i in imovel.index:
        if imovel['Número Alvará'][i] != '346991':
            cur.execute("""INSERT INTO imovel (indicacao_fiscal,inscricao_imobiliaria,logradouro,
            numero, bairro , grupo_zoneamento, abrangencia, quantidade_pavimento,
            quantidade_de_unidades_residenciais, quantidade_unidades_nao_residenciais,
            numero_alvara) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""" ,( 
                imovel['Indicação Fiscal'][i],imovel['Inscrição Imobiliária'][i], imovel['Logradouro'][i],
                imovel['Número'][i],  imovel['Bairro'][i],imovel['Grupo Zoneamento'][i], 
                imovel['Abrangência'][i],imovel['Quantidade Pavimentos'][i],imovel['Quantidade de Unidades Residênciais'][i], 
                imovel['Quantidade Unidades Não Residênciais'][i],imovel['Número Alvará'][i]))
    
            conn.commit()
          
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[ ]:


#graficos


# In[39]:


# Analisa a quantidade da metragem da área liberada por bairro que começa com a letra S
try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="***")
    cur = conn.cursor()    
    
    
    cur.execute("select bairro, count(area_liberada) as md_area_liber from imovel im, alvara al where im.numero_alvara =al.numero_alvara and  bairro like 'S%' group by bairro order by avg(area_liberada) desc")
    values = cur.fetchall()
    x = []
    y = []
    for i in range(0, len(values)):       
        x.append((values)[i][0])
        y.append((values)[i][1])
   
    fig, ax = plt.subplots(1, 1)      
    ax.barh(x, y)
    ax.set_title("Quantidade da metragem da área liberada")
    ax.set_xlabel("Quantidade")
    ax.set_ylabel("Bairros")
    
    conn.commit()  
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[41]:


# Analisa os bairros tem mais de 10 imoveis
try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="***")
    cur = conn.cursor()    
    
    
    cur.execute("select bairro, count(bairro) as md_area_liber from imovel im, alvara al, autor_projeto ap where im.numero_alvara = al.numero_alvara and ap.numero_crea_cau_au =al.numero_crea_cau_au group by nome, bairro having count(bairro) > 10")
    values = cur.fetchall()
    x = []
    y = []
    for i in range(0, len(values)):       
        x.append((values)[i][0])
        y.append((values)[i][1])
   
    fig, ax = plt.subplots(1, 1)      
    ax.barh(x, y)
    ax.set_title("Quantidade de bairros")
    ax.set_xlabel("Quantidade")
    ax.set_ylabel("Bairros")
    
    conn.commit()  
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[45]:


# Analisa as 10 maiores medias de metragem por autor
try:
    conn = psycopg.connect(dbname="cria_banco_dados",user="postgres",password="***")
    cur = conn.cursor()    
    
    
    cur.execute("select ap.nome as autor, avg(area_liberada) as md_area_liber from imovel im, alvara al, autor_projeto ap, responsavel_tecnico rt where im.numero_alvara =al.numero_alvara and ap.numero_crea_cau_au =al.numero_crea_cau_au and rt.numero_crea_cau_rt=al.numero_crea_cau_rt group by ap.nome, rt.nome, bairro order by avg(area_liberada) desc LIMIT 10")
    values = cur.fetchall()
    
    x = []
    y = []
    for i in range(0, len(values)):       
        x.append((values)[i][0])
        y.append((values)[i][1])
   
    fig, ax = plt.subplots(1, 1)      
    ax.barh(x, y)
    ax.set_title("Metragem por autores")
    ax.set_xlabel("Metragem")
    ax.set_ylabel("Autores")
    
    conn.commit()  
    
    
    
except Exception as error:
    print(error)
    
finally:
    if cur is not None:
        cur.close()
    if conn is not None:
        conn.close()


# In[ ]:




