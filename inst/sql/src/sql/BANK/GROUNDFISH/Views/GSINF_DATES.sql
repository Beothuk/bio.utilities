--------------------------------------------------------
--  DDL for View GSINF_DATES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSINF_DATES" ("YEARCOLLECTED", "MONTHCOLLECTED") AS 
  select to_char(sdate,'yyyy') yearcollected, to_char(sdate,'mm') monthcollected from gsinf
;
