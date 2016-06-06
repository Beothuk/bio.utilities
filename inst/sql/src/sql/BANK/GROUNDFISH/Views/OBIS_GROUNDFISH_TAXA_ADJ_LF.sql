--------------------------------------------------------
--  DDL for View OBIS_GROUNDFISH_TAXA_ADJ_LF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."OBIS_GROUNDFISH_TAXA_ADJ_LF" ("INSTITUTIONCODE", "COLLECTIONCODE", "CATALOGNUMBER", "FIELDNUMBER", "COLLECTOR", "YEARCOLLECTED", "MONTHCOLLECTED", "DAYCOLLECTED", "TIMEOFDAY", "STARTYEARCOLLECTED", "STARTMONTHCOLLECTED", "STARTDAYCOLLECTED", "STARTTIMEOFDAY", "ENDYEARCOLLECTED", "ENDMONTHCOLLECTED", "ENDDAYCOLLECTED", "ENDTIMEOFDAY", "CONTINENTOCEAN", "LOCALITY", "STARTLATITUDE", "STARTLONGITUDE", "ENDLATITUDE", "ENDLONGITUDE", "LATITUDE", "LONGITUDE", "MINIMUMDEPTH", "MAXIMUMDEPTH", "TEMPERATURE", "SAMPLESIZE", "SCIENTIFICNAME", "KINGDOM_", "PHYLUM_", "CLASS_", "ORDER_", "FAMILY_", "GENUS_", "SPECIES_", "ACCEPTED_AUTHOR", "SUBSPECIES_", "SUBGENUS", "LENCLASS", "STDCLEN", "BASISOFRECORD", "COUNTRY", "GIVEN_SPEC_CODE", "COMMONNAME", "FAO_CODE", "TSN", "GEAR", "GEARDESCRIPTION", "TARGETSPECIES", "SPECIES", "MISSION", "SETNO") AS 
  SELECT 'BIO' AS institutioncode, collectioncode, catalognumber,
          fieldnumber, collector, TO_CHAR (i.sdate, 'yyyy') yearcollected,
          TO_CHAR (i.sdate, 'mm') monthcollected,
          TO_CHAR (i.sdate, 'dd') daycollected,
          TO_CHAR (i.sdate, 'hh24:mi') timeofday,
          TO_CHAR (i.sdate, 'yyyy') startyearcollected,
          TO_CHAR (i.sdate, 'mm') startmonthcollected,
          TO_CHAR (i.sdate, 'dd') startdaycollected,
          TO_CHAR (i.sdate, 'hh24:mi') starttimeofday,
          TO_CHAR (i.etime, 'yyyy') endyearcollected,
          TO_CHAR (i.etime, 'mm') endmonthcollected,
          TO_CHAR (i.etime, 'dd') enddaycollected,
          TO_CHAR (i.etime, 'hh24:mi') endtimeofday,
          'Atlantic' AS continentocean, locality, startlatitude,
          startlongitude, endlatitude, endlongitude, latitude, longitude,
          minimumdepth, maximumdepth, temperature, samplesize,
--
-- names
--
          CASE
             WHEN b.given_spec_code IS NOT NULL
                THEN NVL (b.accepted_scient_name,
                          b.given_scient_name
                         )
             WHEN i.species > 0
                THEN 'Unidentified - ' || i.species
          END AS scientificname,
          b.kingdom_, b.phylum_, b.class_, b.order_, b.family_, b.genus_,
          b.species_, b.accepted_author, b.subspecies_, b.subgenus,
          i.lenclass,
          i.stdclen,
--
-- non-standard fields follow
--
          'F' AS basisofrecord,  -- fisheries data               --
          'CANADA' country,  -- orginating country of vessel --
--
-- new fields...
--
          b.given_spec_code,
          CASE
             WHEN b.given_spec_code IS NOT NULL
                THEN NVL (b.fao_e_common_name,
                          given_common_name
                         )
             WHEN i.species > 0
                THEN 'Unidentified - ' || i.species
          END AS commonname,
          b.fao_code, b.accepted_tsn tsn,
          i.gear, geardescription,
--
          ' ' targetspecies, species,
          i.mission, i.setno
   FROM   groundfish.obis_groundfish_adj_lf i LEFT OUTER JOIN groundfish.itis_gs_taxon b
          ON i.species = b.given_spec_code ;
