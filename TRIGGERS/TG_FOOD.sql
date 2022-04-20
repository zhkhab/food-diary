CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_FOOD"
before insert or update
    on food
   for each row
begin
  if inserting then
    if :new.food_id is null then select sq_food.nextval into :new.food_id from dual; end if;
  end if;
  if :new.food_name is null then raise_application_error(-20200, 'Please, enter FOOD NAME!'); end if;
  if :new.food_type is not null then ref_pkg.is_selectable_check(:new.food_type); end if;
  if :new.is_organic is null then raise_application_error(-20200, 'Please, indicate if the food is organic!'); end if;
end tg_food;
ALTER TRIGGER "DEV"."TG_FOOD" ENABLE;