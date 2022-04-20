CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_MEAL$SERVING_SIZE"
before insert or update
    on meal$serving_size
   for each row
begin
  if inserting then
    if :new.msz_id is null then select sq_meal$serving_size.nextval into :new.msz_id from dual; end if;
  end if;
  if :new.meal_id is null or :new.sz_id is null then
    raise_application_error(-20200, 'No MEAL_ID or SZ_ID specified!');
  end if;
end tg_meal$serving_size;
ALTER TRIGGER "DEV"."TG_MEAL$SERVING_SIZE" ENABLE;
