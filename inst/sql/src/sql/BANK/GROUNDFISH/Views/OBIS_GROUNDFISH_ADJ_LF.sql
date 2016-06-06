--------------------------------------------------------
--  DDL for View OBIS_GROUNDFISH_ADJ_LF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."OBIS_GROUNDFISH_ADJ_LF" ("COLLECTIONCODE", "CATALOGNUMBER", "FIELDNUMBER", "COLLECTOR", "SDATE", "ETIME", "LOCALITY", "STARTLATITUDE", "STARTLONGITUDE", "ENDLATITUDE", "ENDLONGITUDE", "LATITUDE", "LONGITUDE", "MINIMUMDEPTH", "MAXIMUMDEPTH", "TEMPERATURE", "SAMPLESIZE", "GEAR", "GEARDESCRIPTION", "MISSION", "SETNO", "SPECIES", "LENCLASS", "STDCLEN") AS 
  SELECT m.fk_series_id AS collectioncode,
          i.mission
                 || '-'
                 || i.setno
                 || '-'
                 || cat.spec
            --     || '-'
             --    || a.size_class,   /* Size class removed as we combine the size class samples */
                 AS catalognumber,    
--    'PopulatiON Ecology Division, DFO Maritimes Industry Surveys Data Base, '||TO_CHAR(sysdate,'YYYY-MM-DD')||', Bedford Institute of Oceanography' AS Citation,
          i.mission || '-' || i.setno AS fieldnumber, 
          m.vesel AS collector,
          i.sdate, 
          i.etime, 
          strat AS locality, 
          i.sla startlatitude,
          i.slo startlongitude, 
          i.ela endlatitude, 
          i.elo endlongitude,
          (i.sla + NVL (i.ela, i.sla)) / 2 AS latitude,
          (i.slo + NVL (i.elo, i.slo)) / 2 AS longitude, 
          i.dmin minimumdepth,
          i.dmax maximumdepth,
          NVL (i.bottom_temperature, hyd.bottom_temp) temperature,
          i.dist || ' n.miles * ' samplesize,
          i.gear,
          g.geardesc geardescription,
--
          a.mission, 
          a.setno, 
          a.spec species,
          DECODE(s.lgrp,1,d.flen,2,.5+FLOOR(d.flen/2)*2,3, 1+FLOOR(d.flen/3)*3 ) lenclass,
          /* adjust count at length for subsampling and distance towed */ 
          sum(d.clen * DECODE(NVL(a.totwgt,0),0,1,DECODE(NVL(a.sampwgt,0),0,1,a.totwgt/a.sampwgt))* 1.75/i.dist)  stdclen
   FROM   (SELECT gsinf.*,
             -1 * ROUND (TRUNC (slong / 100) + MOD (slong, 100) / 60, 5) slo,
                  ROUND (TRUNC (slat / 100) + MOD (slat, 100) / 60, 5) sla,
             -1 * ROUND (TRUNC (elong / 100) + MOD (elong, 100) / 60, 5) elo,
                  ROUND (TRUNC (elat / 100) + MOD (elat, 100) / 60, 5) ela
           FROM   groundfish.gsinf
           WHERE type in (1,5)) i
          INNER JOIN
          (SELECT   mission, setno, (spec)
           FROM     groundfish.gscat
           GROUP BY mission, setno, ROLLUP (spec)) cat
          ON i.mission = cat.mission AND i.setno = cat.setno
          --
          LEFT OUTER JOIN groundfish.gscat a
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
          INNER JOIN gsmission_list m ON m.pk_mission = i.mission
          INNER JOIN groundfish.gsspec s ON a.spec = s.spec
      --
  GROUP BY m.fk_series_id,
          i.mission
                 || '-'
                 || i.setno
                 || '-'
                 || cat.spec,   
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
          (i.slo + NVL (i.elo, i.slo)) / 2, 
          i.dmin,
          i.dmax,
          NVL (i.bottom_temperature, hyd.bottom_temp),
          i.dist || ' n.miles * ',
          i.gear,
          g.geardesc,
          a.mission, 
          a.setno, 
          a.spec,
          DECODE(s.lgrp,1,d.flen,2,.5+FLOOR(d.flen/2)*2,3, 1+FLOOR(d.flen/3)*3 ) ;
