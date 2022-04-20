CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_FOOD_TYPE"
before insert or update
    on food_type
   for each row
begin
  if inserting then
    if :new.type_id is null then select sq_food_type.nextval into :new.type_id from dual; end if;
  end if;
  if :new.type_name is null then
    raise_application_error(-20200, 'Please, enter FOOD TYPE!');
  end if;
  if  :new.type_code is not null then params_pkg.check_code(:new.type_code); end if;
  if updating then
    if :new.is_selectable=0 and :old.is_selectable=1 then ref_pkg.check_ref_food(:old.type_id); end if;
  end if;
end tg_food_type;
ALTER TRIGGER "DEV"."TG_FOOD_TYPE" ENABLE;
