--------------------------------------------------------
--  DDL for View MESOPELAGIC_CRUISES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MESOPELAGIC_CRUISES" ("CRUISE") AS 
  select distinct cruise from mesopelagic
;
