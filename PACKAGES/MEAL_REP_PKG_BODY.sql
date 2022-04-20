CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."MEAL_REP_PKG" as

procedure rep_meal_log(person  in out person.pers_id%type,
                       res_cur    out sys_refcursor)
is
begin
  open res_cur for with p as (
                              select pers_id,
                                     full_name,
                                     dob,
                                     person_pkg.get_pers_info(pers_id) pers_info
                                from person
                               where pers_id=rep_meal_log.person
                              )                                                 
                   select ml.ml_id,
                          ml.ml_date,
                          ml.ml_time,
                          ml.ml_datetime,
                          ml.meal_id,
                          m.meal_name,
                          m.is_homemade,
                          ml.srvng_size sz_id,
                          sz.srvng_size,
                          sz.srvng_factor,
                          sz.srvng_code,
                          ml.person_id,
                          p.full_name,
                          p.dob,
                          p.pers_info
                     from meal_log ml,
                          meal m,
                          p,
                          serving_size sz
                    where ml.meal_id=m.meal_id
                      and ml.srvng_size=sz.sz_id
                      and ml.person_id=p.pers_id;
end;                                                                            
                                                                                
procedure rep_food_log(person  in out person.pers_id%type,
                       res_cur    out sys_refcursor)
is
begin
  open res_cur for with p as (
                              select pers_id,
                                     full_name,
                                     dob,
                                     person_pkg.get_pers_info(pers_id) pers_info
                                from person
                               where pers_id=rep_food_log.person
                               )                                                
                   select fl.fl_id,
                          fl.ml_id,
                          ml.ml_datetime,
                          ml.ml_date,
                          ml.ml_time,
                          fl.meal_id,
                          m.meal_name,
                          m.is_homemade,
                          fl.food_id,
                          f.food_name,
                          ft.type_id,
                          ft.type_name,
                          ft.parent_id,
                          fl.amount,
                          fl.unit_id,
                          u.unit_name,
                          u.parent_id parent_unit,
                          u.factor
                     from food_log fl,
                          food f,
                          food_type ft,
                          meal_log ml,
                          meal m,
                          p,
                          unit u
                    where fl.ml_id=ml.ml_id
                      and fl.meal_id=m.meal_id
                      and fl.food_id=f.food_id
                      and f.food_type=ft.type_id(+)
                      and fl.unit_id=u.unit_id
                      and ml.person_id=p.pers_id;
end;

end meal_rep_pkg;