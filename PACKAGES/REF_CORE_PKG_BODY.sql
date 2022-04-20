CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."REF_CORE_PKG" as            
                                                                                
function get_unit_id(unit_name in unit.unit_name%type)                          
return unit.unit_id%type is                                                     
  vUnitId unit.unit_id%type;                                                    
begin                                                                           
  begin                                                                         
    select unit_id                                                              
      into vUnitId                                                              
      from unit                                                                 
     where unit_name=get_unit_id.unit_name;                                     
  exception when no_data_found then raise_application_error(-20000, 'Unit not found!');                                                                         
            when too_many_rows then raise_application_error(-20000, 'Multiple units found!');                                                                   
  end;                                                                          
  return vUnitId;                                                               
end;                                                                            
                                                                                
procedure unit_insert(rec in out unit%rowtype)                                  
is                                                                              
begin                                                                           
  insert into unit values rec returning unit_id into rec.unit_id;               
end;                                                                         

procedure unit_update(rec in unit%rowtype)                                      
is                                                                              
begin                                                                           
  if rec.unit_id is not null then                                               
     update unit set row = rec where unit_id=rec.unit_id;                       
  end if;                                                                       
end;                                                                            
                                                                                
procedure unit_delete(unit_id in unit.unit_id%type)                             
is                                                                              
begin                                                                           
  if unit_id is not null then                                                   
     delete from unit where unit_id=unit_delete.unit_id;
  end if;                                                                       
end;                                                                            
                                                                                
procedure unit_delete(unit_name in unit.unit_name%type)                         
is                                                                              
  vUnitId unit.unit_id%type;                                                    
begin                                                                           
  vUnitId:=get_unit_id(unit_delete.unit_name);                                  
  unit_delete(vUnitId);                                                         
end;                                                                            
                                                                                
----------------------------------------                                                                                

function get_food_id(food_name in food.food_name%type)                          
return food.food_id%type is                                                     
  vFoodId food.food_id%type;                                                    
begin                                                                           
  begin                                                                         
    select food_id                                                              
      into vFoodId                                                              
      from food                                                                 
      where food_name=get_food_id.food_name;                                    
  exception when no_data_found then raise_application_error(-20000, 'Food not found!');                                                                         
            when too_many_rows then raise_application_error(-20000, 'Multiple foods found!');
  end;                                                                          
  return vFoodId;                                                               
end;                                                                            
                                                                                
procedure food_insert(rec in out food%rowtype)                                  
is                                                                              
begin                                                                           
  insert into food values rec returning food_id into rec.food_id;               
end;                                                                            
                                                                                
procedure food_update(rec in food%rowtype)                                      
is                                                                              
begin
  if rec.food_id is not null then                                               
     update food set row = rec where food_id=rec.food_id;                       
  end if;                                                                       
end;                                                                            
                                                                                
procedure food_delete(food_id in food.food_id%type)                             
is                                                                              
begin                                                                           
  if food_id is not null then                                                   
     delete from food where food_id=food_delete.food_id;                        
  end if;                                                                       
end;                                                                            

procedure food_delete(food_name in food.food_name%type)                         
is                                                                              
  vFoodId food.food_id%type;                                                    
begin                                                                           
  vFoodId:=get_food_id(food_delete.food_name);                                  
  food_delete(vFoodId);                                                         
end;                                                                            
                                                                                
-----------------------------------------                                       
                                                                                
function get_meal_id(meal_name in meal.meal_name%type)                          
return meal.meal_id%type is                                                     
  vMealId meal.meal_id%type;
begin                                                                           
  begin                                                                         
    select meal_id                                                              
      into vMealId                                                              
      from meal                                                                 
      where meal_name=get_meal_id.meal_name;                                    
  exception when no_data_found then raise_application_error(-20000, 'Meal not found!');                                                                         
            when too_many_rows then raise_application_error(-20000, 'Multiple meals found!');                                                                   
  end;                                                                          
  return vMealId;                                                               
end;                                                                            

procedure meal_insert(rec in out meal%rowtype)                                  
is                                                                              
begin                                                                           
  insert into meal values rec returning meal_id into rec.meal_id;               
end;                                                                            
                                                                                
procedure meal_update(rec in meal%rowtype)                                      
is                                                                              
begin                                                                           
  if rec.meal_id is not null then                                               
     update meal set row = rec where meal_id=rec.meal_id;                       
  end if;
end;                                                                            
                                                                                
procedure meal_delete(meal_id in meal.meal_id%type)                             
is                                                                              
begin                                                                           
  if meal_id is not null then                                                   
     delete from meal where meal_id=meal_delete.meal_id;                        
  end if;                                                                       
end;                                                                            
                                                                                
procedure meal_delete(meal_name in meal.meal_name%type)                         
is                                                                              
  vMealId meal.meal_id%type;
begin                                                                           
  vMealId:=get_meal_id(meal_delete.meal_name);                                  
  meal_delete(vMealId);                                                         
end;                                                                            
                                                                                
-----------------------------------------                                       
                                                                                
procedure food$unit_insert(rec in out food$unit%rowtype)                        
is                                                                              
begin                                                                           
  if rec.food_id is not null and rec.unit_id is not null then                   
     insert into food$unit values rec returning fu_id into rec.fu_id;           
  end if;
end;                                                                            
                                                                                
/*                                                                              
procedure food$unit_update(rec in food$unit%rowtype)                            
is                                                                              
  procedure foodunit_update(rec in food$unit%rowtype)                           
  is                                                                            
  begin                                                                         
    update food$unit set food_id = rec.food_id, unit_id = rec.unit_id where fu_id=rec.fu_id;                                                                    
  end;
  procedure food_update(fu_id   in food$unit.fu_id%type,
                        food_id in food$unit.food_id%type)                      
  is                                                                            
  begin                                                                         
    update food$unit set food_id=food_update.food_id where fu_id=food_update.fu_id;                                                                             
  end;                                                                          
  procedure unit_update(fu_id   in food$unit.fu_id%type,                        
                        unit_id in food$unit.unit_id%type)                      
  is                                                                            
  begin                                                                         
    update food$unit set unit_id=unit_update.unit_id where fu_id=unit_update.fu_id;
  end;                                                                          
begin                                                                           
  if rec.fu_id is not null then                                                 
    if rec.food_id is not null and rec.unit_id is not null then foodunit_update(rec);                                                                           
    else                                                                        
      if rec.unit_id is not null then unit_update(rec.fu_id, rec.unit_id); end if;                                                                              
      if rec.food_id is not null then food_update(rec.fu_id, rec.food_id); end if;                                                                              
    end if;                                                                     
  end if;
end;                                                                            
*/                                                                              
procedure food$unit_update(rec in food$unit%rowtype)                            
is                                                                              
begin                                                                           
  if rec.fu_id is not null then                                                 
    update food$unit set row = rec where fu_id=rec.fu_id;                       
  end if;                                                                       
end;                                                                            
                                                                                
procedure food$unit_delete(fu_id in food$unit.fu_id%type)                       
is                                                                              
begin
  if fu_id is not null then                                                   
    delete from food$unit where fu_id=food$unit_delete.fu_id;                
  end if;                                                                       
end;
                                                                                
-----------------------------------------                                       
                                                                                
function get_foodtype_id(type_name in food_type.type_name%type)                 
return food_type.type_id%type is                                                
  vFoodtypeId food_type.type_id%type;                                           
begin                                                                           
  if get_foodtype_id.type_name is not null then                                 
    begin
      select type_id                                                            
        into vFoodtypeId                                                        
        from food_type                                                          
       where type_name=get_foodtype_id.type_name;                               
    exception when no_data_found then raise_application_error(-20000, 'Food type not found!');                                                                  
              when too_many_rows then raise_application_error(-20000, 'Multiple food types found!');                                                            
    end;                                                                        
  end if;                                                                       
  return vFoodtypeId;                                                           
end;                                                                            

procedure foodtype_insert(rec in out food_type%rowtype)                         
is                                                                              
begin                                                                           
  insert into food_type values rec returning type_id into rec.type_id;          
end;                                                                            
                                                                                
procedure foodtype_update(rec in food_type%rowtype)                             
is                                                                              
begin                                                                           
  if rec.type_id is not null then                                               
    update food_type set row = rec where type_id=rec.type_id;                  
  end if;                                                                       
end;                                                                            
                                                                                
procedure foodtype_delete(type_id in food_type.type_id%type)                    
is                                                                              
begin                                                                           
  if type_id is not null then                                                   
    delete from food_type where type_id=foodtype_delete.type_id;               
  end if;                                                                       
end;                                                                            
                                                                                
procedure foodtype_delete(type_name in food_type.type_name%type)                
is                                                                              
  vFoodtypeId food_type.type_id%type;                                           
begin
  vFoodtypeId:=get_foodtype_id(foodtype_delete.type_name);                      
  foodtype_delete(vFoodtypeId);                                                 
end;
                                                                                
-----------------------------------------                                       
                                                                                
procedure meal$serving_size_insert(rec in out meal$serving_size%rowtype)        
is                                                                              
begin                                                                           
  if rec.meal_id is not null and rec.sz_id is not null then                     
    insert into meal$serving_size values rec returning msz_id into rec.msz_id; 
  end if;                                                                       
end;
                                                                                
/*                                                                              
procedure meal$serving_size_update(rec in meal$serving_size%rowtype)            
is                                                                              
  procedure mealservingsize_update(rec in meal$serving_size%rowtype)            
  is                                                                            
  begin                                                                         
    update meal$serving_size set meal_id = rec.meal_id, sz_id = rec.sz_id where msz_id=rec.msz_id;                                                              
  end;                                                                          
  procedure meal_update(msz_id   in meal$serving_size.msz_id%type,              
                        meal_id  in meal$serving_size.meal_id%type)
  is                                                                            
  begin                                                                         
    update meal$serving_size set meal_id=meal_update.meal_id where msz_id=meal_update.msz_id;                                                                   
  end;                                                                          
  procedure servingsize_update(msz_id  in meal$serving_size.msz_id%type,        
                               sz_id   in meal$serving_size.sz_id%type)         
  is                                                                            
  begin                                                                         
    update meal$serving_size set sz_id=servingsize_update.sz_id where msz_id=servingsize_update.msz_id;                                                         
  end;
begin                                                                           
  if rec.msz_id is not null then                                                
    if rec.meal_id is not null and rec.sz_id is not null then mealservingsize_update(rec);                                                                      
    else                                                                        
      if rec.sz_id is not null then servingsize_update(rec.msz_id, rec.sz_id); end if;                                                                          
      if rec.meal_id is not null then meal_update(rec.msz_id, rec.meal_id); end if;                                                                             
    end if;                                                                     
  end if;                                                                       
end;
*/                                                                              
                                                                                
procedure meal$serving_size_update(rec in meal$serving_size%rowtype)            
is                                                                              
begin                                                                           
  if rec.msz_id is not null then                                                
    update meal$serving_size set row = rec where msz_id=rec.msz_id;            
  end if;                                                                       
end;                                                                            
                                                                                
procedure meal$serving_size_delete(msz_id in meal$serving_size.msz_id%type)     
is                                                                              
begin
  if msz_id is not null then                                                  
    delete from meal$serving_size where msz_id=meal$serving_size_delete.msz_id;                                                                              
  end if;                                                                       
end;                                                                            
                                                                                
--------------------------------------------                                    
                                                                                
procedure grocery_store_insert(rec in out grocery_store%rowtype)                
is                                                                              
begin                                                                           
  insert into grocery_store values rec returning store_id into rec.store_id;    
end;                                                                            

procedure grocery_store_update(rec in grocery_store%rowtype)                    
is                                                                              
begin                                                                           
  if rec.store_id is not null then                                            
    update grocery_store set row = rec where store_id=rec.store_id;            
  end if;                                                                       
end;                                                                            
                                                                                
procedure grocery_store_delete(store_id in grocery_store.store_id%type)         
is                                                                              
begin                                                                           
  if store_id is not null then
   delete from grocery_store where store_id=grocery_store_delete.store_id;  
  end if;                                                                       
end;                                                                            
                                                                                
end ref_core_pkg;
