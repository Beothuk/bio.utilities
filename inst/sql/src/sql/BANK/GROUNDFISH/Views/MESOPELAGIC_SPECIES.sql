--------------------------------------------------------
--  DDL for View MESOPELAGIC_SPECIES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MESOPELAGIC_SPECIES" ("SP_CODE", "TSN", "SCIENTIFICNAME", "ORDERNAME", "FAMILYNAME", "GENUSNAME", "SPECIESNAME") AS 
  select distinct sp_code, tsn, 
  scientificname,
  ordername,
  familyname,
  genusname,
  speciesname
from groundfish.mesopelagic_vw;
