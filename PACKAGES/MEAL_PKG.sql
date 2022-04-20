CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."MEAL_PKG" as                     
/**                                                                             
 Procedures for working with MEAL table and related tables                      
*/                                                                              

/** Meal log saving procedure                                                   
*   @param ml_id       Meal log identifier;                                     
*   @param ml_date     Log date;                                                
*   @param ml_time     Log time;                                                
*   @param ml_datetime Log datetime;                                            
*   @param meal_id     Meal identifier;                                         
*   @param srvng_size  Serving amount;
*   @param person_id   Person identifier;                                       
*/
procedure meallog_save(ml_id       in out meal_log.ml_id%type,                  
                       ml_date     in meal_log.ml_date%type,                    
                       ml_time     in meal_log.ml_time%type,                    
                       ml_datetime in meal_log.ml_datetime%type,                
                       meal_id     in meal_log.meal_id%type,                    
                       srvng_size  in meal_log.srvng_size%type,                 
                       person_id   in meal_log.person_id%type,                  
                       comment_    in meal_log.comment_%type);                  

/** Meal log delete procedure                                                   
*   @param ml_id   Meal log identifier;
*/
procedure meallog_delete(ml_id in meal_log.ml_id%type);                         

end meal_pkg;