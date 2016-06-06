--------------------------------------------------------
--  DDL for View ECOSYSTEM_SURVEY_LEN10CM_WMS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."ECOSYSTEM_SURVEY_LEN10CM_WMS" ("INSTITUTIONCODE", "COLLECTIONCODE", "CATALOGNUMBER", "FIELDNUMBER", "COLLECTOR", "YEARCOLLECTED", "MONTHCOLLECTED", "DAYCOLLECTED", "TIMEOFDAY", "STARTYEARCOLLECTED", "STARTMONTHCOLLECTED", "STARTDAYCOLLECTED", "STARTTIMEOFDAY", "ENDYEARCOLLECTED", "ENDMONTHCOLLECTED", "ENDDAYCOLLECTED", "ENDTIMEOFDAY", "CONTINENTOCEAN", "LOCALITY", "STARTLATITUDE", "STARTLONGITUDE", "ENDLATITUDE", "ENDLONGITUDE", "LATITUDE", "LONGITUDE", "LON05", "LON10", "LON20", "LON30", "LAT05", "LAT10", "LAT20", "LAT30", "MINIMUMDEPTH", "MAXIMUMDEPTH", "TEMPERATURE", "SAMPLESIZE", "OBSERVEDINDIVIDUALCOUNT", "SCIENTIFICNAME", "KINGDOM_", "PHYLUM_", "CLASS_", "ORDER_", "FAMILY_", "GENUS_", "SPECIES_", "ACCEPTED_AUTHOR", "SUBSPECIES_", "SUBGENUS", "BASISOFRECORD", "COUNTRY", "GIVEN_SPEC_CODE", "COMMONNAME", "FRENCHCOMMONNAME", "FAO_CODE", "TSN", "GEAR", "GEARDESCRIPTION", "TARGETSPECIES", "SPECIES", "MISSION", "SETNO", "DECADE", "LENCLASS10CM") AS 
  SELECT   'BIO' AS institutioncode, collectioncode, catalognumber,
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
            lon05, lon10, lon20, lon30, lat05, lat10, lat20, lat30,
            minimumdepth, maximumdepth, temperature, samplesize,
            stdclen observedindividualcount,
            
             /*
            -- names
            */
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
            
/*
-- non-standard fields follow
*/
            'O' AS basisofrecord,           -- fisheries data               --
            'CANADA' country,
                                            -- orginating country of vessel --
/*
-- new fields...
*/
            b.given_spec_code,
            CASE
               WHEN b.given_spec_code IS NOT NULL
                  THEN NVL (b.fao_e_common_name,
                            given_common_name
                           )
               WHEN i.species > 0
                  THEN 'Unidentified - ' || i.species
            END AS commonname,
            COALESCE (v.nom_commun_esp_f,
                      b.fao_f_common_name
                     ) frenchcommonname,
            b.fao_code, b.accepted_tsn tsn, i.gear, geardescription,         --
            ' ' targetspecies, species, i.mission, i.setno,
                                                           --     i.lenclass,
            decade,
            lenclass10cm
   FROM     (                             -- groundfish.obis_groundfish_adj_lf
             SELECT   m.fk_series_id AS collectioncode,
                         i.mission
                      || '-'
                      || i.setno
                      || '-'
                      || cat.spec
                                 /* Size class removed as we combine the size class samples */
                      AS catalognumber,
                      i.mission || '-' || i.setno AS fieldnumber,
                      m.vesel AS collector, i.sdate, i.etime,
                      strat AS locality, i.sla startlatitude,
                      i.slo startlongitude, i.ela endlatitude,
                      i.elo endlongitude,
                      (i.sla + NVL (i.ela, i.sla)) / 2 AS latitude,
                      (i.slo + NVL (i.elo, i.slo)) / 2 AS longitude,
                          TRUNC ((i.slo + NVL (i.elo, i.slo)) / 2 * 60 / 05.
                                )
                        / (60 / 05.)
                      - (05 / 120.) lon05,
                          TRUNC ((i.slo + NVL (i.elo, i.slo)) / 2 * 60 / 10.
                                )
                        / (60 / 10.)
                      - (10 / 120.) lon10,
                          TRUNC ((i.slo + NVL (i.elo, i.slo)) / 2 * 60 / 20.
                                )
                        / (60 / 20.)
                      - (20 / 120.) lon20,
                          TRUNC ((i.slo + NVL (i.elo, i.slo)) / 2 * 60 / 30.
                                )
                        / (60 / 30.)
                      - (30 / 120.) lon30,
                          TRUNC ((i.sla + NVL (i.ela, i.sla)) / 2 * 60 / 05.
                                )
                        / (60 / 05.)
                      + (05 / 120.) lat05,
                          TRUNC ((i.sla + NVL (i.ela, i.sla)) / 2 * 60 / 10.
                                )
                        / (60 / 10.)
                      + (10 / 120.) lat10,
                          TRUNC ((i.sla + NVL (i.ela, i.sla)) / 2 * 60 / 20.
                                )
                        / (60 / 20.)
                      + (20 / 120.) lat20,
                          TRUNC ((i.sla + NVL (i.ela, i.sla)) / 2 * 60 / 30.
                                )
                        / (60 / 30.)
                      + (30 / 120.) lat30,
                      i.dmin minimumdepth, i.dmax maximumdepth,
                      NVL (i.bottom_temperature, hyd.bottom_temp) temperature,
                      i.dist || ' n.miles * ' samplesize, i.gear,
                      g.geardesc geardescription, a.mission, a.setno,
                      a.spec species,
                      
                        --
                        TRUNC (TO_NUMBER (TO_CHAR (i.sdate, 'yyyy')) / 10
                              )
                      * 10 decade,
                      
                        /*  DECODE (s.lgrp,
                                  1, d.flen,
                                  2, .5 + FLOOR (d.flen / 2) * 2,
                                  3, 1 + FLOOR (d.flen / 3) * 3
                                 ) lenclass, */
                        TRUNC (  DECODE (s.lgrp,
                                         1, d.flen,
                                         2, .5 + FLOOR (d.flen / 2) * 2,
                                         3, 1 + FLOOR (d.flen / 3) * 3
                                        )
                               / 10
                              )
                      * 10 lenclass10cm,
                      
                      /* adjust count at length for subsampling and distance towed */
                      SUM (  d.clen
                           * DECODE (NVL (a.totwgt, 0),
                                     0, 1,
                                     DECODE (NVL (a.sampwgt, 0),
                                             0, 1,
                                             a.totwgt / a.sampwgt
                                            )
                                    )
                           * 1.75
                           / i.dist
                          ) stdclen
             FROM     (SELECT gsinf.*,
                                -1
                              * ROUND (  TRUNC (slong / 100)
                                       + MOD (slong, 100) / 60,
                                       5
                                      ) slo,
                              ROUND (TRUNC (slat / 100) + MOD (slat, 100) / 60,
                                     5
                                    ) sla,
                                -1
                              * ROUND (  TRUNC (elong / 100)
                                       + MOD (elong, 100) / 60,
                                       5
                                      ) elo,
                              ROUND (TRUNC (elat / 100) + MOD (elat, 100) / 60,
                                     5
                                    ) ela
                       FROM   groundfish.gsinf
                       WHERE  TYPE IN (1, 5)) i
                      INNER JOIN
                      (SELECT   mission, setno, (spec)
                       FROM     groundfish.gscat
                       GROUP BY mission, setno, ROLLUP (spec)) cat
                      ON i.mission = cat.mission AND i.setno = cat.setno
                      --
                      LEFT OUTER JOIN
                      (SELECT a.*
                       FROM   groundfish.gscat a
                       WHERE  spec IN (10, 11, 16, 23, 42, 60)
/* Cod, Haddock, Pollock, Redfish unseparated, yellowtail flounder, herring (atlantic) */
                      ) a
                      ON  a.mission = cat.mission
                      AND a.setno = cat.setno
                      AND a.spec = cat.spec
                      --
                      LEFT OUTER JOIN groundfish.gsdet d
                      ON  d.mission = cat.mission
                      AND d.setno = cat.setno
                      AND d.spec = cat.spec
                      --
                      LEFT OUTER JOIN
                      (SELECT   mission, setno, AVG (temp) bottom_temp
                       FROM     groundfish.gshyd
                       WHERE    bid = 'B'
                       GROUP BY mission, setno) hyd
                      ON i.mission = hyd.mission AND i.setno = hyd.setno
                      --
                      INNER JOIN groundfish.gsgear g ON i.gear = g.gear
                      INNER JOIN
                      (SELECT m.*
                       FROM   gsmission_list m
                       WHERE  m.fk_series_id IN ('SUMMER', 'SUMMER_TELEOST')) m
                      ON m.pk_mission = i.mission
                      INNER JOIN groundfish.gsspec s ON a.spec = s.spec
             --
             GROUP BY m.fk_series_id,
                      i.mission || '-' || i.setno || '-' || cat.spec,
                      i.mission || '-' || i.setno,
                      m.vesel,
                      i.sdate,
                      i.etime,
                      strat,
                      i.sla,
                      i.slo,
                      i.ela,
                      i.elo,
                      (i.sla + NVL (i.ela, i.sla)) / 2,
                      (i.slo + NVL (i.elo, i.slo)
                      ) / 2,
                      i.dmin,
                      i.dmax,
                      NVL (i.bottom_temperature, hyd.bottom_temp),
                      i.dist || ' n.miles * ',
                      i.gear,
                      g.geardesc,
                      a.mission,
                      a.setno,
                      a.spec,
                      TRUNC (TO_NUMBER (TO_CHAR (i.sdate, 'yyyy')) / 10) * 10,
                        /* DECODE (s.lgrp,
                                 1, d.flen,
                                 2, .5 + FLOOR (d.flen / 2) * 2,
                                 3, 1 + FLOOR (d.flen / 3) * 3
                                ), */
                        TRUNC (  DECODE (s.lgrp,
                                         1, d.flen,
                                         2, .5 + FLOOR (d.flen / 2) * 2,
                                         3, 1 + FLOOR (d.flen / 3) * 3
                                        )
                               / 10
                              )
                      * 10) i
            LEFT OUTER JOIN
            groundfish.itis_gs_taxon b ON i.species = b.given_spec_code
            LEFT OUTER JOIN digirdev.espece_general v
            ON b.given_scient_name = UPPER (v.nom_scient_esp)
   ORDER BY collectioncode, yearcollected, setno, species ;
 

   COMMENT ON TABLE "GROUNDFISH"."ECOSYSTEM_SURVEY_LEN10CM_WMS"  IS 'OBIS Schema style std counts at length from the SUMMER surveys for COD, HADDOCK, REDFISH UNSEPARATED,POLLOCK, HERRING and YELLOWTAIL FLOUNDER';
