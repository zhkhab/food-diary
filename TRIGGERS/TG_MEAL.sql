CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_MEAL"
before insert or update
    on meal
   for each row
begin
  if inserting then
    if :new.meal_id is null then select sq_meal.nextval into :new.meal_id from dual; end if;
  end if;
  if :new.meal_name is null then
    raise_application_error(-20200, 'Please, enter MEAL NAME!');
  end if;
end tg_meal;
ALTER TRIGGER "DEV"."TG_MEAL" ENABLE;
