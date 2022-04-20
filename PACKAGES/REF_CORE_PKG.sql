CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."REF_CORE_PKG" as                 
/**                                                                             
 Procedures for working with reference tables and related tables: insert, update, delete                                                                        
*/                                                                              
                                                                                
/** Gets unit identifier by name                                                
*   @param unit_name   Unit name;                                               
*/                                                                              
function get_unit_id(unit_name in unit.unit_name%type) return unit.unit_id%type;

/** Unit insertion procedure                                                    
*   @param rec     Unit record                                                  
*/                                                                              
procedure unit_insert(rec in out unit%rowtype);                                 
                                                                                
/** Unit update procedure                                                       
*   @param rec     Unit record                                                  
*/                                                                              
procedure unit_update(rec in unit%rowtype);                                     
                                                                                
/** Unit delete procedure by unit identifier                                    
*   @param unit_id     Unit identifier;                                         
*/
procedure unit_delete(unit_id in unit.unit_id%type);                            
                                                                                
/** Unit delete procedure by unit name                                          
*   @param unit_name   Unit name;                                               
*/                                                                              
procedure unit_delete(unit_name in unit.unit_name%type);                        
                                                                                
----------------------------------------                                        
                                                                                
/** Gets food identifier by name                                                
*   @param food_name   Food name;                                               
*/                                                                              
function get_food_id(food_name in food.food_name%type) return food.food_id%type;
                                                                              
/** Food insertion procedure                                                    
*   @param rec   Food record;                                                   
*/                                                                              
procedure food_insert(rec in out food%rowtype);                                 
                                                                                
/** Food update procedure                                                       
*   @param rec     Food record;                                                 
*/                                                                              
procedure food_update(rec in food%rowtype);                                     
                                                                                
/** Food delete procedure by food identifier                                    
*   @param food_id     Food identifier;                                         
*/                                                                              
procedure food_delete(food_id in food.food_id%type);                            
                                                                                
/** Food delete procedure by food name                                          
*   @param food_name   Food name;                                               
*/                                                                              
procedure food_delete(food_name in food.food_name%type);                        
                                                                                
-----------------------------------------                                       
                                                                                
/** Gets meal identifier by name                                                
*   @param meal_name   Meal name;
*/                                                                              
function get_meal_id(meal_name in meal.meal_name%type) return meal.meal_id%type;
                                                                              
/** Meal insertion procedure                                                    
*   @param rec   Meal record;                                                   
*/                                                                              
procedure meal_insert(rec in out meal%rowtype);                                 
                                                                                
/** Meal update procedure                                                       
*   @param rec     Meal record;                                                 
*/                                                                              
procedure meal_update(rec in meal%rowtype);                                     
                                                                              
/** Meal delete procedure by meal identifier                                    
*   @param meal_id     Meal identifier;                                         
*/                                                                              
procedure meal_delete(meal_id in meal.meal_id%type);                            
                                                                                
/** Meal delete procedure by meal name                                          
*   @param meal_name   Meal name;                                               
*/                                                                              
procedure meal_delete(meal_name in meal.meal_name%type);                        
                                                                                
----------------------------------------                                        

/** Procedure for inserting food units                                          
*   @param food_id   Food identifier;                                           
*   @param unit_id   Unit identifier;                                           
*/                                                                              
procedure food$unit_insert(rec in out food$unit%rowtype);                       
                                                                                
/** Procedure for updating food units                                           
*   @param fu_id   Food$unit identifier;                                        
*   @param food_id   Food identifier;                                           
*   @param unit_id   Unit identifier;                                           
*/                                                                              
procedure food$unit_update(rec in food$unit%rowtype);                           

/** Procedure for deleting food units                                           
*   @param fu_id   Food$unit identifier;                                        
*/                                                                              
procedure food$unit_delete(fu_id in food$unit.fu_id%type);                      
                                                                                
-----------------------------------------                                       
                                                                                
/** Gets food type identifier by name                                           
*   @param type_name   Food type name;                                          
*/                                                                              
function get_foodtype_id(type_name in food_type.type_name%type) return food_type.type_id%type;                                                                  

/** Food type insertion procedure                                               
*   @param rec   Food type record;                                              
*/                                                                              
procedure foodtype_insert(rec in out food_type%rowtype);                        
                                                                                
/** Food type update procedure                                                  
*   @param rec     Food type record;                                            
*/                                                                              
procedure foodtype_update(rec in food_type%rowtype);                            
                                                                                
/** Food type delete procedure by food type identifier                          
*   @param type_id     Food type identifier;                                    
*/
procedure foodtype_delete(type_id in food_type.type_id%type);                   
                                                                                
/** Food type delete procedure by food type name                                
*   @param type_name   Food type name;                                          
*/                                                                              
procedure foodtype_delete(type_name in food_type.type_name%type);               
                                                                                
-----------------------------------------                                       
                                                                                
/** Procedure for inserting meal serving sizes                                  
*   @param meal_id   Meal identifier;                                           
*   @param sz_id     Serving size identifier;                                   
*/
procedure meal$serving_size_insert(rec in out meal$serving_size%rowtype);       
                                                                                
/** Procedure for updating meal serving sizes                                   
*   @param msz_id    Meal$serving_size identifier;                              
*   @param meal_id   Meal identifier;                                           
*   @param sz_id     Serving size identifier;                                   
*/                                                                              
procedure meal$serving_size_update(rec in meal$serving_size%rowtype);           
                                                                                
/** Procedure for deleting meal serving sizes                                   
*   @param msz_id   Meal$serving_size identifier;                               
*/                                                                              
procedure meal$serving_size_delete(msz_id in meal$serving_size.msz_id%type);    
                                                                              
------------------------------------------                                      
                                                                                
/** Grocery store insertion procedure                                           
*   @param rec    Grocery store record;                                         
*/                                                                              
procedure grocery_store_insert(rec in out grocery_store%rowtype);               
                                                                                
/** Grocery store update procedure                                              
*   @param rec    Grocery store record;                                         
*/                                                                              
procedure grocery_store_update(rec in grocery_store%rowtype);                   

/** Grocery store delete procedure by store identifier                          
*   @param store_id     Grocery store identifier;                               
*/                                                                              
procedure grocery_store_delete(store_id in grocery_store.store_id%type);        
                                                                                
end ref_core_pkg;