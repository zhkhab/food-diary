CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."REF_PKG" as                      
/**                                                                             
 Procedures for working with reference tables and related tables                
*/                                                                              
                                                                                
/** Checks for reference foods by type                                          
*   @param type_id     Food type identifier                                     
*/                                                                              
procedure check_ref_food(type_id in food_type.type_id%type);                    
                                                                                
/** Checks if the type is selectable                                            
*   @param type_id     Food type identifier
*/                                                                              
procedure is_selectable_check(type_id in food_type.type_id%type);               
                                                                                
end ref_pkg;