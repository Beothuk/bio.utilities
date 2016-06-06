--------------------------------------------------------
--  DDL for View SD_MEL_AREAS_COD
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."SD_MEL_AREAS_COD" ("YEAR", "STRAT", "AREA", "NAFO", "REGION", "SPEC", "COUNT") AS 
  select distinct to_char(i.sdate, 'YYYY') year, i.strat, i.area, d.nafo,
decode(i.area,'431','4T','432','4T',
'440','4Vn','441','4Vn','442','4Vn',
'452','4Vs','453','4Vs','460','4W',
'461','4W','462','4W','463','4W','464','4W',
'465','4W', '466','4W','467','4W','468','4W','469','4W','471','4X','472','4X','473','4X',
'474','4X','475','4X','476','4X','477','4X',
'511','5YZ','515','5YZ','521','5YZ','522','5YZ',
'523','5YZ','524','5YZ','525','5YZ',
'526','5YZ','999') region,
d.spec, count(*) count
from groundfish.sdview_newdata d, groundfish.gsinf i, mflib.gs_survey_list b
where d.mission=i.mission and d.mission=b.mission and series='SUMMER' 
and d.spec=10 and d.setno=i.setno
group by to_char(i.sdate, 'YYYY'), i.strat, area, nafo, decode(i.area,'431','4T','432','4T',
'440','4Vn','441','4Vn','442','4Vn',
'452','4Vs','453','4Vs','460','4W',
'461','4W','462','4W','463','4W','464','4W',
'465','4W', '466','4W','467','4W','468','4W','469','4W','471','4X','472','4X','473','4X',
'474','4X','475','4X','476','4X','477','4X',
'511','5YZ','515','5YZ','521','5YZ','522','5YZ',
'523','5YZ','524','5YZ','525','5YZ',
'526','5YZ','999') , spec
;
