insert into "FileImporter".layout_name (name, identifier, separator, owner, "table")
values ('Argentina - SISA', 'SISA', ';', 'FileImporter', 'CLIENTES_SISA');

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'CUIT', 1, 11);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'RAZAO_SOCIAL', 2, 200);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'ESTADO', 3, 1);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_VIGENCIA_ESTADO', 4, 10);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_NOTIFICACAO_DFE_ESTADO', 5, 10);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'CBU', 6, 22);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_ATUALIZACAO_CBU', 7, 10);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'CODIGO_CATEGORIA', 8, 2);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'CATEGORIA', 9, 200);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'CATEGORIA_SITUACAO', 10, 2);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_VIGENCIA_CATEGORIA', 11, 10);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_NOTIFICACAO_DFE_CATEGORIA', 12, 10);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'OBSERVACOES', 13, 1000);

insert into "FileImporter".layout_template (id_layout, field, "order", "size")
values (1, 'DATA_GERACAO', 14, 10);