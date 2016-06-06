--------------------------------------------------------
--  DDL for View GSSPECIES_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSSPECIES_VIEW" ("CODE", "COMM", "SPEC") AS 
  select code,
       comm||' ['||code||']' comm,
       spec||' ['||code||']' spec
from gsspecies
;
