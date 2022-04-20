CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_GROCERY_STORE"
before insert or update
    on grocery_store
   for each row
begin
  if inserting then
    if :new.store_id is null then select sq_grocery_store.nextval into :new.store_id from dual; end if;
  end if;
  if :new.store_name is null then
    raise_application_error(-20200, 'Please, enter STORE NAME!');
  end if;
  if :new.store_code is not null then params_pkg.check_code(:new.store_code); end if;
end tg_grocery_store;
ALTER TRIGGER "DEV"."TG_GROCERY_STORE" ENABLE;