--------------------------------------------------------
--  DDL for View OBIS_GROUNDFISH
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "GROUNDFISH"."OBIS_GROUNDFISH" ("COLLECTIONCODE", "CATALOGNUMBER", "FIELDNUMBER", "COLLECTOR", "SDATE", "ETIME", "LOCALITY", "STARTLATITUDE", "STARTLONGITUDE", "ENDLATITUDE", "ENDLONGITUDE", "LATITUDE", "LONGITUDE", "MINIMUMDEPTH", "MAXIMUMDEPTH", "TEMPERATURE", "SAMPLESIZE", "OBSERVEDWEIGHT", "OBSERVEDINDIVIDUALCOUNT", "GEAR", "GEARDESCRIPTION", "MISSION", "SETNO", "SPECIES", "MINIMUMSIZE", "MAXIMUMSIZE", "AVERAGESIZE") AS 
  select M.FK_SERIES_ID AS CollectionCode,
	   RTRIM(i.MISSION ||'-'|| i.setno || '-' || cat.spec || '-' || a.size_class,'-') AS CatalogNumber,
--    'PopulatiON Ecology Division, DFO Maritimes Industry Surveys Data Base, '||TO_CHAR(sysdate,'YYYY-MM-DD')||', Bedford Institute of Oceanography' AS Citation, 
	   i.MISSION ||'-'|| i.setno AS FieldNumber,
	   m.vesel as collector,
       i.sdate,
	   i.etime,
       strat AS locality,
	   i.SLA StartLatitude,
	   i.SLO StartLongitude,
	   i.ELA EndLatitude,
	   i.ELO EndLongitude,
       (i.SLA + NVL(i.ELA,i.SLA))/2 Latitude,
       (i.SLO + NVL(i.ELO,i.SLO))/2 Longitude,
       i.dmin MinimumDepth,
       i.dmax MaximumDepth,
       nvl(i.bottom_temperature, hyd.bottom_temp) Temperature,
       case g.geardesc
       when 'Western IIA trawl'
       then i.dist || ' n.miles * 41.0 ft'
       when 'Yankee #36 otter trawl'
       then i.dist || ' n.miles * 36.0 ft'
       end samplesize,
	   NVL(decode(a.sampwgt, 0, a.totwgt, a.sampwgt),0) AS ObservedWeight,
--
-- 	ObservedIndividualCount is available where fish are counted otherwise estimated from sampling data if avaialable  
--
       NVL(a.totno,0) AS ObservedIndividualCount,
--	   e.vesseltype,
	   i.gear, 
	   g.geardesc geardescription,
--	   							
		a.MISSION, 
		a.setno,
		a.spec species,

 	   NVL(d.MINIMUMSIZE,0) MINIMUMSIZE,
 	   NVL(d.MAXIMUMSIZE,0) MAXIMUMSIZE,
 	   NVL(d.AVERAGESIZE,0) AVERAGESIZE
from 
	 (select gsinf.*,		   
			-1*round(TRUNC(SLONG/100)+MOD(SLONG,100)/60,5) SLO,
			round(TRUNC(SLAT/100)+MOD(SLAT,100)/60,5) SLA,
			-1*round(TRUNC(ELONG/100)+MOD(ELONG,100)/60,5) ELO,
			round(TRUNC(ELAT/100)+MOD(ELAT,100)/60,5) ELA
	  from groundfish.gsinf
	  ) i  
     INNER JOIN
     (select  mission, setno, (spec) from groundfish.gscat
	  group by mission, setno, rollup(spec)
	  ) cat
     ON i.mission=cat.mission and i.setno=cat.setno
	 left outer join											
     groundfish.gscat a
	 on a.mission = cat.mission and a.setno = cat.setno and a.spec = cat.spec 
     LEFT OUTER JOIN	 
	 groundfish.gsdet_lens d
     ON i.mission=d.mission and i.setno=d.setno and cat.spec=d.spec
	 LEFT OUTER JOIN
	 (select mission, setno, avg(temp) bottom_temp from groundfish.gshyd where bid='B' group by mission, setno) hyd 
	 on i.mission=hyd.mission and i.setno=hyd.setno 
     INNER JOIN
     (select * from groundfish.gsgear where geardesc in ('Western IIA trawl','Yankee #36 otter trawl')) g
     ON i.gear = g.gear
     INNER JOIN
     GSMISSION_LIST M
	 ON M.PK_MISSION=I.MISSION;
