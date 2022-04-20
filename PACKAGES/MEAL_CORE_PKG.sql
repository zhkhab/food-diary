CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."MEAL_CORE_PKG" as
/**
 Procedures for working with MEAL table and related tables: INSERT, UPDATE, DELETE                                                                              
*/

/** Meal log insertion procedure
*   @param rec   Meal log record;
*/
procedure meal_log_insert(rec in out meal_log%rowtype);

/** Meal log update procedure
*   @param rec   Meal log record;
*/                                                                              
procedure meal_log_update(rec in meal_log%rowtype);

/** Meal log delete procedure
*   @param ml_id   Meal log identifier;
*/
procedure meal_log_delete(ml_id in meal_log.ml_id%type);

--------------------------------------------                                    

/** Food log insertion procedure
*   @param rec   Food log record;
*/
procedure meallog_foods_insert(rec in out food_log%rowtype);

/** Food log update procedure
*   @param rec   Food log record;
*/
procedure meallog_foods_update(rec in food_log%rowtype);

/** Food log delete procedure
*   @param fl_id   Food log identifier;
*/
procedure meallog_foods_delete(fl_id in food_log.fl_id%type);

--------------------------------------------

/** Recipe insertion procedure
*   @param rec   Recipe record;
*/
procedure recipe_insert(rec in out recipe%rowtype);

/** Recipe update procedure
*   @param rec   Recipe record;
*/
procedure recipe_update(rec in recipe%rowtype);

/** Recipe delete procedure
*   @param rcp_id   Recipe identifier;
*/
procedure recipe_delete(rcp_id in recipe.rcp_id%type);

---------------------------------------------                                   

/** Gets serving size identifier by name
*   @param srvng_size   Serving_size name;
*/
function get_serving_size_id(srvng_size in serving_size.srvng_size%type) return serving_size.sz_id%type;                                                        

/** Serving size insertion procedure
*   @param rec     Serving size record
*/
procedure serving_size_insert(rec in out serving_size%rowtype);

/** Serving size update procedure
*   @param rec     Serving size record
*/
procedure serving_size_update(rec in serving_size%rowtype);

/** Serving size delete procedure by serving size identifier
*   @param sz_id     Serving size identifier;
*/
procedure serving_size_delete(sz_id in serving_size.sz_id%type);

/** Serving size delete procedure by name
*   @param srvng_size   Serving size name;
*/
procedure serving_size_delete(srvng_size in serving_size.srvng_size%type);

/** Gets serving factor by identifier
*   @param sz_id   Serving_size identifier;
*/
function get_serving_size_factor(sz_id in serving_size.sz_id%type) return serving_size.srvng_factor%type;                                                       

end meal_core_pkg;