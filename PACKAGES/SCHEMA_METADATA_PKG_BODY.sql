CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."SCHEMA_METADATA_PKG" as

c_false   constant pls_integer:=0;
c_true    constant pls_integer:=1;

function get_boolean_type(val in tBoolNum)
return boolean result_cache is
  vBoolVal boolean;
begin
  case val when c_false then vBoolVal:=false;
           when c_true  then vBoolVal:=true;
  end case;
  return vBoolVal;
end;

function get_sq_ddl(sequence_name     in varchar2,
                    schema_           in varchar2 default user
                    ) return clob is
begin
  return dbms_metadata.get_ddl('SEQUENCE', upper(sequence_name), upper(schema_));
end;

function get_tg_ddl(trigger_name      in varchar2,
                    schema_           in varchar2 default user
                    ) return clob is
begin
  return dbms_metadata.get_ddl('TRIGGER', upper(trigger_name), upper(schema_));
end;

function get_pks_ddl(package_name      in varchar2,
                     schema_           in varchar2 default user
                     ) return clob is
begin
  return dbms_metadata.get_ddl('PACKAGE_SPEC', upper(package_name), upper(schema_));
end;

function get_pkb_ddl(package_name      in varchar2,
                     schema_           in varchar2 default user
                     ) return clob is
begin
  return dbms_metadata.get_ddl('PACKAGE_BODY', upper(package_name), upper(schema_));
end;

function get_table_ddl(table_name      in varchar2,
                       schema_         in varchar2  default user,
                       ref_constr      in tBoolNum  default 1,
                       segment_attr    in tBoolNum  default 0,
                       sqlterminator_  in tBoolNum  default 1
                       )
return clob is
  vH   number;
  vTh  number;
  vDoc clob;
begin
  vH  :=dbms_metadata.open('TABLE');                                                              -- Specify the object type: TABLE.
  dbms_metadata.set_filter(vH, 'SCHEMA', upper(schema_));                                         -- Specify the schema name
  dbms_metadata.set_filter(vH, 'NAME', upper(table_name));                                        -- Specify the table name
  vTh:=dbms_metadata.add_transform(vH, 'DDL');                                                    -- Request that the metadata be transformed into creation DDL
  dbms_metadata.set_transform_param(vTh, 'REF_CONSTRAINTS', get_boolean_type(ref_constr));        -- Exclude/include referential constraints
  dbms_metadata.set_transform_param(vTh, 'SEGMENT_ATTRIBUTES', get_boolean_type(segment_attr));   -- Set segment attributes
  dbms_metadata.set_transform_param(vTh, 'SQLTERMINATOR', get_boolean_type(sqlterminator_));      -- Set SQL terminator ";"
  vDoc:=dbms_metadata.fetch_clob(vH);
  dbms_metadata.close(vH);
  return vDoc;
end;

function get_index_ddl(index_name       in varchar2,
                       base_object_name in varchar2,
                       schema_          in varchar2  default user,
                       system_generated in tBoolNum  default 0,
                       segment_attr     in tBoolNum  default 0,
                       sqlterminator_   in tBoolNum  default 1
                       )
return clob is
  vH                number;
  vTh               number;
  vDoc              clob;
  vTempClob         clob;
  not_objname_found exception;
  idxddls           sys.ku$_ddls;                                                                 -- Metadata is returned in sys.ku$_ddls, which is contained in sys.ku$_ddl
begin
  if index_name is null and base_object_name is null then raise not_objname_found; end if;
  vH  :=dbms_metadata.open('INDEX');                                                              -- Specify the object type: INDEX.
  dbms_metadata.set_filter(vH, 'SCHEMA', upper(schema_));                                         -- Specify the schema name
  vTh:=dbms_metadata.add_transform(vH, 'DDL');                                                    -- Request that the metadata be transformed into creation DDL
  dbms_metadata.set_transform_param(vTh, 'SEGMENT_ATTRIBUTES', get_boolean_type(segment_attr));   -- Set segment attributes
  dbms_metadata.set_transform_param(vTh, 'SQLTERMINATOR', get_boolean_type(sqlterminator_));      -- Set SQL terminator ";"
  if index_name is not null then
    dbms_metadata.set_filter(vH, 'NAME', upper(index_name));                                      -- Specify the index name
    vDoc:=dbms_metadata.fetch_clob(vH);
  else
    dbms_metadata.set_filter(vH,'BASE_OBJECT_NAME',upper(base_object_name));                      -- Set base object name
    dbms_metadata.set_filter(vH,'SYSTEM_GENERATED',get_boolean_type(system_generated));           -- Exclude/include system-generated indexes.
    dbms_lob.createtemporary(vDoc, true);
    dbms_lob.createtemporary(vTempClob, true);                                                    -- Create temporary lob;
    loop
      idxddls := dbms_metadata.fetch_ddl(vH);
    exit when idxddls is null;                                                                    -- When there are no more objects to  be retrieved, FETCH_DDL returns NULL.

      for i in idxddls.first..idxddls.last loop
        vTempClob := idxddls(i).ddlText;
        dbms_lob.append(vDoc, vTempClob);
       end loop;

    end loop;
    dbms_lob.freetemporary(vTempClob);
  end if;
  dbms_metadata.close(vH);
  return vDoc;
  exception when not_objname_found then
    raise_application_error(-20000, 'INDEX_NAME or BASE_OBJECT_NAME must have a value!');
end;

function get_comment_ddl(base_object_name   in varchar2,
                         base_object_schema  in varchar2 default user
                         ) return clob is
begin
  return dbms_metadata.get_dependent_ddl('COMMENT', upper(base_object_name), upper(base_object_schema));
end;

function get_tbl_and_dep_ddl(table_name      in varchar2,
                             schema_         in varchar2 default user,
                             sys_gen_indexes in tBoolNum  default 0,
                             segment_attr    in tBoolNum  default 0,
                             sqlterminator_  in tBoolNum  default 1)
return clob is
  vDoc clob;
begin
  vDoc:=get_table_ddl(table_name, schema_, 1, segment_attr, sqlterminator_);
  dbms_lob.append(vDoc, get_index_ddl(null, table_name, schema_, sys_gen_indexes, segment_attr, sqlterminator_));
  dbms_lob.append(vDoc, get_comment_ddl(table_name, schema_));
  return vDoc;
end;

function get_tps_ddl(type_name      in varchar2,
                     schema_        in varchar2 default user
                     ) return clob is
begin
  return dbms_metadata.get_ddl('TYPE_SPEC', upper(type_name), upper(schema_));
end;

function get_tpb_ddl(type_name      in varchar2,
                     schema_        in varchar2 default user
                     ) return clob is
begin
  return dbms_metadata.get_ddl('TYPE_BODY', upper(type_name), upper(schema_));
end;

end schema_metadata_pkg;