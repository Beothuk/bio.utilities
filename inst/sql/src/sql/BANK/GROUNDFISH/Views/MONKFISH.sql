--------------------------------------------------------
--  DDL for View MONKFISH
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MONKFISH" ("MISSION", "SETNO", "SPEC", "MARKET", "SAMPWGT", "TOTWGT", "TOTNO", "CALWT", "REMARKS", "SIZE_CLASS") AS 
  SELECT "MISSION","SETNO","SPEC","MARKET","SAMPWGT","TOTWGT","TOTNO","CALWT","REMARKS","SIZE_CLASS" FROM GSCAT WHERE SPEC=400
;
