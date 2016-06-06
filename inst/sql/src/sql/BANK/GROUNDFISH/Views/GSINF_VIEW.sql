--------------------------------------------------------
--  DDL for View GSINF_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSINF_VIEW" ("MISSION", "SETNO", "SDATE", "TIME", "STRAT", "SLAT", "SLONG", "ELAT", "ELONG", "AREA", "DUR", "DIST", "HOWD", "SPEED", "HOWS", "DMIN", "DMAX", "WIND", "FORCE", "CURNT", "TYPE", "GEAR", "AUX", "DEPTH", "ETIME", "REMARKS", "START_DEPTH", "END_DEPTH", "SURFACE_TEMPERATURE", "SURFACE_SALINITY", "BOTTOM_TEMPERATURE", "BOTTOM_SALINITY") AS 
  SELECT i.mission, i.setno, i.sdate, i.time, i.strat, i.slat, i.slong, i.elat, i.elong, i.area, i.dur,
       i.dist, i.howd, i.speed, i.hows, i.dmin, i.dmax, i.wind, i.force, i.curnt, i.type, i.gear, i.aux,
       i.depth, i.etime, i.remarks, i.start_depth, i.end_depth,
       get_hyd_val(i.mission,i.setno,'S','T') surface_temperature,
       get_hyd_val(i.mission,i.setno,'S','S') surface_salinity,
    get_hyd_val(i.mission,i.setno,'B','T') bottom_temperature,
    get_hyd_val(i.mission,i.setno,'B','S') bottom_salinity
  FROM  gsinf i
;
