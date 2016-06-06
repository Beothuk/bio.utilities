--------------------------------------------------------
--  DDL for View MESOPELAGIC_FAMILIES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MESOPELAGIC_FAMILIES" ("FAMILYNAME") AS 
  select distinct familyname
from groundfish.mesopelagic_vw
WHERE FAMILYNAME IS NOT NULL;
