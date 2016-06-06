--------------------------------------------------------
--  DDL for View L5SPECIES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."L5SPECIES" ("SPEC", "NMFS", "SPECIES", "COMM") AS 
  select code spec, nmfs, spec species, comm from gsspecies
;
