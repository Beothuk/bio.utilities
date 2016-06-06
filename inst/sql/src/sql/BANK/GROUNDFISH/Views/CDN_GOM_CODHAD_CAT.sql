--------------------------------------------------------
--  DDL for View CDN_GOM_CODHAD_CAT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."CDN_GOM_CODHAD_CAT" ("MISSION", "SETNO", "SPEC", "TOTNO", "TOTWGT", "SAMPWGT") AS 
  select mission, setno, spec, totno, totwgt, sampwgt from gscat
  where (spec = 010 or spec = 040) AND (mission, setno) IN
    (select mission, setno from gsinf where strat in
                              (select strat from gsstratum where name like '4X%' or name like '5Z'))
;
