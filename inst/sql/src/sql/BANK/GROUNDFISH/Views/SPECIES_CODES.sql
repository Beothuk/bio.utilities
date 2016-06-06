--------------------------------------------------------
--  DDL for View SPECIES_CODES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SPECIES_CODES" ("RESEARCH", "ICNAF", "FAO", "COMMON", "SCIENTIF", "COMMER", "NMFS", "ENTR") AS 
  select "RESEARCH","ICNAF","FAO","COMMON","SCIENTIF","COMMER","NMFS","ENTR" from mflib.species_codes where research in
  (select distinct spec from gscatp70)
;
 

   COMMENT ON TABLE "GROUNDFISH"."SPECIES_CODES"  IS 'View of MFLIB.species_codes';
