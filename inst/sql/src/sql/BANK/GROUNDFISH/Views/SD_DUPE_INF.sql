--------------------------------------------------------
--  DDL for View SD_DUPE_INF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SD_DUPE_INF" ("MISSION", "SETNO", "NUM_RECORDS") AS 
  SELECT mission, setno, count(1) num_records
      FROM SDInf
  GROUP BY mission, setno
    HAVING COUNT(1)>1
;
