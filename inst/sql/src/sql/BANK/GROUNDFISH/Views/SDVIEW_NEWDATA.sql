--------------------------------------------------------
--  DDL for View SDVIEW_NEWDATA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SDVIEW_NEWDATA" ("DATASOURCE", "MISSION", "SETNO", "SDATE", "STIME", "SLAT", "SLONG", "STRAT", "NAFO", "DEPTH", "BOTTOM_TEMPERATURE", "SPEC", "FSHNO", "FWT", "FLEN", "TECH", "STOWGT", "EMPTYWGT", "FULLNESS", "PREYITEM", "PREYSPECCD", "PREYSPEC", "PWT", "PNUM", "PLEN", "DIGESTION", "REMARKS", "SAMPLE_INDEX") AS 
  select d.datasource, d.mission, to_number(decode(d.setno,999,NULL,d.setno)) setno, sdate, stime,
       slat, slong, strat, NAFO, depth,
       bottom_temperature, d.spec, d.fshno,
       fwt, flen, tech, stowgt, emptywgt, fullness,
       preyitem,preyspeccd, preyspec, pwt, pnum, plen, digestion, remarks, d.sample_index
from sdinf_backup_may11 i,
     sddet d,
     sdsto s
where d.datasource = i.datasource
  and d.mission = i.mission
  and d.setno = i.setno
  and d.datasource = s.datasource(+)
  and d.mission = s.mission(+)
  and d.setno = s.setno(+)
  and d.spec = s.spec(+)
  and d.fshno = s.fshno(+)
;
