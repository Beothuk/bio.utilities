--------------------------------------------------------
--  DDL for View CDN_GOM_INF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."CDN_GOM_INF" ("MISSION", "SETNO", "SLAT", "SLONG", "SDATE", "DEPTH", "DIST", "SSAL", "STEMP", "BTEMP", "BSAL") AS 
  select mission, setno, ROUND(TRUNC((SLAT/100),0) + ((MOD(SLAT,100))/60),4) SLAT ,
       (ROUND((TRUNC((SLONG/100),0) + (MOD(SLONG,100))/60),4))* -1 SLONG,
       substr(to_char (sdate,'YYYY/MM/DD HH24:MI'),1,18) sdate, Depth, Dist,
        NULL SSAL, SURFACE_TEMPERATURE STEMP, BOTTOM_TEMPERATURE  BTEMP, BOTTOM_SALINITY BSAL
  FROM gsinf
  where (mission, setno) IN
    (select mission, setno from gsinf where strat in
                              (select strat from gsstratum where name like '4X%' or name like '5Z'))
;
