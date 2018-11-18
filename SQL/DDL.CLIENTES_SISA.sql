create table "FileImporter".CLIENTES_SISA (id serial not null primary key 
                           ,estado smallint
                           ,CUIT varchar(11)
                           ,RAZAO_SOCIAL VARCHAR(200)
                           ,data_vigencia_estado date 
                           ,data_notificacao_dfe_estado date
                           ,cbu varchar(30)
                           ,data_atualizacao_cbu date
                           ,codigo_categoria varchar(2)
                           ,categoria varchar(250) 
                           ,categoria_situacao char(2) 
                           ,data_vigencia_categoria date 
                           ,data_notificacao_dfe_categoria date
                           ,observacoes varchar(2000)
                           ,data_geracao date                           
                           );