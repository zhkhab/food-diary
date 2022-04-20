CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."PARAMS_PKG" as
/**
 Procedures for working with APP PARAMETERS
*/
current_date           date;
user_date_format       varchar2(100);
user_time_format       varchar2(100);
user_datetime_format   varchar2(200);

russian_character      varchar2(100 char);  -- List of valid characters for russian names
english_character      varchar2(100);       -- List of valid characters for english names
special_character      varchar2(100);       -- List of valid special characters

/** Sets current date
*   @param cdate   Current date;
*/
procedure set_current_date(cdate in date default null);

/** Gets current date
*/
function get_current_date return date;

/** Sets user date format
*   @param ud_format   Date format mask;
*/
procedure set_date_format(ud_format in varchar2 default null);

/** Gets user date format
*/
function get_date_format return varchar2;

/** Sets user time format
*   @param ut_format   Time format mask;
*/
procedure set_time_format(ut_format in varchar2 default null);

/** Gets user time format
*/
function get_time_format return varchar2;

/** Sets user datetime format
*   @param udt_format   Datetime format mask;
*/
procedure set_datetime_format(udt_format in varchar2 default null);

/** Gets user datetime format
*/
function get_datetime_format return varchar2;

/** Converts the first letter to capital
*   @param check_str   Checking string;
*/
function first_capital_letter(check_str in varchar2) return varchar2;

/** Returns information about the correct choice of the name
*   @param check_name             Name to check;
*   @param spec_chrctrs_allowed   Is special characters allowed;
*/
function good_name(check_name           in varchar2,
                   spec_chrctrs_allowed in boolean default false) return boolean;

/** Checks if the name is entered correctly and returns the name
*   @param check_name             Name to check;
*   @param spec_chrctrs_allowed   Is special characters allowed;
*/
function check_name(check_str            in varchar2,
                    spec_chrctrs_allowed in boolean default false) return varchar2;

/** Checks if code (such as food type code) are entered correctly.
*   @param check_str   Checking string;
*/
procedure check_code(check_str in out varchar2);

/** Checks if code (such as food type code) are entered correctly. If ok, returns the code
*   @param check_str   Checking string;
*/
function check_code_func(check_str in varchar2) return varchar2;

end params_pkg;