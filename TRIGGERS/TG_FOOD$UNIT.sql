CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_FOOD$UNIT"
before insert or update
    on food$unit
   for each row
begin
  if inserting then
    if :new.fu_id is null then select sq_food$unit.nextval into :new.fu_id from dual; end if;
  end if;
  if :new.food_id is null or :new.unit_id is null then
    raise_application_error(-20200, 'No FOOD_ID or UNIT_ID specified!');
  end if;
end tg_food$unit;
ALTER TRIGGER "DEV"."TG_FOOD$UNIT" ENABLE;