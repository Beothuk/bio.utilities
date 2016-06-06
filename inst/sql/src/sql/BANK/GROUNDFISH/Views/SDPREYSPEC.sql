--------------------------------------------------------
--  DDL for View SDPREYSPEC
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SDPREYSPEC" ("SPEC", "SCIENTIF", "COMMON", "IMAGE") AS 
  select research spec, scientif, common, vdc.ig.get_species(research) image
from mflib.species_codes
where research in (select distinct preyspeccd from sditem)
;
