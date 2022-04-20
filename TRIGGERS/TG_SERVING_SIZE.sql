CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_SERVING_SIZE"
before insert or update
    on serving_size
   for each row
begin
  if inserting then
    if :new.sz_id is null then select sq_serving_size.nextval into :new.sz_id from dual; end if;
  end if;
  if :new.srvng_size is null then raise_application_error(-20200, 'Please, enter SERVING SIZE!'); end if;
  if  :new.srvng_code is not null then params_pkg.check_code(:new.srvng_code); end if;
end tg_serving_size;
ALTER TRIGGER "DEV"."TG_SERVING_SIZE" ENABLE;