CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."PERSON_PKG" as                   
/**                                                                             
 Procedures for working with PERSON table and related tables                    
*/                                                                              
current_person         person.pers_id%type; -- Current person identifier        
                                                                                
/** Sets current person identifier                                              
*   @param pers_id   Person identifier;                                         
*/                                                                              
procedure set_current_person(pers_id in person.pers_id%type);                   
                                                                                
/** Gets current person identifier
*/                                                                              
function get_current_person return person.pers_id%type;                         

/** Gets person identifier                                                      
*   @param rec   Person record;                                                 
*/                                                                              
function get_pers_id(rec in person%rowtype) return person.pers_id%type;         
                                                                                
/** Gets person name                                                            
*   @param rec   Person record;                                                 
*/                                                                              
function get_pers_name(rec in person%rowtype) return varchar2;

/** Gets person fullname with date of birth                                     
*   @param pers_id   Person identifier;                                         
*/                                                                              
function get_pers_info(pers_id in person.pers_id%type) return varchar2;         
                                                                                
/** Person saving procedure                                                     
*   @param pers_id      Person identifier;                                      
*   @param first_name   First name;                                             
*   @param last_name    Last name;                                              
*   @param middle_name  Middle name;                                            
*   @param dob          Date of birth;                                          
*   @param full_name    Full name;                                              
*/
procedure person_save(pers_id     in out person.pers_id%type,                   
                      first_name  in person.first_name%type,                    
                      last_name   in person.last_name%type,                     
                      middle_name in person.middle_name%type default null,      
                      dob         in person.dob%type,                           
                      full_name   in person.full_name%type default null);       
                                                                                
end person_pkg;
