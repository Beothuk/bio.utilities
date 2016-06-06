--------------------------------------------------------
--  DDL for View USGMBIS_MEASUREMENT_TYPE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."USGMBIS_MEASUREMENT_TYPE" ("ID", "Sensor Type", "Measurement Type", "Measurement Name", "Measurement Description", "Measurement Units", "Measurement Minimum", "Measurement Maximum", "Measurement Offset", "Measurement Slope") AS 
  SELECT "Species Number"*100+1 id, 1 "Sensor Type", "Species Number"*100+1 "Measurement Type",
       fao||'_no' "Measurement Name", "Common Species Name"||'_no' "Measurement Description",
       'COUNT/STANDARD TOW' "Measurement Units",
       FLOOR(0) "Measurement Minimum", FLOOR(0) "Measurement Maximum", 0 "Measurement Offset", 0 "Measurement Slope"
  FROM usgmbis_species
UNION
SELECT "Species Number"*100+2, 1, "Species Number"*100+2,
       fao||'_wgt', "Common Species Name"||'_wgt', 'KILOGRAMS/STANDARD TOW', 0, 0, 0, 0
  FROM usgmbis_species
UNION
SELECT 1, 1, 1, 'BTEMP', 'BOTTOM TEMPERATURE'  , 'DEG C', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 2, 1, 2, 'BSAL' , 'BOTTOM SALINITY'     , 'PPT', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 3, 1, 3, 'STEMP', 'SURFACE TEMPERATURE' , 'DEG C', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 4, 1, 4, 'SSAL' , 'SURFACE SALINITY'    ,'PPT', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 5, 1, 5, 'TEMP' , 'TEMPERATURE AT DEPTH', 'DEG C', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 6, 1, 6, 'SAL'  , 'SALINITY AT DEPTH'   , 'PPT', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 7, 1, 7, 'OXY'  , 'OXYGEN AT DEPTH'     , 'ML', 0, 0, 0, 0 FROM DUAL
UNION
SELECT 8, 9999, -1, 'CHL'  , 'CHLOROPHYLL'     , 'MG/M3', -32768, 32767, 0, 1 FROM DUAL
UNION
SELECT 9, 9999, -2, 'SST'  , 'SEA SURFACE TEMP', 'DEG C', 0, 255, 0, 1 FROM DUAL
UNION
SELECT 10, 9999, -3, 'SURFACE VECTORS'  , 'SURFACE VECTORS', 'M/SEC', 0, 255, 0, .001 FROM DUAL
UNION
SELECT 11, 9999, -4, 'BOTTOM VECTORS'  , 'BOTTOM VECTORS', 'M/SEC', 0, 255, 0, .001 FROM DUAL

;
