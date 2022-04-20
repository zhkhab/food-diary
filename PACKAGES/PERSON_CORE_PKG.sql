CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."PERSON_CORE_PKG" as              
/**                                                                             
 Procedures for working with PERSON table: insert, update, delete               
*/

/** Person insertion procedure                                                  
*   @param rec   Person record;                                                 
*/                                                                              
procedure person_insert(rec in out person%rowtype);                             
                                                                                
/** Person update procedure                                                     
*   @param rec   Person record;
*/                                                                              
procedure person_update(rec in person%rowtype);                                 
                                                                               
/** Person delete procedure                                                     
*   @param pers_id   Person identifier;                                         
*/                                                                              
procedure person_delete(pers_id in person.pers_id%type);                        
                                                                               
end person_core_pkg;
