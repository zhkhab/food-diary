CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."MEAL_PKG" as                
                                                                                
procedure meallog_foods_delete(ml_id in meal_log.ml_id%type)                    
is                                                                              
begin                                                                           
  if meallog_foods_delete.ml_id is not null then                                
    for foodlog in (select fl_id
                      from food_log
                     where ml_id=meallog_foods_delete.ml_id) loop
      meal_core_pkg.meallog_foods_delete(foodlog.fl_id);
    end loop;                                                                   
  end if;
end;                                                                            
                                                                                
procedure meallog_foods_save(rec in meal_log%rowtype)
is
  vFoodLog food_log%rowtype;
  vFactor  serving_size.srvng_factor%type;
  cursor vRecipeCur(MealId meal.meal_id%type) is select rcp_id,
                                                         food_id,
                                                         amount,
                                                         unit_id
                                                    from recipe
                                                   where meal_id=MealId
                                                     and beg_date<=params_pkg.get_current_date                                                                  
                                                     and (end_date is null or end_date>=params_pkg.get_current_date);                                           
begin                                                                           
  meallog_foods_delete(rec.ml_id);
  vFactor:=meal_core_pkg.get_serving_size_factor(rec.srvng_size);
  for recipe in vRecipeCur(rec.meal_id) loop
    vFoodLog.fl_id   :=null;
    vFoodLog.ml_id   :=rec.ml_id;
    vFoodLog.rcp_id  :=recipe.rcp_id;
    vFoodLog.meal_id :=rec.meal_id;
    vFoodLog.food_id :=recipe.food_id;
    vFoodLog.amount  :=vFactor*recipe.amount;
    vFoodLog.unit_id :=recipe.unit_id;
    meal_core_pkg.meallog_foods_insert(vFoodLog);
  end loop;
end;
                                                                                
procedure meallog_save(ml_id       in out meal_log.ml_id%type,                  
                       ml_date     in meal_log.ml_date%type,                    
                       ml_time     in meal_log.ml_time%type,                    
                       ml_datetime in meal_log.ml_datetime%type,                
                       meal_id     in meal_log.meal_id%type,                    
                       srvng_size  in meal_log.srvng_size%type,                 
                       person_id   in meal_log.person_id%type,                  
                       comment_    in meal_log.comment_%type)
is                                                                              
  vRec     meal_log%rowtype;
begin
  vRec.ml_id       :=meallog_save.ml_id;                                        
  vRec.ml_date     :=to_char(to_date(meallog_save.ml_date, 'yyyy-mm-dd'), params_pkg.get_date_format);                                                          
  vRec.ml_time     :=to_char(to_date(meallog_save.ml_time, params_pkg.get_time_format), params_pkg.get_time_format);                                            
  vRec.ml_datetime :=nvl(meallog_save.ml_datetime, to_date(meallog_save.ml_date||' '||meallog_save.ml_time, 'yyyy-mm-dd hh24:mi'));                             
  vRec.meal_id     :=meallog_save.meal_id;
  vRec.srvng_size  :=meallog_save.srvng_size;
  vRec.person_id   :=meallog_save.person_id;
  vRec.comment_    :=meallog_save.comment_;
  if vRec.ml_id is null then
    meal_core_pkg.meal_log_insert(vRec);
    meallog_save.ml_id :=vRec.ml_id;
  else
    meal_core_pkg.meal_log_update(vRec);
  end if;
  meallog_foods_save(vRec);
end;                                                                            
                                                                                
procedure meallog_delete(ml_id in meal_log.ml_id%type)                          
is                                                                              
begin
  meallog_foods_delete(meallog_delete.ml_id);
  meal_core_pkg.meal_log_delete(meallog_delete.ml_id);
end;

end meal_pkg;