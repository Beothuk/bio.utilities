--------------------------------------------------------
--  DDL for View MESOPELAGIC_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."MESOPELAGIC_VW" ("CRUISE", "STATION", "DAY", "MONTH", "YEAR", "SAMP_NO", "LATITUDE", "LONGITUDE", "GEAR", "TOW_TYPE", "START_HR", "SUR_TEMP", "DEPTHTOW", "TOW_TIME", "DEPTHBOT", "SP_CODE", "TSN", "KINGDOMNAME", "PHYLUMNAME", "CLASSNAME", "ORDERNAME", "FAMILYNAME", "GENUSNAME", "SPECIESNAME", "SCIENTIFICNAME", "COMMONNAME", "TOT_COT", "MIN_SIZE", "MAX_SIZE", "SP_STAGE", "SORTER") AS 
  select cruise, station, day, month, year, 
      samp_no,
       round(lat_deg+lat_min/60,5) latitude,
       round(-1*(lon_deg+lon_min/60),5) longitude,
	   decode(GEAR,11,'IYGPT',13,'Tucker',14,'Diamond IX',41,'Western IIA') gear, 
       decode(TOW_TYPE,1,'Stepped Oblique',2,'Continuous Oblique',3,'Horitzontal',5,'Bottom Trawl') tow_type, 
	   start_hr, sur_temp, depthtow, tow_time, depthbot,
       sp_code, accepted_tsn tsn,
       b.kingdom_ kingdomname,
       b.phylum_ phylumname,
       b.class_ classname,
       b.order_ ordername,
       b.family_ familyname, 
       b.genus_ genusname,
       b.species_ speciesname,
       coalesce(accepted_scient_name, given_scient_name) scientificname, 
       coalesce(b.fao_e_common_name,b.given_common_name) commonname,
       tot_cot, 
       min_size, 
       max_size, 
       sp_stage,
       full_name sorter
from groundfish.mesopelagic  a
     left outer join 
     groundfish.itis_mp_taxon  b
     on a.sp_code=b.given_spec_code 
     LEFT OUTER join
     groundfish.mesopelagic_sorter_codes  c
     on a.sorter = c.code;
