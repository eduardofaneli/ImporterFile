create table "FileImporter".layout_name(id serial not null primary key
                                  ,"name" varchar(100) not null
                                  ,identifier varchar(30) not null
                                  ,separator char(1) not null
                                  ,"owner" varchar(33) not null
                                  ,"table" varchar(33) not null                                  
                                  ,registration_date timestamp not null default now()
                                  ,update_date timestamp
                                  ,CONSTRAINT layout_name_unq1 UNIQUE (identifier));                                  

create table "FileImporter".layout_template ("id" serial not null primary key
                                            ,"id_layout" integer not null
                                            ,"field" varchar(33) not null
                                            ,"order" smallint not null
                                            ,"size" smallint
                                            ,update_date timestamp not null default now()
                                            ,constraint layout_template_fk1 foreign key (id_layout) references "FileImporter".layout_name (id)
                                            ,constraint layout_template_unq1 unique (id_layout, "order"));
                                            
