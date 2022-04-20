CREATE OR REPLACE EDITIONABLE TRIGGER "DEV"."TG_PERSON"
before insert or update
    on person
   for each row
begin
  if inserting then
    if :new.pers_id is null then select sq_person.nextval into :new.pers_id from dual; end if;
  end if;
  if :new.first_name is null then raise_application_error(-20200, 'Please, enter FIRST NAME!'); end if;
  if :new.last_name is null then raise_application_error(-20200, 'Please, enter LAST NAME!'); end if;
  if :new.dob is null then raise_application_error(-20200, 'Please, enter DATE OF BIRTH!'); end if;
  if :new.full_name is null then select :new.first_name||' '||:new.last_name into :new.full_name from dual; end if;
end tg_person;
ALTER TRIGGER "DEV"."TG_PERSON" ENABLE;