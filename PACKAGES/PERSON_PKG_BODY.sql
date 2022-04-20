CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."PERSON_PKG" as              
                                                                                
procedure set_current_person(pers_id in person.pers_id%type)                    
is                                                                              
begin                                                                           
  current_person:=set_current_person.pers_id;                                   
end;                                                                            
                                                                                
function get_current_person                                                     
return person.pers_id%type is                                                   
begin                                                                           
  return current_person;                                                        
end;                                                                            
                                                                                
function get_pers_id(rec in person%rowtype)                                     
return person.pers_id%type is                                                   
  vPersId person.pers_id%type;                                                  
begin                                                                           
  if rec.first_name is not null and rec.last_name is not null then              
    begin                                                                       
      select pers_id                                                            
        into vPersId                                                            
        from person                                                             
       where first_name = rec.first_name                                        
         and last_name = rec.last_name
         and (rec.middle_name is null or middle_name=rec.middle_name)           
         and (rec.dob is null or dob=rec.dob);                                  
    exception when no_data_found then                                           
                raise_application_error(-20000, 'No person found!');            
              when too_many_rows then                                           
                raise_application_error(-20000, 'Multiple person found!');      
    end;                                                                        
  end if;                                                                       
  return vPersId;                                                               
end;                                                                            
                                                                                
function get_pers_name(rec in person%rowtype)                                   
return varchar2 is
  vPersName varchar2(200);                                                      
begin                                                                           
  if rec.pers_id is not null then                                               
    begin                                                                       
      select initcap(first_name||' '||last_name)                                
        into vPersName                                                          
        from person                                                             
       where pers_id = rec.pers_id;                                             
    exception when no_data_found then                                           
                raise_application_error(-20000, 'No person found!');            
    end;                                                                        
  else                                                                          
    begin
      select initcap(first_name||' '||last_name)                                
        into vPersName                                                          
        from person                                                             
       where (rec.first_name is null or first_name = rec.first_name)            
         and (rec.first_name is null or last_name = rec.last_name)              
         and (rec.middle_name is null or middle_name=rec.middle_name)           
         and (rec.dob is null or dob=rec.dob);                                  
    exception when no_data_found then                                           
                raise_application_error(-20000, 'No person found!');            
              when too_many_rows then                                           
                raise_application_error(-20000, 'Multiple person found!');      
    end;                                                                        
  end if;                                                                       
  return vPersName;                                                             
end;                                                                            
                                                                                
function get_pers_info(pers_id in person.pers_id%type)                          
return varchar2 is                                                              
  vPersinfo varchar2(400);                                                      
begin                                                                           
  if get_pers_info.pers_id is not null then                                     
    begin                                                                       
      select nvl(full_name, first_name||' '||last_name)||', '||to_char(dob, params_pkg.get_date_format)                                                         
        into vPersinfo                                                          
        from person
       where pers_id=get_pers_info.pers_id;                                     
    exception when no_data_found then                                           
      raise_application_error(-20000, 'No person found');                       
    end;                                                                        
  end if;                                                                       
  return vPersinfo;                                                             
end;                                                                            
                                                                                
procedure person_save(pers_id     in out person.pers_id%type,                   
                      first_name  in person.first_name%type,                    
                      last_name   in person.last_name%type,                     
                      middle_name in person.middle_name%type default null,      
                      dob         in person.dob%type,
                      full_name   in person.full_name%type default null)        
is                                                                              
  vRec person%rowtype;                                                          
  vIsGoodName boolean;                                                          
  not_good_name exception;                                                      
begin                                                                           
  vIsGoodName :=params_pkg.good_name(person_save.first_name||person_save.middle_name||person_save.last_name);                                                   
  if not vIsGoodName then raise not_good_name; end if;                          
  vRec.pers_id     :=person_save.pers_id;                                       
  vRec.first_name  :=initcap(person_save.first_name);                           
  vRec.last_name   :=initcap(person_save.last_name);                            
  vRec.middle_name :=initcap(person_save.middle_name);
  vRec.dob         :=person_save.dob;                                           
  vRec.full_name   :=initcap(nvl(person_save.full_name, person_save.first_name||' '||person_save.last_name));                                                   
  if vRec.pers_id is null then                                                  
    person_core_pkg.person_insert(vRec);                                        
    person_save.pers_id :=vRec.pers_id;                                         
  else                                                                          
    person_core_pkg.person_update(vRec);                                        
  end if;                                                                       
exception when not_good_name then                                               
  raise_application_error(-20000, 'Invalid name. Allowed characters are letters and -');                                                                        
end;                                                                            
                                                                               
end person_pkg;