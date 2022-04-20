CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_MEAL_LOG"
before insert or update
    on meal_log
   for each row
begin
  if inserting then
    if :new.ml_id is null then select sq_meal_log.nextval into :new.ml_id from dual; end if;
  end if;
  if :new.ml_date is null then raise_application_error(-20200, 'No ML_DATE specified!'); end if;
  if :new.ml_time is null then raise_application_error(-20200, 'No ML_TIME specified!'); end if;
  if :new.ml_datetime is null then select to_date(:new.ml_date||' '||:new.ml_time, 'dd.mm.yyyy hh24:mi') into :new.ml_datetime from dual; end if;
  if :new.meal_id is null then raise_application_error(-20200, 'No MEAL_ID specified!'); end if;
  if :new.srvng_size is null then raise_application_error(-20200, 'No SRVNG_SIZE specified!'); end if;
  if :new.person_id is null then raise_application_error(-20200, 'No PERSON_ID specified!'); end if;
end tg_meal_log;
ALTER TRIGGER "DEV"."TG_MEAL_LOG" ENABLE;
