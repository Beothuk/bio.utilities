--------------------------------------------------------
--  DDL for View CDN_GOM_CODHAD_LF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."CDN_GOM_CODHAD_LF" ("MISSION", "SETNO", "SPEC", "FLEN", "CLEN") AS 
  select mission, setno, spec, flen, sum(clen) clen   from gsdet
  where (spec = 010 or spec = 040) AND (mission, setno) IN
    (select mission, setno from gsinf where strat in
                              (select strat from gsstratum where name like '4X%' or name like '5Z'))
  group by mission, setno, spec, flen
;
