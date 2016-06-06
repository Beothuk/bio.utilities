--------------------------------------------------------
--  DDL for View NFYEARS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."NFYEARS" ("YEAR") AS 
  select distinct year from nfgsinf
;
