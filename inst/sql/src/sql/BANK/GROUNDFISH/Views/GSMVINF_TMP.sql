--------------------------------------------------------
--  DDL for View GSMVINF_TMP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSMVINF_TMP" ("MISSION", "SETNO", "SDATE", "TIME", "STRAT", "SLAT", "SLONG", "ELAT", "ELONG", "AREA", "DUR", "DIST", "HOWD", "SPEED", "HOWS", "DMIN", "DMAX", "WIND", "FORCE", "CURNT", "TYPE", "GEAR", "AUX", "DEPTH", "ETIME", "SURFACE_TEMPERATURE", "SURFACE_SALINITY", "BOTTOM_TEMPERATURE", "BOTTOM_SALINITY") AS 
  SELECT MISSION, SETNO, SDATE, TIME, STRAT, SLAT, SLONG, ELAT, ELONG, AREA, DUR, DIST, HOWD, SPEED, HOWS, DMIN, DMAX,  WIND, FORCE, CURNT, TYPE, GEAR, AUX, DEPTH, ETIME,  get_hyd_val(mission, setno,'S','T') SURFACE_TEMPERATURE,  get_hyd_val(mission, setno,'S','S') SURFACE_SALINITY,  get_hyd_val(mission, setno,'B','T')  BOTTOM_TEMPERATURE,  get_hyd_val(mission, setno,'B','S') BOTTOM_SALINITY   FROM gsinf;
