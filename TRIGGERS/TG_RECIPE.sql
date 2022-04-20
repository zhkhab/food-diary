CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_RECIPE"
before insert or update
    on recipe
   for each row
begin
  if inserting then
    if :new.rcp_id is null then select sq_recipe.nextval into :new.rcp_id from dual; end if;
  end if;
  if :new.meal_id is null then raise_application_error(-20200, 'No MEAL_ID specified!'); end if;
  if :new.food_id is null then raise_application_error(-20200, 'No FOOD_ID specified!'); end if;
  if :new.amount is null then raise_application_error(-20200, 'No AMOUNT specified!'); end if;
  if :new.unit_id is null then raise_application_error(-20200, 'No UNIT_ID specified!'); end if;
  if :new.beg_date is null then raise_application_error(-20200, 'No BEG_DATE specified!'); end if;
  if :new.beg_date > :new.end_date then
    raise_application_error(-20200, 'END_DATE can not be earlier than BEG_DATE!');
  end if;
end tg_recipe;
ALTER TRIGGER "DEV"."TG_RECIPE" ENABLE;