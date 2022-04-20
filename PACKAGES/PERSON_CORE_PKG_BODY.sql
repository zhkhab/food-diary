CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."PERSON_CORE_PKG" as         
                                                                                
procedure person_insert(rec in out person%rowtype)                              
is                                                                              
begin                                                                           
  insert into person values rec returning pers_id into rec.pers_id;           
end;                                                                            
                                                                                
procedure person_update(rec in person%rowtype)                                  
is                                                                              
begin                                                                           
  if rec.pers_id is not null then
     update person set first_name  = rec.first_name,                            
                       last_name   = rec.last_name,                             
                       middle_name = rec.middle_name,                           
                       dob         = rec.dob,                                   
                       full_name   = rec.full_name                              
                 where pers_id=rec.pers_id;                                     
  end if;                                                                       
end;                                                                            
                                                                                
procedure person_delete(pers_id in person.pers_id%type)                         
is                                                                              
begin                                                                           
  if person_delete.pers_id is not null then                                     

     delete from person where pers_id=person_delete.pers_id;                    
  end if;                                                                       
end;                                                                            
                                                                                
end person_core_pkg;