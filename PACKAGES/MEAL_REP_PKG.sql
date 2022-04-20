CREATE OR REPLACE EDITIONABLE PACKAGE "DEV"."MEAL_REP_PKG" as
/**
 Procedures used for reports
*/                                                                              

/** Meal log information report
*   @param person      Person identifier;
*   @param res_cur     Meal log information;
*/
procedure rep_meal_log(person  in out person.pers_id%type,                      
                       res_cur    out sys_refcursor);

/** Food log information report
*   @param person      Person identifier;
*   @param res_cur     Food log information;
*/
procedure rep_food_log(person  in out person.pers_id%type,
                       res_cur    out sys_refcursor);

end meal_rep_pkg;
