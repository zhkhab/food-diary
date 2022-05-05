CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEV"."PARAMS_PKG" as

current_date           date;
user_date_format       varchar2(100);
user_time_format       varchar2(100);
user_datetime_format   varchar2(200);

russian_character      varchar2(100 char);  -- List of valid characters for russian names
english_character      varchar2(100);       -- List of valid characters for english names
special_character      varchar2(100);       -- List of valid special characters

procedure set_current_date(cdate in date default null)
is
begin
  current_date:=nvl(set_current_date.cdate, sysdate);
end;

function get_current_date return date
is
begin
  return current_date;
end;

procedure set_date_format(ud_format in varchar2 default null)
is
begin
  user_date_format:=nvl(set_date_format.ud_format, 'DD-MON-YYYY');
end;

function get_date_format return varchar2
is
begin
  return user_date_format;
end;

procedure set_time_format(ut_format in varchar2 default null)

is
begin
  user_time_format:=nvl(set_time_format.ut_format, 'HH24:MI');
end;

function get_time_format return varchar2
is
begin
  return user_time_format;
end;

procedure set_datetime_format(udt_format in varchar2 default null)
is
begin
  user_datetime_format:=nvl(set_datetime_format.udt_format, 'DD-MON-YYYY HH24:MI');
end;

function get_datetime_format return varchar2
is
begin
  return user_datetime_format;
end;

function first_capital_letter(check_str in varchar2)
return varchar2 is
  vStr varchar2(1000);
begin
  vStr:=upper(substr(check_str,1,1))||lower(substr(check_str,2)); --Converts the first letter to capital
  return vStr;
end;

function good_name(check_name in varchar2,
                   spec_chrctrs_allowed in boolean default false)
return boolean is
  vName             varchar2(200);
  vKey              boolean;
  vSpecialCharacter varchar2(100) default '-';
begin
  if spec_chrctrs_allowed then vSpecialCharacter :=special_character; end if;
  vName:=replace(upper(trim(check_name)),' ','');                    -- Removes trailing spaces and convert to upper case
  if ltrim(vName,russian_character||vSpecialCharacter) is null       -- If only russian characters
     or ltrim(vName,english_character||vSpecialCharacter) is null    -- If only english characters
  then
    vKey:=true;
  else
    vKey:=false;
  end if;
  return vKey;
end;

function check_name(check_str            in varchar2,
                    spec_chrctrs_allowed in boolean default false)
return varchar2 is
  vIsGoodName    boolean;
  not_good_name  exception;
begin
  vIsGoodName:=good_name(check_str, spec_chrctrs_allowed);
  if not vIsGoodName then raise not_good_name; end if;
  return first_capital_letter(check_str);
exception when not_good_name then
  raise_application_error(-20000, 'Invalid name. Allowed characters are letters and '||special_character);
end;

procedure check_code(check_str in out varchar2)
is
  not_good_code exception;
begin
  check_str:=upper(trim(check_str));
  if ltrim(check_str,english_character||'_') is not null then raise not_good_code; end if;
exception when not_good_code then
  raise_application_error(-20000, 'Invalid code. Allowed characters are only english letters and _');
end check_code;

function check_code_func(check_str in varchar2)
return varchar2 is
  vCode varchar2(100):=check_str;
begin
  check_code(vCode);
  return vCode;
end;

begin
  set_current_date;
  set_date_format;
  set_time_format;
  set_datetime_format;
  russian_character:='¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿';
  english_character:='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  special_character:='-/';
end params_pkg;