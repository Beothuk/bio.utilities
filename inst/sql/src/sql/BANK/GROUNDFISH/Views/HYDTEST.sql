--------------------------------------------------------
--  DDL for View HYDTEST
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."HYDTEST" ("MISSION", "SETNO", "SDEPTH", "BID", "NUM") AS 
  (select b.mission,b.setno,b.sdepth,b.BID, count(1) num
from gshyd b
where BID is not null and mission is not null
group by mission,setno,sdepth,BID
having count(1)>1)
;
