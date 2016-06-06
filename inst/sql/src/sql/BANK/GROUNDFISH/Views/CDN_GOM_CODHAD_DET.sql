--------------------------------------------------------
--  DDL for View CDN_GOM_CODHAD_DET
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."CDN_GOM_CODHAD_DET" ("MISSION", "SETNO", "SPEC", "FSHNO", "FLEN", "FSEX", "FMAT", "FWT", "AGE", "CLEN") AS 
  select mission, setno, spec, fshno, flen, FSEX, FMAT, FWT, AGE, CLEN     from gsdet
  where (spec = 010 or spec = 040) AND (fshno is NOT NULL OR fmat is NOT NULL OR age is NOT NULL) AND  (mission, setno) IN
    (select mission, setno from gsinf where strat in
                              (select strat from gsstratum where name like '4X%' or name like '5Z'))
;
