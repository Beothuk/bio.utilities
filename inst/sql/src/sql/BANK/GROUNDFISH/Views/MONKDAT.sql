--------------------------------------------------------
--  DDL for View MONKDAT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MONKDAT" ("MISSION", "SETNO", "SDATE", "TIME", "STRAT", "SLAT", "SLONG", "AREA", "DIST", "DMIN", "DMAX", "SPEC", "TOTNO", "TOTWGT") AS 
  SELECT A.MISSION,A.SETNO,A.SDATE,A.TIME,A.STRAT,A.SLAT,A.SLONG,A.AREA,A.DIST,A.DMIN,A.DMAX,
B.SPEC,B.TOTNO,B.TOTWGT FROM GSINF A,MONKFISH B
WHERE A.MISSION=B.MISSION(+) AND A.SETNO=B.SETNO(+) AND A.TYPE=1
;
