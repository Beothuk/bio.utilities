--------------------------------------------------------
--  DDL for View NF_SPECIES_LIST
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."NF_SPECIES_LIST" ("SPEC", "COMMON") AS 
  select distinct nfld_spec spec, commonname common
from nfld_sp_codes
where nfld_spec in
(select distinct spec
   from nfgscat)
;
