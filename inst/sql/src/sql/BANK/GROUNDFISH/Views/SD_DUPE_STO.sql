--------------------------------------------------------
--  DDL for View SD_DUPE_STO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SD_DUPE_STO" ("MISSION", "SETNO", "SPEC", "FSHNO", "PREYSPECCD", "NUM_RECORDS") AS 
  SELECT mission, setno, spec, fshno, preyspeccd, count(1) num_records
      FROM SDSto
  GROUP BY mission, setno, spec, fshno, preyspeccd
  HAVING COUNT(1)>1
;
