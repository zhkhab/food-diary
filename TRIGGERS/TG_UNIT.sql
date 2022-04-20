CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_UNIT"
before insert or update
    on unit
   for each row
begin
  if inserting then
    if :new.unit_id is null then select sq_unit.nextval into :new.unit_id from dual; end if;
  end if;
  if :new.unit_name is null then
    raise_application_error(-20200, 'Please, enter UNIT NAME!');
  end if;
  if :new.parent_id is not null and :new.factor is null then
    raise_application_error(-20200, 'Please, enter FACTOR for '||:new.unit_name||'!');
  end if;
end tg_unit;
ALTER TRIGGER "DEV"."TG_UNIT" ENABLE;