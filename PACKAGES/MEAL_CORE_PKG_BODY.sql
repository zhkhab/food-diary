CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."MEAL_CORE_PKG" as

procedure meal_log_insert(rec in out meal_log%rowtype)
is
begin
  insert into meal_log values rec returning ml_id into rec.ml_id;
end;

procedure meal_log_update(rec in meal_log%rowtype)
is
begin
  if rec.ml_id is not null then
     update meal_log set ml_date = rec.ml_date,
                         ml_time = rec.ml_time,
                         ml_datetime = rec.ml_datetime,
                         meal_id = rec.meal_id,
                         srvng_size = rec.srvng_size,
                         person_id = rec.person_id,
                         comment_ = rec.comment_
                   where ml_id=rec.ml_id;
  end if;
end;

procedure meal_log_delete(ml_id in meal_log.ml_id%type)
is
begin
  if meal_log_delete.ml_id is not null then
    delete from meal_log where ml_id=meal_log_delete.ml_id;
  end if;
end;

--------------------------------------------

procedure meallog_foods_insert(rec in out food_log%rowtype)
is
begin
  insert into food_log values rec returning fl_id into rec.fl_id;
end;

procedure meallog_foods_update(rec in food_log%rowtype)
is
begin
  if rec.fl_id is not null then
    update food_log set row = rec where fl_id=rec.fl_id;
  end if;
end;

procedure meallog_foods_delete(fl_id in food_log.fl_id%type)
is
begin
  if meallog_foods_delete.fl_id is not null then
    delete from food_log where fl_id=meallog_foods_delete.fl_id;
  end if;
end;

--------------------------------------------

procedure recipe_insert(rec in out recipe%rowtype)
is
begin
  insert into recipe values rec returning rcp_id into rec.rcp_id;
end;

procedure recipe_update(rec in recipe%rowtype)
is
begin
  if rec.rcp_id is not null then
    update recipe set row = rec where rcp_id=rec.rcp_id;
  end if;
end;

procedure recipe_delete(rcp_id in recipe.rcp_id%type)
is
begin
  if recipe_delete.rcp_id is not null then
    delete from recipe where rcp_id=recipe_delete.rcp_id;
  end if;
end;

--------------------------------------------

function get_serving_size_id(srvng_size in serving_size.srvng_size%type)
return serving_size.sz_id%type is
  vSzId serving_size.sz_id%type;
begin
  begin
    select sz_id
      into vSzId
      from serving_size
     where srvng_size=get_serving_size_id.srvng_size;
  exception when no_data_found then raise_application_error(-20000, 'Serving size not found!');
            when too_many_rows then raise_application_error(-20000, 'Multiple serving sizes found!');
  end;
  return vSzId;
end;

procedure serving_size_insert(rec in out serving_size%rowtype)
is
begin
  insert into serving_size values rec returning sz_id into rec.sz_id;
end;


procedure serving_size_update(rec in serving_size%rowtype)
is
begin
  if rec.sz_id is not null then
     update serving_size set row = rec where sz_id=rec.sz_id;
  end if;
end;

procedure serving_size_delete(sz_id in serving_size.sz_id%type)
is
begin
  if sz_id is not null then
    delete from serving_size where sz_id=serving_size_delete.sz_id;
  end if;
end;

procedure serving_size_delete(srvng_size in serving_size.srvng_size%type)
is
  vSzId serving_size.sz_id%type;
begin
  vSzId:=get_serving_size_id(serving_size_delete.srvng_size);
  serving_size_delete(vSzId);
end;

function get_serving_size_factor(sz_id in serving_size.sz_id%type)
return serving_size.srvng_factor%type is
  vSrvngFactor serving_size.srvng_factor%type;
begin
  begin
    select srvng_factor
      into vSrvngFactor
      from serving_size
     where sz_id=get_serving_size_factor.sz_id;
  exception when no_data_found then raise_application_error(-20000, 'Serving factor not found!');
  end;
  return nvl(vSrvngFactor, 1);
end;

end meal_core_pkg;
