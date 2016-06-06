--------------------------------------------------------
--  DDL for View GSMISSION_LIST
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."GSMISSION_LIST" ("PK_MISSION", "FK_SERIES_ID", "YEAR", "VESEL", "CRUNO", "SDATE", "EDATE", "SETS", "PURPOSE", "LOCALE", "DATASOURCE", "DATASTATUS", "DATALOCATION") AS 
  select "PK_MISSION","FK_SERIES_ID","YEAR","VESEL","CRUNO","SDATE","EDATE","SETS","PURPOSE","LOCALE","DATASOURCE","DATASTATUS","DATALOCATION" from nwags.gsmission_list
;
