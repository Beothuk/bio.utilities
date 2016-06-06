--------------------------------------------------------
--  DDL for View OBIS_PHYLUM
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."OBIS_PHYLUM" ("PHYLUM_") AS 
  select distinct phylum_ from obis_detail
;
