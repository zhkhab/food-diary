CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."REF_PKG" as                 
                                                                                
procedure check_ref_food(type_id in food_type.type_id%type)                     
is                                                                              
  vNum number;                                                                  
begin                                                                           
  select 1                                                                      
    into vNum                                                                   
    from food                                                                   
  where food_type = check_ref_food.type_id                                      
    and rownum=1;                                                               
  if vNum = 1 then
    raise_application_error(-20000, 'Foods found for this type. This food type can not be unselected');                                                         
  end if;                                                                       
exception when no_data_found then null;                                         
end;                                                                            
                                                                                
procedure is_selectable_check(type_id in food_type.type_id%type)                
is                                                                              
  vValue food_type.is_selectable%type;                                          
begin                                                                           
  select is_selectable                                                          
    into vValue                                                                 
    from food_type
   where type_id = is_selectable_check.type_id;                                 
  if vValue<>1 then                                                             
    raise_application_error(-20000, 'This food type is not selectable');        
  end if;                                                                       
end;                                                                            
                                                                                
end ref_pkg;
