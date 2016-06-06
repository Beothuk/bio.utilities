--------------------------------------------------------
--  DDL for View P70_SPECIES_NAMES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."P70_SPECIES_NAMES" ("SPECIES_NUMBER", "SPECIES_NAME", "SET_ORDER") AS 
  (select research species_number,
		decode(NVL(species_no,0),0,common,species_name) species_name,
		NVL(set_order,'99') set_order
	from mflib.species_codes a, speciesOrder b
	where a.research=b.species_no(+))
;
