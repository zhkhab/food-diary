CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."SCHEMA_METADATA_PKG" as
/**
 Functions for getting db objects ddl
*/
subtype tBoolNum is pls_integer range 0..1;

/** Gets sequence ddl
*   @param sequence_name     Sequence name
*/
function get_sq_ddl(sequence_name     in varchar2,
                    schema_           in varchar2 default user
                    ) return clob;

/** Gets trigger ddl
*   @param trigger_name     Trigger name
*/
function get_tg_ddl(trigger_name      in varchar2,
                    schema_           in varchar2 default user
                    ) return clob;

/** Gets package specification ddl
*   @param package_name     Package name
*/
function get_pks_ddl(package_name      in varchar2,
                     schema_           in varchar2 default user
                     ) return clob;

/** Gets package body ddl
*   @param package_name     Package name
*/
function get_pkb_ddl(package_name      in varchar2,
                     schema_           in varchar2 default user
                     ) return clob;

/** Gets table ddl
*   @param table_name       Table name
*   @param schema_          Schema name
*   @param ref_constr       Referential constraints
*   @param segment_attr     Segment attributes
*   @param sqlterminator_   SQL terminators
*/
function get_table_ddl(table_name      in varchar2,
                       schema_         in varchar2 default user,
                       ref_constr      in tBoolNum  default 1,
                       segment_attr    in tBoolNum  default 0,
                       sqlterminator_  in tBoolNum  default 1
                       ) return clob;

/** Gets index ddl
*   @param index_name         Index name
*   @param base_object_name   Indexes are selected that are defined or granted on object with this name
*   @param schema_            Schema name
*   @param system_generated   Is index system generated
*   @param segment_attr       Segment attributes
*   @param sqlterminator_     SQL terminators
*/
function get_index_ddl(index_name       in varchar2,
                       base_object_name in varchar2,
                       schema_          in varchar2  default user,
                       system_generated in tBoolNum  default 0,
                       segment_attr     in tBoolNum  default 0,
                       sqlterminator_   in tBoolNum  default 1
                       ) return clob;

/** Gets comment ddl
*   @param base_object_name     Comments are selected that are defined on object with this name
*   @param base_object_schema   Base object schema name
*/
function get_comment_ddl(base_object_name    in varchar2,
                         base_object_schema  in varchar2 default user
                        ) return clob;

/** Gets table and dependent constraints, indexes and comments ddl
*   @param table_name         Table name
*   @param schema_            Schema name
*   @param sys_gen_indexes    Include/exclude system generated indexes
*   @param segment_attr       Segment attributes
*   @param sqlterminator_     SQL terminators
*/
function get_tbl_and_dep_ddl(table_name      in varchar2,
                             schema_         in varchar2 default user,
                             sys_gen_indexes in tBoolNum  default 0,
                             segment_attr    in tBoolNum  default 0,
                             sqlterminator_  in tBoolNum  default 1) return clob;

end schema_metadata_pkg;