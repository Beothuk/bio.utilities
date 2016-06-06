--------------------------------------------------------
--  DDL for View MESOPELAGIC_ORDERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MESOPELAGIC_ORDERS" ("ORDERNAME") AS 
  select distinct ORDERNAME
from groundfish.mesopelagic_vw
WHERE ORDERNAME IS NOT NULL;
