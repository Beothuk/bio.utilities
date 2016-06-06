--------------------------------------------------------
--  DDL for View OBIS_DETAIL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."OBIS_DETAIL" ("INSTITUTIONCODE", "COLLECTIONCODE", "CATALOGNUMBER", "FIELDNUMBER", "COLLECTOR", "YEARCOLLECTED", "MONTHCOLLECTED", "DAYCOLLECTED", "TIMEOFDAY", "STARTYEARCOLLECTED", "STARTMONTHCOLLECTED", "STARTDAYCOLLECTED", "STARTTIMEOFDAY", "ENDYEARCOLLECTED", "ENDMONTHCOLLECTED", "ENDDAYCOLLECTED", "ENDTIMEOFDAY", "CONTINENTOCEAN", "LOCALITY", "STARTLATITUDE", "STARTLONGITUDE", "ENDLATITUDE", "ENDLONGITUDE", "LATITUDE", "LONGITUDE", "MINIMUMDEPTH", "MAXIMUMDEPTH", "TEMPERATURE", "SAMPLESIZE", "SCIENTIFICNAME", "KINGDOM_", "PHYLUM_", "CLASS_", "ORDER_", "FAMILY_", "GENUS_", "SPECIES_", "ACCEPTED_AUTHOR", "SUBSPECIES_", "SUBGENUS", "OBSERVEDWEIGHT", "OBSERVEDINDIVIDUALCOUNT", "BASISOFRECORD", "COUNTRY", "GIVEN_SPEC_CODE", "COMMONNAME", "FAO_CODE", "TSN", "GEAR", "GEARDESCRIPTION", "TARGETSPECIES", "SPECIES", "MINIMUMSIZE", "MAXIMUMSIZE", "AVERAGESIZE", "KEY1", "KEY2") AS 
  select 'BIO' AS InstitutionCode,
       CollectionCode,
	   CatalogNumber,
	   FieldNumber,
	   collector,
       to_char(i.sdate,'yyyy') YearCollected,
       to_char(i.sdate,'mm') MonthCollected,
       to_char(i.sdate,'dd') DayCollected,
       to_char(i.sdate,'hh24:mi') TimeOfDay,
       to_char(i.sdate,'yyyy') startYearCollected,
       to_char(i.sdate,'mm') startMonthCollected,
       to_char(i.sdate,'dd') startDayCollected,
       to_char(i.sdate,'hh24:mi') startTimeOfDay,
       to_char(i.etime,'yyyy') endYearCollected,
       to_char(i.etime,'mm') endMonthCollected,
       to_char(i.etime,'dd') endDayCollected,
       to_char(i.etime,'hh24:mi') endTimeOfDay,
       'Atlantic' AS ContinentOcean,
       locality,
	   StartLatitude,
	   StartLongitude,
	   EndLatitude,
	   EndLongitude,
       Latitude,
       Longitude,
       MinimumDepth,
       MaximumDepth,
       Temperature,
       samplesize,
--
-- names
--	    		  
	   case 
	   when b.Given_spec_code is not null then NVL(b.accepted_scient_name,b.given_scient_name) 
	   when i.species > 0 then 'Unidentified - '|| i.species 
	   end AS ScientificName,
       b.kingdom_,
	   b.phylum_,
	   b.class_,
	   b.order_,
	   b.family_,
	   b.genus_,
	   b.species_,
	   b.ACCEPTED_AUTHOR,
	   b.subspecies_,
	   b.subgenus,
	   ObservedWeight,
--
-- 	ObservedIndividualCount is available where fish are counted otherwise estimated from sampling data if avaialable  
--
       ObservedIndividualCount,
--
-- non-standard fields follow 
--
       'F' AS BasisofRecord,   -- fisheries data               --
       'CANADA' country,       -- orginating country of vessel --
--
-- new fields...
--	   
       b.Given_spec_code,
	   case 
	   when b.Given_spec_code is not null then NVL(b.FAO_E_Common_Name, Given_Common_Name)
	   when i.species > 0 then 'Unidentified - '|| i.species 
	   end AS CommonName,
	   b.FAO_code,
	   b.Accepted_TSN tsn,   
--	   e.vesseltype,
	   i.gear, 
	   geardescription,
--	   							
	   ' ' targetSpecies,
	   species,
 	   MINIMUMSIZE,
 	   MAXIMUMSIZE,
 	   AVERAGESIZE,
		i.MISSION key1, 
		i.setno key2
from 
	 groundfish.obis_groundfish i
     LEFT OUTER JOIN
     groundfish.itis_gs_taxon b
     ON i.species=b.given_spec_code
;
