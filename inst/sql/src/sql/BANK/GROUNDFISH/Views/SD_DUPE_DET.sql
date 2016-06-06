--------------------------------------------------------
--  DDL for View SD_DUPE_DET
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SD_DUPE_DET" ("MISSION", "SETNO", "SPEC", "FSHNO", "NUM_RECORDS") AS 
  SELECT mission, setno, spec, fshno, count(1) num_records
      FROM SDDet
  GROUP BY mission, setno, spec, fshno
  HAVING COUNT(1)>1
;
