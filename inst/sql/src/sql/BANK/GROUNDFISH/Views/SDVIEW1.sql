--------------------------------------------------------
--  DDL for View SDVIEW1
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SDVIEW1" ("DATASOURCE", "MISSION", "SETNO", "SDATE", "STIME", "SLAT", "SLONG", "STRAT", "NAFO", "DEPTH", "BOTTOM_TEMPERATURE", "SPEC", "FSHNO", "FWT", "FLEN", "TECH", "STOWGT", "EMPTYWGT", "FULLNESS", "PREYITEM", "PREYSPECCD", "PREYSPEC", "PWT", "PNUM", "PLEN", "DIGESTION", "REMARKS", "SAMPLE_INDEX") AS 
  select d.datasource, d.mission, to_number(decode(d.setno,999,NULL,d.setno)) setno, sdate, stime,
       slat, slong, strat, NAFO, depth,
       bottom_temperature, d.spec, d.fshno,
       fwt, flen, tech, stowgt, emptywgt, fullness,
       preyitem,preyspeccd, preyspec, pwt, pnum, plen, digestion, remarks, d.sample_index
from sdinf i,
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
 

   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."DATASOURCE" IS 'Trip type code';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."MISSION" IS 'Trip Id';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."SETNO" IS 'Set Number';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."SDATE" IS 'Set date';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."STIME" IS 'Set time (24hr)';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."SLAT" IS 'Set latitude (DDMM.MM)';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."SLONG" IS 'Set longitude (DDMM.MM)';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."STRAT" IS 'Stratum';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."NAFO" IS 'NAFO division';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."DEPTH" IS 'bottom depth';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."BOTTOM_TEMPERATURE" IS 'Water temperature in degrees Celsius';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."SPEC" IS 'Species research code';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."FSHNO" IS 'Individual fish number';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."FWT" IS 'Fish weight in grams';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."FLEN" IS 'Fish fork length in centimetres';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."TECH" IS 'Stomach analysis tech';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."STOWGT" IS 'Total stomach weight incl. contents in grams';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."EMPTYWGT" IS 'Empty stomach weight in grams';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."FULLNESS" IS 'Stomach fullness code';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PREYITEM" IS 'prey item';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PREYSPECCD" IS 'Prey species research code';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PREYSPEC" IS 'prey species';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PWT" IS 'Prey weight in grams';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PNUM" IS 'number of prey';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."PLEN" IS 'Prey length in centimetres';
 
   COMMENT ON COLUMN "GROUNDFISH"."SDVIEW1"."REMARKS" IS 'remarks';
 
   COMMENT ON TABLE "GROUNDFISH"."SDVIEW1"  IS 'Consolidated Stomach Data View';
