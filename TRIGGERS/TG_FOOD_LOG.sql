CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_FOOD_LOG"
before insert or update
    on food_log
   for each row
begin
  if inserting then
    if :new.fl_id is null then select sq_food_log.nextval into :new.fl_id from dual; end if;
  end if;
  if :new.ml_id is null then raise_application_error(-20200, 'ML_ID not found!'); end if;
  if :new.rcp_id is null then raise_application_error(-20200, 'RCP_ID not found!'); end if;
  if :new.meal_id is null then raise_application_error(-20200, 'MEAL_ID not found!'); end if;
  if :new.food_id is null then raise_application_error(-20200, 'FOOD_ID not found!'); end if;
  if :new.amount is null then raise_application_error(-20200, 'AMOUNT not found!'); end if;
  if :new.unit_id is null then raise_application_error(-20200, 'UNIT_ID not found!'); end if;
end tg_food_log;
ALTER TRIGGER "DEV"."TG_FOOD_LOG" ENABLE;